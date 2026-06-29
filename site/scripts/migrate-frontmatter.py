#!/usr/bin/env python3
"""
One-shot frontmatter migration: read each lesson .md under
/home/ubuntu/boxai4/lessons/<module>/, derive the same fields the old
site-lessons-fs loader did (title, summary, description, updatedDate,
readingMinutes), prepend a YAML frontmatter block, and write to
/home/ubuntu/boxai4/site/src/content/lessons/<module>/.

Preserves existing file content (H1, freshness date, body) — only ADDS a
frontmatter block at the top.

After running, `git mv` is used in a follow-up step (the script itself
just writes new files; we want the rename detection to be done by git).

Usage:
  python3 site/scripts/migrate-frontmatter.py

Run from the repo root.
"""

import re
import shutil
from pathlib import Path
import yaml

REPO = Path("/home/ubuntu/boxai4")
SRC = REPO / "lessons"
DST = REPO / "site" / "src" / "content" / "lessons"

MODULE_META = {
    "hermes": {
        "title": "Hermes Agent",
        "description": "The open-source AI harness for research, automation, and multi-channel workflows.",
        "order": 1,
        "accent": "#7c5cff",
    },
    "ai-models": {
        "title": "AI Model Comparison",
        "description": "Tier lists, the Anthropic family, Chinese open-weight, cost-efficient picks, and a decision framework.",
        "order": 2,
        "accent": "#0ea5a4",
    },
    "ai-projects": {
        "title": "New AI Projects",
        "description": "Coding with Claude Code, vibe vs real coding, niche directories, and the AI-business stack.",
        "order": 3,
        "accent": "#ea7a3b",
    },
}

MONTHS = [
    "january", "february", "march", "april", "may", "june",
    "july", "august", "september", "october", "november", "december",
]


def parse_lesson(md: str):
    """Replicates site/src/content.config.ts parseLesson logic."""
    lines = md.split("\n")
    title = ""
    updated_raw = None
    body_start = 0

    for i, line in enumerate(lines):
        if not title and line.startswith("# "):
            title = line[2:].strip()
            continue
        if line.startswith("**Last tested and updated:**"):
            updated_raw = line.replace("**Last tested and updated:**", "").strip()
            body_start = i + 1
            while body_start < len(lines):
                nxt = lines[body_start].strip()
                if nxt == "" or nxt == "---":
                    body_start += 1
                    continue
                break
            break

    updated_date = None
    if updated_raw:
        m = re.match(r"^([A-Za-z]+)\s+(\d{4})$", updated_raw)
        if m:
            month_name = m.group(1).lower()
            year = int(m.group(2))
            month_idx = MONTHS.index(month_name) if month_name in MONTHS else -1
            if month_idx >= 0:
                # First of the named month, UTC
                import datetime
                updated_date = datetime.date(year, month_idx + 1, 1)

    return title, updated_raw, updated_date


def derive_summary(body: str) -> str:
    lines = body.split("\n")
    for i, line in enumerate(lines):
        if line.startswith("## 1.") or line.startswith("## 2.") or line.startswith("## 3."):
            before = []
            for j in range(i - 1, -1, -1):
                bj = lines[j].strip()
                if not bj:
                    continue
                if bj.startswith("#"):
                    break
                before.insert(0, bj)
            summary = " ".join(before)[:280]
            if len(summary) == 280:
                summary += "…"
            return summary
    return ""


def derive_description(body: str, fallback: str) -> str:
    lines = body.split("\n")
    for raw in lines:
        line = raw.strip()
        if len(line) < 50:
            continue
        if (
            line.startswith("#")
            or line.startswith(">")
            or line.startswith("-")
            or line.startswith("|")
            or line.startswith("*")
            or line.startswith("```")
        ):
            continue
        desc = (
            line.replace("**", "")
            .replace("`", "")
            .replace("[", "")
            .replace("]", "")
        )
        # crude: drop parentheses-enclosed YouTube-id refs
        desc = re.sub(r"\([A-Za-z0-9_-]{6,}\)", "", desc).strip()
        # crude: drop markdown link url portion
        desc = re.sub(r"\((https?://[^)]+)\)", "", desc)
        if len(desc) > 200:
            desc = desc[:197].strip() + "…"
        return desc or fallback
    return fallback


def estimate_reading_minutes(body: str) -> int:
    cleaned = re.sub(r"```[\s\S]*?```", "", body)
    cleaned = re.sub(r"[#*_>`\-]", " ", cleaned)
    words = [w for w in cleaned.split() if w]
    return max(1, round(len(words) / 200))


def slug_from_filename(name: str) -> str:
    return name.replace(".md", "").replace(".mdx", "").lower()


def make_frontmatter(module: str, fn: str, body: str, title: str, updated_date, updated_raw: str) -> dict:
    summary = derive_summary(body)
    description = derive_description(body, title)
    reading = estimate_reading_minutes(body)
    return {
        "title": title,
        "summary": summary,
        "description": description,
        "module": module,
        "slug": slug_from_filename(fn),
        "order": int(fn.split("-")[0][1:]) if re.match(r"^L\d+", fn) else 0,
        "updatedDate": updated_date,
        "updatedRaw": updated_raw,
        "readingMinutes": reading,
        "accent": MODULE_META[module]["accent"],
    }


def format_date(d):
    # Emit an ISO date so YAML doesn't tag it as !!timestamp.
    if d is None:
        return None
    return d.isoformat()


def prepend_frontmatter(md: str, fm: dict) -> str:
    """Render YAML by hand so dates and ints aren't tagged and apostrophes are
    quoted cleanly. yaml.safe_dump emits !!timestamp / !!int which is uglier
    than necessary."""
    lines = ["---"]
    for key, val in fm.items():
        if val is None:
            continue
        if isinstance(val, bool):
            lines.append(f"{key}: {str(val).lower()}")
        elif isinstance(val, (int, float)):
            lines.append(f"{key}: {val}")
        elif key == "updatedDate":
            lines.append(f"{key}: {format_date(val)}")
        else:
            # Single-quoted string with embedded ' doubled per YAML rules.
            s = str(val).replace("'", "''")
            lines.append(f"{key}: '{s}'")
    lines.append("---")
    return "\n".join(lines) + "\n\n" + md.lstrip()


def verify_yaml(path: Path):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return False
    end = text.find("\n---\n", 4)
    if end < 0:
        return False
    yaml.safe_load(text[4:end])
    return True


def main():
    DST.mkdir(parents=True, exist_ok=True)
    moved = []
    failed = []

    for mod_dir in sorted(SRC.iterdir()):
        if not mod_dir.is_dir() or mod_dir.name.startswith("_"):
            continue
        module = mod_dir.name
        dst_mod = DST / module
        dst_mod.mkdir(parents=True, exist_ok=True)

        for src_file in sorted(mod_dir.iterdir()):
            if not src_file.is_file() or not src_file.name.endswith(".md"):
                continue
            md = src_file.read_text(encoding="utf-8")
            title, updated_raw, updated_date = parse_lesson(md)

            if not title:
                failed.append((str(src_file), "no title found"))
                continue
            if not updated_date:
                # Skip smoke-test-like files with no real date; surface but proceed.
                failed.append((str(src_file), "no updatedDate"))

            body_start = 0
            lines = md.split("\n")
            for i, line in enumerate(lines):
                if line.startswith("**Last tested and updated:**"):
                    body_start = i + 1
                    while body_start < len(lines):
                        n = lines[body_start].strip()
                        if n == "" or n == "---":
                            body_start += 1
                            continue
                        break
                    break
            body = "\n".join(lines[body_start:])

            fm = make_frontmatter(module, src_file.name, body, title, updated_date, updated_raw)

            dst_file = dst_mod / src_file.name
            new_md = prepend_frontmatter(md, fm)
            dst_file.write_text(new_md, encoding="utf-8")

            ok = verify_yaml(dst_file)
            if ok:
                moved.append(str(dst_file))
            else:
                failed.append((str(dst_file), "yaml parse failed"))

    # Also copy _skeletons directories if present (they're not validated)
    for skel_dir in SRC.glob("*/_skeletons"):
        module = skel_dir.parent.name
        dst_skel = DST / module / "_skeletons"
        dst_skel.mkdir(parents=True, exist_ok=True)
        for src_file in sorted(skel_dir.iterdir()):
            if src_file.is_file() and src_file.name.endswith(".md"):
                shutil.copy2(src_file, dst_skel / src_file.name)
                moved.append(str(dst_skel / src_file.name))

    print(f"\n✅ Migrated {len(moved)} files to {DST}")
    if failed:
        print(f"\n⚠️  {len(failed)} files had issues:")
        for f, reason in failed:
            print(f"   - {f}: {reason}")

    print("\nNow run from repo root:")
    print("  cd /home/ubuntu/boxai4")
    for f in moved:
        rel = f.replace(str(REPO) + "/", "")
        print(f"  git mv {rel.replace('site/src/content/', 'lessons/')[:0] or ''}{rel}")
    print("(see PR description for the actual git mv commands)")


if __name__ == "__main__":
    main()
