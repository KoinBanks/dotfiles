---
name: git-diff-review
description: Reviews changes between target branch and origin/master
---
You will receive a <branch_name> as an argument. Run every command in the current workspace directory. Do not `cd` into any other folder or change the working directory for the session.

1) Use the `bash` tool to run command `git fetch`
2) Use the `bash` tool to run command `git diff origin/master...origin/<branch_name>` and obtain the diff
3) Do the review on the diff

Rules:
* Do not read any files, work solely on the diff
* Only check logic, do not report formatting issues
* Only point out problems, do not mention changes which are sound
* Ignore trailing commas
* Generate summary at the end
