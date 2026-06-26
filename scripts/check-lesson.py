#!/usr/bin/env python3
"""
Layer 4 quality gate for Boxmining AI Academy lessons.

Reads a lesson file and asserts it satisfies the per-lesson requirements
from Specs/ai-academy-lesson-specification.md.

Usage:
  python3 scripts/check-lesson.py lessons/hermes/L01-install.md
  python3 scripts/check-lesson.py lessons/hermes/L01-install.md --verbose
  python3 scripts/check-lesson.py lessons/  # checks every .md file under the dir

Exit codes:
  0 = all checks passed
  1 = one or more checks failed
  2 = file not found / unreadable

This script intentionally does NOT call out to an LLM or the network.
It is deterministic so it can run in pre-commit hooks and CI.
"""

import argparse
import re
import sys
from pathlib import Path


# Required H2 sections per the spec (mapped to top-level numbered headings).
REQUIRED_SECTIONS = [
    ("Introduction & Hook", True),
    ("Core Content", True),
    ("Common Pitfalls & Troubleshooting", True),
    ("Key Takeaways & Ron's Bottom Line", True),
    ("Hands-On Practice", True),
    ("Self-Check / Mini-Quiz", True),
    ("Resources, Glossary & Further Learning", True),
    ("FAQ", True),
]

# Optional sections (warn if missing in cases where they make sense, don't fail)
OPTIONAL_SECTIONS = [
    "Comparison & Decision Framework",
]

# Words that signal an unfilled TODO placeholder in the body
TODO_MARKERS = ["<!-- TODO", "<!--TODO"]

# Action verbs that learning objectives MUST start with
ACTION_VERBS = {
    "install", "configure", "set up", "setup", "build", "create", "compare",
    "avoid", "identify", "explain", "describe", "use", "run", "deploy",
    "write", "read", "edit", "navigate", "choose", "pick", "decide",
    "understand", "apply", "test", "verify", "debug", "fix", "tune",
    "optimize", "monitor", "measure", "estimate", "calculate", "list",
    "summarize", "summarise", "differentiate", "evaluate", "assess",
    "confirm", "verify", "validate", "invoke", "trigger", "add",
    "remove", "delete", "uninstall", "update", "switch", "set",
    "practice", "recognise", "recognize", "describe", "name",
    "generate", "produce", "classify", "distinguish", "articulate",
    "define", "explain", "position", "locate", "identify",
    "match", "plan", "decide", "recommend", "map", "compare",
    "apply", "design", "draft", "implement",
}


def read_lesson(path: Path) -> str:
    if not path.exists():
        print(f"ERROR: {path} not found", file=sys.stderr)
        sys.exit(2)
    if not path.is_file():
        print(f"ERROR: {path} is not a file", file=sys.stderr)
        sys.exit(2)
    try:
        return path.read_text(encoding="utf-8")
    except Exception as exc:
        print(f"ERROR: cannot read {path}: {exc}", file=sys.stderr)
        sys.exit(2)


def _normalize_title(title: str) -> str:
    """Strip a leading 'N. ' or 'N.M. ' from a heading."""
    return re.sub(r"^\d+(\.\d+)*\.?\s+", "", title).strip()


def find_h2_sections(text: str) -> list[str]:
    """Return the titles of all top-level H2 sections in order, normalized."""
    sections = []
    for line in text.splitlines():
        m = re.match(r"^##\s+(.+?)\s*$", line)
        if m:
            sections.append(_normalize_title(m.group(1)))
    return sections


def find_section_body(text: str, section_title: str) -> str | None:
    """Return the body of the H2 section whose normalized title starts with `section_title`.
    Returns None if the section is not present.
    """
    lines = text.splitlines()
    body_lines = []
    in_section = False
    for line in lines:
        m = re.match(r"^##\s+(.+?)\s*$", line)
        if m:
            if in_section:
                break
            if _normalize_title(m.group(1)).startswith(section_title):
                in_section = True
                continue
        elif in_section:
            body_lines.append(line)
    return "\n".join(body_lines) if in_section else None


def strip_comments(text: str) -> str:
    """Remove HTML comments so placeholders don't count as content."""
    return re.sub(r"<!--.*?-->", "", text, flags=re.DOTALL)


def has_unfilled_todos(text: str) -> int:
    """Count unfilled <!-- TODO --> markers anywhere in the file."""
    return sum(1 for m in TODO_MARKERS if m in text)


def word_count(text: str) -> int:
    """Count words in the body, ignoring comments."""
    return len(re.findall(r"\b[\w'-]+\b", strip_comments(text)))


def extract_learning_objectives(text: str) -> list[str]:
    """Pull bullet points from the Learning Objectives subsection."""
    body = find_section_body(text, "Introduction & Hook")
    if not body:
        return []
    # Find the Learning Objectives sub-section
    m = re.search(
        r"###\s+Learning Objectives\s*\n(.*?)(?=\n###|\n##|\Z)",
        body,
        flags=re.DOTALL,
    )
    if not m:
        return []
    block = m.group(1)
    bullets = []
    for line in block.splitlines():
        m = re.match(r"^\s*[-*]\s+(.*)$", line)
        if m:
            text_bullet = strip_comments(m.group(1)).strip()
            if text_bullet:
                bullets.append(text_bullet)
    return bullets


def has_freshness_date(text: str) -> bool:
    """Look for a 'Last tested and updated' line with a month + year."""
    return bool(
        re.search(
            r"(?im)^[*\s]*[*\s]*Last tested and updated[*\s]*:.*?\b(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{4}",
            text,
        )
    )


def count_quiz_questions(text: str) -> int:
    """Count Q1, Q2, ... markers in the quiz section."""
    body = find_section_body(text, "Self-Check / Mini-Quiz")
    if not body:
        return 0
    return len(re.findall(r"\*\*Q\d+\.\*\*", body))


def count_faq_questions(text: str) -> int:
    """Count 'Q:' questions in the FAQ section."""
    body = find_section_body(text, "FAQ")
    if not body:
        return 0
    return len(re.findall(r"\*\*Q[:\s]", body))


def count_pitfalls(text: str) -> int:
    """Count 'Pitfall N' sub-section headers."""
    body = find_section_body(text, "Common Pitfalls")
    if not body:
        return 0
    return len(re.findall(r"^###\s+Pitfall\s+\d+", body, flags=re.MULTILINE))


def check_lesson(path: Path, verbose: bool = False) -> tuple[list[str], list[str]]:
    """Return (failures, warnings). Empty lists = pass."""
    failures: list[str] = []
    warnings: list[str] = []
    text = read_lesson(path)

    if verbose:
        print(f"Checking {path}")

    # 1. Required H2 sections
    sections = find_h2_sections(text)
    section_titles_present = {s for s in sections}
    for required_title, _is_required in REQUIRED_SECTIONS:
        if not any(s.startswith(required_title) for s in section_titles_present):
            failures.append(f"Missing required section: '{required_title}'")

    # 2. Unfilled TODO placeholders
    todo_count = has_unfilled_todos(text)
    if todo_count > 0:
        failures.append(
            f"{todo_count} unfilled '<!-- TODO -->' marker(s) remain in the file"
        )

    # 3. Word count target (1,800 minimum per spec)
    wc = word_count(text)
    if wc < 1800:
        failures.append(
            f"Word count {wc} is below the 1,800 minimum specified in the spec"
        )

    # 4. Last-tested/updated date present
    if not has_freshness_date(text):
        failures.append(
            "Missing 'Last tested and updated: <Month YYYY>' line"
        )

    # 5. Learning objectives use action verbs
    objectives = extract_learning_objectives(text)
    if len(objectives) < 3:
        failures.append(
            f"Only {len(objectives)} learning objective(s) found; spec requires 3–5"
        )
    else:
        bad = [
            obj
            for obj in objectives
            if obj.split()[0].lower().rstrip(",.;:") not in ACTION_VERBS
        ]
        if bad:
            warnings.append(
                f"Learning objectives should start with action verbs; "
                f"these don't: {bad}"
            )

    # 6. Quiz section has 4–6 questions
    q_count = count_quiz_questions(text)
    if q_count < 4:
        failures.append(
            f"Quiz section has {q_count} question(s); spec requires 4–6"
        )

    # 7. Pitfalls section has 5–8 pitfalls (spec minimum)
    p_count = count_pitfalls(text)
    if p_count < 5:
        failures.append(
            f"Pitfalls section has {p_count} pitfall(s); spec requires 5–8"
        )

    # 8. FAQ section has at least 3 questions
    faq_count = count_faq_questions(text)
    if faq_count < 3:
        warnings.append(
            f"FAQ has {faq_count} question(s); recommended minimum is 3"
        )

    # 9. Optional comparison section note (warn only, never fail)
    if not any(s.startswith("Comparison") for s in section_titles_present):
        warnings.append(
            "Optional section 'Comparison & Decision Framework' is absent. "
            "Include it if the lesson is about a choice between options."
        )

    return failures, warnings


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Layer 4 quality gate for Boxmining AI Academy lessons."
    )
    parser.add_argument(
        "target",
        type=Path,
        help="Path to a lesson .md file, or a directory of lesson files.",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Print per-file progress info.",
    )
    parser.add_argument(
        "--no-warn",
        action="store_true",
        help="Treat warnings as failures.",
    )
    args = parser.parse_args()

    # Collect files to check
    if args.target.is_dir():
        files = sorted(args.target.rglob("*.md"))
        # Skip files in any _skeletons directory — those are Layer 2 proposals,
        # not finished lessons, and will always fail the gate.
        files = [f for f in files if "_skeletons" not in f.parts]
        if not files:
            print(f"No .md lesson files found under {args.target}", file=sys.stderr)
            sys.exit(1)
    else:
        files = [args.target]

    total_files = 0
    failed_files = 0
    total_failures = 0
    total_warnings = 0

    for f in files:
        total_files += 1
        result = check_lesson(f, verbose=args.verbose)
        failures, warnings = result
        total_failures += len(failures)
        total_warnings += len(warnings)

        if failures:
            failed_files += 1
            print(f"\n❌ {f}")
            for msg in failures:
                print(f"   FAIL: {msg}")
            for msg in warnings:
                print(f"   WARN: {msg}")
        elif warnings:
            print(f"\n⚠️  {f}")
            for msg in warnings:
                print(f"   WARN: {msg}")
        else:
            print(f"✅ {f}")

    print()
    print(f"Checked {total_files} file(s): {total_failures} failure(s), {total_warnings} warning(s).")

    if total_failures > 0 or (args.no_warn and total_warnings > 0):
        sys.exit(1)


if __name__ == "__main__":
    main()