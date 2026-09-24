# Workflow — Secure File Management & User Configuration

Each phase below states **who runs it** (root/sudo vs `agent007`), the command,
what to expect, how to verify it, and what evidence to capture.

---

## Phase 1 — User Account Creation *(run as: root / sudo)*

**Step 1.1 — Create the user**

```bash
sudo useradd -m -s /bin/bash -G sudo agent007
```

- **Purpose:** `-m` creates a home directory (`/home/agent007`), `-s /bin/bash` sets
  the login shell, `-G sudo` adds the account to the `sudo` group so it can run
  privileged commands when needed.
- **Expected result:** command returns with no output (success is silent).
- **Verify:**
  ```bash
  id agent007
  ```
  Confirms the user exists and is a member of the `sudo` group.
- **Evidence:** `01-user-created.png` — terminal showing the `useradd` command and
  the `id agent007` verification output.

**Step 1.2 — Set a password**

```bash
sudo passwd agent007
```

- **Purpose:** `agent007` needs a password to log in / switch to via `su`.
- **Expected result:** prompts for and confirms a new password.
- **Note:** this is the last root-required step before switching users.

---

## Phase 2 — Switch to agent007 *(run as: root → switching to agent007)*

```bash
su - agent007
```

- **Purpose:** the `-` loads agent007's full environment (home directory, shell,
  environment variables) rather than just borrowing their permissions.
- **Verify:**
  ```bash
  whoami
  ```
  Should return `agent007`.
- **Evidence:** `02-switched-user.png` — terminal showing `whoami` returning `agent007`.
- **From this point forward, every command in this workflow is run as `agent007`,
  not root**, per the task's explicit instructions.

---

## Phase 3 — Workspace Directory Structure *(run as: agent007)*

```bash
mkdir -p ~/mission/intel ~/mission/ops/backup
cd ~/mission
```

- **Purpose:** `-p` creates parent directories as needed, so `intel/` and the nested
  `ops/backup/` are created in one command.
- **Expected result:** the structure below exists under `/home/agent007/mission/`:
  ```
  mission/
  ├── intel/
  └── ops/
      └── backup/
  ```
- **Verify:**
  ```bash
  ls -R ~/mission
  ```
- **Evidence:** `03-workspace-created.png` — terminal showing the directory tree.

---

## Phase 4 — File Creation and Listing *(run as: agent007)*

```bash
cd ~/mission/intel
touch targets.txt routes.txt keys.txt
ls > listing1.txt
ls -l > listing2.txt
ls -la > listing3.txt
```

- **Purpose:** `touch` creates the three empty files. The three `ls` variants show
  increasing detail — plain names, long format with permissions, and long format
  including hidden files — each redirected (`>`) into its own file instead of
  printed to screen.
- **Expected result:** `intel/` now contains `targets.txt`, `routes.txt`, `keys.txt`,
  `listing1.txt`, `listing2.txt`, `listing3.txt`.
- **Verify:**
  ```bash
  ls -la ~/mission/intel
  cat listing2.txt
  ```
- **Evidence:** `04-files-and-listings.png` — terminal showing the files created and
  the contents of at least `listing2.txt`.

---

## Phase 5 — Copy and Remove *(run as: agent007)*

```bash
cp ~/mission/intel/routes.txt ~/mission/ops/backup/
rm ~/mission/intel/keys.txt
```

- **Purpose:** `cp` duplicates `routes.txt` into the backup location (original stays
  in place). `rm` permanently deletes `keys.txt` from `intel/`.
- **Expected result:** `routes.txt` now exists in both `intel/` and `ops/backup/`;
  `keys.txt` no longer exists anywhere in `intel/`.
- **Verify:**
  ```bash
  ls ~/mission/ops/backup
  ls ~/mission/intel
  ```
- **Evidence:** `05-copy-and-remove.png` — terminal showing both `ls` outputs confirming
  the copy succeeded and the deletion happened.

---

## Phase 6 — Permissions Handling *(run as: agent007)*

```bash
chmod 640 ~/mission/intel/targets.txt
ls -l ~/mission/intel/targets.txt
```

- **Purpose:** `640` = owner read+write (6), group read-only (4), others no access (0)
  — exactly the requirement: owner rw, group r, others none.
- **Expected result:** `ls -l` shows `-rw-r-----` for `targets.txt`.
- **Verify:** confirm the permission string matches `-rw-r-----` exactly.
- **Evidence:** `06-permissions-set.png` — terminal showing the `chmod` command and
  the resulting `ls -l` output.

---

## Phase 7 — Simulate Error and Recover *(run as: agent007)*

```bash
rm ~/mission/ops/backup/routes.txt
ls ~/mission/ops/backup
cp ~/mission/intel/routes.txt ~/mission/ops/backup/
ls ~/mission/ops/backup
```

- **Purpose:** deliberately deletes the backup copy to simulate a real "lost file"
  incident, then restores it from the known-good source in `intel/`. This mirrors
  real backup/recovery logic: delete → confirm it's gone → restore from source →
  confirm it's back.
- **Expected result:** first `ls` shows `backup/` empty of `routes.txt`; second `ls`
  shows it restored.
- **Evidence:** `07-error-simulation-and-recovery.png` — terminal showing both `ls`
  outputs (before and after recovery).

---

## Phase 8 — Ownership Change *(run as: root, then agent007)*

**As root:**
```bash
exit
sudo chown root ~agent007/mission/intel/targets.txt
```

**Back as agent007:**
```bash
su - agent007
ls -l ~/mission/intel/targets.txt
```

- **Purpose:** demonstrates that ownership (`chown`) is separate from permissions
  (`chmod`) — the file's owner field changes to `root`, and `agent007` should observe
  whether they can still read/write it based on the group/other permission bits set
  in Phase 6.
- **Expected result:** `ls -l` shows `root` as the owner. Because group permission
  was set to read-only in Phase 6, `agent007` should now be able to *read* but not
  *write* to `targets.txt`.
- **Verify:** attempt `cat targets.txt` (should succeed) and `echo "test" >> targets.txt`
  (should fail with permission denied) to confirm the observation.
- **Evidence:** `08-ownership-change.png` — terminal showing the ownership change and
  the resulting `ls -l` output as agent007.

---

## Phase 9 — Evidence Collection *(run as: agent007)*

```bash
ls -laR ~/mission > ~/mission-final-listing.txt
history > ~/agent007-command-history.txt
```

- **Purpose:** captures the final state of the whole workspace and the full command
  history, both required for submission.
- **Evidence:** these two files themselves are the primary submission evidence —
  copy their contents into `submission/final-output.txt` and
  `submission/command-history.txt` respectively.

---

## Phase 10 — Final Submission

See [`../submission/README.md`](../submission/README.md) for exactly what to submit
and in what format.
