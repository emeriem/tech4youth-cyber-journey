# Scripts

Only two scripts are provided, deliberately. The actual lab work (creating the
directory structure, files, permissions, and performing the recovery/ownership
steps) is **not** scripted — that's the graded, hands-on part of the task, and
automating it would defeat the point of the exercise.

## `setup.sh`
*Run as: root / sudo*

Creates the `agent007` user account only (the one part of this task that's
mechanical setup rather than the learning objective itself). Does not touch
passwords (still interactive/manual) or anything inside the user's workspace.

```bash
sudo ./setup.sh
```

## `verify.sh`
*Run as: agent007*

A **read-only** check — verifies the final state of the workspace matches what
the task expects (directory structure, expected files, `targets.txt` permissions).
Makes no changes. Safe to run any number of times, at any point, to sanity-check
your own progress.

```bash
./verify.sh
```
