# Linux Task 01 — Secure File Management & User Configuration on Kali Linux

## Project Description

This project documents the completion of a practical Linux systems administration
lab: creating a restricted user account, building a directory workspace, applying
file permissions correctly, and performing basic error recovery — all performed
as a non-root user, in line with the principle of least privilege.

## Objective

Demonstrate understanding of fundamental Linux file system and user management
commands by setting up a secure workspace for a newly created user and organizing
files with proper permissions and structure.

## Lab Requirements

- You **must not** use the root user to perform the file operations.
- A new user (`agent007`) must be created.
- All steps **except** `useradd` and `usermod` must be performed using `agent007`'s account.

## Technologies / Tools Used

- Kali Linux (VM)
- Bash shell
- Core GNU coreutils: `useradd`, `su`, `mkdir`, `touch`, `ls`, `cp`, `rm`, `chmod`, `chown`

## Prerequisites

- A working Kali Linux VM with sudo access
- Basic terminal familiarity (navigating directories, running commands)

## Environment / Setup Information

- Performed inside a Kali Linux VM (VirtualBox), attacker-side machine in a home lab
- All non-`useradd`/`usermod` steps performed logged in as `agent007`, not root

## Project Structure

```
linux-task01-secure-file-management/
├── README.md                  This file
├── .gitignore
├── docs/                      Task background and requirements as given
├── workflow/                  Full phase-by-phase procedure
├── commands/                  Ordered command reference
├── scripts/                   Optional helper scripts (setup + verification only)
├── evidence/                  Screenshots and terminal output captured while doing the lab
└── submission/                Final submission materials (command history, final output, explanation)
```

## Step-by-Step Workflow

See [`workflow/workflow.md`](workflow/workflow.md) for the full phase-by-phase breakdown
with commands, expected results, verification steps, and evidence to capture at each stage.

## Commands Used

See [`commands/commands.sh`](commands/commands.sh) for the complete ordered command
reference, with comments explaining each step and clear notes on which user must run it.

## Expected Results

- `agent007` exists, is a member of the `sudo` group, has `/bin/bash` as its shell
- `/home/agent007/mission/` contains the required directory structure
- `intel/` contains `targets.txt`, `routes.txt` (copied to backup), and the three listing files
- `keys.txt` has been deleted from `intel/`
- `targets.txt` permissions are exactly `rw-r-----` (640)
- `ops/backup/routes.txt` exists after the deliberate delete-and-recover step
- Ownership change on `targets.txt` observed and understood

## Evidence Requirements

See [`evidence/README.md`](evidence/README.md) for the full list of required screenshots,
what each one must show, and suggested filenames.

## Submission Requirements

See [`submission/README.md`](submission/README.md) for exactly what must be submitted:
command history, final `ls -laR` output, and a 4-5 line written explanation of `chmod`,
`ls -l`, and `useradd`.

## Troubleshooting

| Issue | Likely Cause | Fix |
|---|---|---|
| `userdel`/other commands say "user is currently used by process" | A process owned by that user is still running | Check with `ps -p <pid> -u`, then close it properly rather than force-killing blindly |
| `chmod` permissions don't look right in `ls -l` | Wrong numeric mode used | Recall: first digit = owner, second = group, third = others (read=4, write=2, execute=1) |
| Can't switch back to `agent007` after `chown` as root | Still logged in as root | Run `exit` first, then `su - agent007` |
| Permission denied doing normal file operations | Accidentally still root, or `agent007` isn't in the right group | Run `whoami` to confirm which user you're actually operating as |

## Safety / Permission Notes

- `useradd` and `usermod` are the **only** commands in this task that require root/sudo.
- Every other command must be run as `agent007` — this is the actual point of the lab:
  practicing the principle of least privilege rather than defaulting to root for convenience.
- No destructive commands in this project operate outside the `mission/` workspace.
