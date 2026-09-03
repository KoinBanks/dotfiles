---
name: my-diff-review
description: Reviews changes between target branch and origin/master
disable-model-invocation: true
---
You will receive a <branch_name> as an argument. Run every command in the current workspace directory. 
Do not `cd` into any other folder or change the working directory for the session.

1) Run `git fetch` command
2) Run `git diff --no-compact origin/master...origin/<branch_name>` to obtain the git diff
3) Do a review on the git diff

Rules:
* Work solely on the diff, do not read any other files
* Only check logic, do not report formatting issues
* Only point out problems, do not mention changes which are sound
* Ignore trailing commas
* Generate summary at the end

Save the review into a folder obtained by running `wslupath -D` and name it `REVIEW-<branch_name>.md`. 
Make sure `<branch_name>` contains no special characters.
