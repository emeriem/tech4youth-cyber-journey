# Submission

Per the task's stated requirements, you must submit exactly three things:

1. **Command history** — your actual `.bash_history`, or a copy-paste of the commands
   you ran, in order. Paste it into [`command-history.txt`](command-history.txt),
   replacing the placeholder.

2. **Final directory listing** — the output of `ls -laR /home/agent007/mission/`,
   either as a screenshot (see `evidence/screenshots/09-final-directory-structure.png`)
   or as text pasted into [`final-output.txt`](final-output.txt), replacing the placeholder.

3. **Written explanation (4-5 lines)** of what `chmod`, `ls -l`, and `useradd` do.
   Write this yourself, in your own words, once you've actually run each command and
   seen what it does — not copied from a definition. A strong explanation covers:
   - **`chmod`** — what permissions actually consist of (read/write/execute, for
     owner/group/others), and what the numeric mode you used (`640`) means specifically.
   - **`ls -l`** — the format of the permission string it displays (e.g. `-rw-r-----`)
     and what each section represents.
   - **`useradd`** — not just "creates a user," but what the flags you actually used
     (`-m`, `-s`, `-G`) each do and why they were needed for this task.

   Add this explanation as a new file: `submission/explanation.txt` (not pre-created
   here, since it must be written by you after completing the lab).

## Checklist Before Submitting

- [ ] All required users created
- [ ] Required directories created (`mission/intel/`, `mission/ops/backup/`)
- [ ] Required files created (`targets.txt`, `routes.txt`, `keys.txt` then deleted, 3 listing files)
- [ ] Required permissions configured (`targets.txt` = 640)
- [ ] Required ownership configured (Phase 8 `chown`)
- [ ] Required commands executed as the correct user (root vs agent007)
- [ ] Required error/recovery test completed (Phase 7)
- [ ] Final output verified (`ls -laR` matches expected structure)
- [ ] Screenshots captured (see `evidence/README.md`)
- [ ] Command history saved
- [ ] Written explanation of `chmod`, `ls -l`, `useradd` completed in your own words
