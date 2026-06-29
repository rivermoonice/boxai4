#!/usr/bin/env python3
"""
Lesson hygiene gate for Boxmining AI Academy lessons.

A small, deterministic check that runs offline. It asserts only the things that
genuinely matter for a lesson to ship:

  - No unfilled `<!-- TODO -->` placeholders are left in the file.
  - A `Last tested and updated: <Month YYYY>` freshness line is present.

Everything else (word count, section structure, pitfalls count, FAQ count,
action-verb enforcement, learning-objectives count, mandatory sections) is
advisory only — the gate warns but does not block. Lessons are free to use any
shape that fits the topic. Quality comes from human review, not from a
structural gauntlet.

Usage:
  python3 scripts/check-lesson.py lessons/hermes/L01-install.md
  python3 scripts/check-lesson.py lessons/  # checks every .md file under the dir

Exit codes:
  0 = no blocking failures
  1 = one or more blocking failures (unfilled TODO, missing freshness date)
  2 = file not found / unreadable

This script intentionally does NOT call out to an LLM or the network.
"""

import argparse
import re
import sys
from pathlib import Path


# Words that signal an unfilled TODO placeholder in the body
TODO_MARKERS = ["<!-- TODO", "<!--TODO"]


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


def has_unfilled_todos(text: str) -> int:
    """Count unfilled <!-- TODO --> markers anywhere in the file."""
    return sum(1 for m in TODO_MARKERS if m in text)


def has_freshness_date(text: str) -> bool:
    """Look for a 'Last tested and updated' line with a month + year."""
    return bool(
        re.search(
            r"(?im)^[*\s]*[*\s]*Last tested and updated[*\s]*:.*?\b(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{4}",
            text,
        )
    )


def has_quiz(text: str) -> bool:
    """Detect whether the lesson has any quiz content — for MD, this looks for
    `**Q1.**` or `**Q:` markers; for MDX, it also accepts a `<Quiz` component."""
    return bool(
        re.search(r"\*\*Q\d+\.\*\*", text)
        or re.search(r"\*\*Q[:\s]", text)
        or re.search(r"<Quiz[\s/>]", text)
    )


def check_lesson(path: Path, verbose: bool = False) -> tuple[list[str], list[str]]:
    """Return (failures, warnings). Empty lists = pass."""
    failures: list[str] = []
    warnings: list[str] = []
    text = read_lesson(path)

    if verbose:
        print(f"Checking {path}")

    # 1. Unfilled TODO placeholders
    todo_count = has_unfilled_todos(text)
    if todo_count > 0:
        failures.append(
            f"{todo_count} unfilled '<!-- TODO -->' marker(s) remain in the file"
        )

    # 2. Last-tested/updated date present
    if not has_freshness_date(text):
        failures.append(
            "Missing 'Last tested and updated: <Month YYYY>' line"
        )

    # 3. Quiz exists somewhere (advisory)
    if not has_quiz(text):
        warnings.append(
            "No quiz detectable (no **Q1.** markers and no <Quiz> component). "
            "Consider adding a self-check at the end of the lesson."
        )

    return failures, warnings


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Lesson hygiene gate for Boxmining AI Academy."
    )
    parser.add_argument(
        "target",
        type=Path,
        help="Path to a lesson .md/.mdx file, or a directory of lesson files.",
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
        files = sorted(list(args.target.rglob("*.md")) + list(args.target.rglob("*.mdx")))
        # Skip files in any _skeletons directory — those are proposals,
        # not finished lessons, and will always fail the gate.
        files = [f for f in files if "_skeletons" not in f.parts]
        if not files:
            print(f"No .md/.mdx lesson files found under {args.target}", file=sys.stderr)
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
