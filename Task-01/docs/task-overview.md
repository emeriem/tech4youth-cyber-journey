# Task Overview

## Title
Practical Task: Secure File Management & User Configuration on Kali Linux

## Objective
Demonstrate your understanding of fundamental Linux file system and user management
commands. You are tasked with setting up a secure workspace for a newly created user
and organizing files with proper permissions and structure.

## Instructions
You **must not** use the root user to complete the file operations. A new user must
be created, and all steps (except `useradd` and `usermod`) must be performed using
that user's account.

## Task Steps

1. **Create a New User**
   - Create a new user named `agent007` with a home directory and assign `/bin/bash` as their shell.
   - Add this user to the `sudo` group.
   - `sudo useradd -m -s /bin/bash -G sudo agent007`

2. **Switch to the New User**
   - Set a password for `agent007`.
   - Switch to the new user and perform the rest of the steps using this account.

3. **Setup Workspace**
   - Inside `/home/agent007/`, create a directory structure as follows:
     ```
     /home/agent007/mission/
     ├── intel/
     └── ops/
         └── backup/
     ```
   - Use `mkdir` and `cd` commands to navigate and create this structure.

4. **File Creation and Listing**
   - Inside `intel/`, create three empty files: `targets.txt`, `routes.txt`, and `keys.txt`.
   - Use `ls`, `ls -l`, and `ls -la` to list contents and view permissions of the files
     and directories. Redirect the output of each listing to separate files named
     `listing1.txt`, `listing2.txt`, and `listing3.txt` inside the `intel/` folder.

5. **Copy and Remove Files**
   - Copy `routes.txt` to the `backup/` folder.
   - Delete `keys.txt` from `intel/` using `rm`.

6. **Permissions Handling**
   - Change the permissions of `targets.txt` so that:
     - Owner can read and write.
     - Group can only read.
     - Others have no permissions.
   - Use `chmod` and verify using `ls -l`.

7. **Simulate an Error and Recover**
   - Intentionally remove the `ops/backup/routes.txt` file.
   - Copy `routes.txt` from `intel/` back into the `backup/` folder.
   - (This tests `cp` and basic error recovery.)

8. **Advanced Permissions & Ownership**
   - As root, change the ownership of `intel/targets.txt` to another user (e.g. `root`),
     then switch back to `agent007` and observe the result using `ls -l`.

## Submission Requirements

Students must submit:
- The command history (`.bash_history` or a copy-paste of commands used).
- A screenshot or text file showing the final `ls -laR /home/agent007/mission/` output.
- A text explanation (4-5 lines) of what `chmod`, `ls -l`, and `useradd` do.
