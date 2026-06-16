---
name: git-diff-review
description: Reviews changes between target branch and origin/master
---
You will receive a <branch_name> as an argument. Do this inside current directory:

1) run `git fetch`
2) run `git diff origin/master...origin/<branch_name>` to obtain the diff
3) do the review on the diff

Rules:
* Do not read any files, work solely on the diff.
* Focus on logic, do not check formatting
* Only point out problems, do not mention changes which are sound.
* Generate summary at the end
