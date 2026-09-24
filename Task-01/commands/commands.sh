#!/bin/bash
# =============================================================================
# Linux Task 01 — Command Reference
# Secure File Management & User Configuration on Kali Linux
#
# THIS IS A REFERENCE FILE, NOT AN AUTO-RUN SCRIPT.
# It requires switching users (su -) and interactive password entry,
# which cannot execute unattended. Run each section manually, in order.
# =============================================================================


# -----------------------------------------------------------------------
# SECTION 1 — Run as: root / sudo
# -----------------------------------------------------------------------

# Create the required user, with home directory and bash shell,
# added to the sudo group
sudo useradd -m -s /bin/bash -G sudo agent007

# Set a password for the new user (interactive — you'll be prompted)
sudo passwd agent007

# Verify the account was created correctly
id agent007


# -----------------------------------------------------------------------
# SECTION 2 — Switch to the new user
# (everything from here on must be run as agent007, NOT root)
# -----------------------------------------------------------------------

su - agent007
whoami   # should print: agent007


# -----------------------------------------------------------------------
# SECTION 3 — Run as: agent007 — Build the workspace
# -----------------------------------------------------------------------

# -p creates parent directories as needed, in one shot
mkdir -p ~/mission/intel ~/mission/ops/backup
cd ~/mission
ls -R


# -----------------------------------------------------------------------
# SECTION 4 — Run as: agent007 — Create and list files
# -----------------------------------------------------------------------

cd ~/mission/intel

# Create three empty files
touch targets.txt routes.txt keys.txt

# Redirect each listing variant into its own file
ls > listing1.txt
ls -l > listing2.txt
ls -la > listing3.txt


# -----------------------------------------------------------------------
# SECTION 5 — Run as: agent007 — Copy and remove
# -----------------------------------------------------------------------

# Copy routes.txt into the backup location (original stays in intel/)
cp ~/mission/intel/routes.txt ~/mission/ops/backup/

# Permanently delete keys.txt from intel/
rm ~/mission/intel/keys.txt


# -----------------------------------------------------------------------
# SECTION 6 — Run as: agent007 — Set permissions
# -----------------------------------------------------------------------

# 640 = owner read+write(6), group read-only(4), others none(0)
chmod 640 ~/mission/intel/targets.txt

# Verify — should show -rw-r-----
ls -l ~/mission/intel/targets.txt


# -----------------------------------------------------------------------
# SECTION 7 — Run as: agent007 — Simulate error, then recover
# -----------------------------------------------------------------------

# Intentionally delete the backup copy
rm ~/mission/ops/backup/routes.txt
ls ~/mission/ops/backup    # confirm it's gone

# Restore it from the known-good source in intel/
cp ~/mission/intel/routes.txt ~/mission/ops/backup/
ls ~/mission/ops/backup    # confirm it's back


# -----------------------------------------------------------------------
# SECTION 8 — Run as: root, then back as agent007 — Ownership change
# -----------------------------------------------------------------------

exit    # leave agent007 shell, back to root/sudo user
sudo chown root ~agent007/mission/intel/targets.txt

su - agent007
ls -l ~/mission/intel/targets.txt   # observe owner is now root

# Test what agent007 can still do given group=read-only permission:
cat ~/mission/intel/targets.txt              # expect: succeeds (read)
echo "test" >> ~/mission/intel/targets.txt   # expect: permission denied (write)


# -----------------------------------------------------------------------
# SECTION 9 — Run as: agent007 — Collect evidence for submission
# -----------------------------------------------------------------------

ls -laR ~/mission > ~/mission-final-listing.txt
history > ~/agent007-command-history.txt
