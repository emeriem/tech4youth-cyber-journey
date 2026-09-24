# Evidence

Screenshots and terminal output captured while actually performing this task.
None of the files below exist yet in this template — capture your own as you
work through `workflow/workflow.md`, and place them here.

## Required Screenshots (`screenshots/`)

| Filename | Captured during | What it must show | What it proves |
|---|---|---|---|
| `01-user-created.png` | Phase 1 | `useradd` command + `id agent007` output | Account created with correct shell/group |
| `02-switched-user.png` | Phase 2 | `whoami` returning `agent007` | You're no longer operating as root |
| `03-workspace-created.png` | Phase 3 | `ls -R ~/mission` output | Correct directory structure |
| `04-files-and-listings.png` | Phase 4 | `ls -la` of `intel/` + contents of `listing2.txt` | Files and listing redirects created correctly |
| `05-copy-and-remove.png` | Phase 5 | `ls` of both `intel/` and `backup/` | `routes.txt` copied, `keys.txt` deleted |
| `06-permissions-set.png` | Phase 6 | `chmod` command + `ls -l` showing `-rw-r-----` | Correct permission bits applied |
| `07-error-simulation-and-recovery.png` | Phase 7 | `ls` of `backup/` before and after recovery | Understanding of `rm`/`cp` recovery pattern |
| `08-ownership-change.png` | Phase 8 | `ls -l` showing new owner + read/write test results | Understanding of `chown` vs `chmod` |
| `09-final-directory-structure.png` | Phase 9 | Full `ls -laR ~/mission` output | Final complete state of the workspace |

## Terminal Output (`terminal-output/`)

Optional but recommended: save raw text copies (not just screenshots) of any
command output you may want to reference later or paste directly into your
submission — particularly the Phase 9 final listing and full command history.

## Notes

- Do not fabricate or reuse screenshots from a different run — each should reflect
  your own actual terminal session.
- Make sure your username (`agent007`) and hostname are visible in each screenshot
  where possible — this confirms which user actually ran the command.
