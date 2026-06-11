---
name: git-diff-review
description: Reviews the git diff between currently checked out branch and origin/master branch.
---

# Git diff review skill

Review the diff returned from command `git diff origin/master...HEAD`. Do not read whole files.

## Rules
- If you see something is removed or renamed, check if there are any lingering calls in the codebase using `grep`. If there are, report it.
- ONLY report changes you see as problematic. If something is sound, do not report it at all.
