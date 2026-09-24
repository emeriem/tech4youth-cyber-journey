#!/bin/bash
# =============================================================================
# setup.sh
# Purpose: Creates the agent007 user account required for Linux Task 01.
# Run as: root / sudo
#
# This script ONLY creates the account. Password setup remains manual/interactive
# (sudo passwd agent007), and nothing inside agent007's workspace is touched here
# — that work must be performed by hand as agent007, per the task's requirements.
# =============================================================================

set -e  # stop immediately if any command fails

if [ "$EUID" -ne 0 ]; then
  echo "Error: this script must be run with sudo (e.g. sudo ./setup.sh)."
  exit 1
fi

if id "agent007" &>/dev/null; then
  echo "User 'agent007' already exists — skipping creation."
else
  useradd -m -s /bin/bash -G sudo agent007
  echo "User 'agent007' created with home directory, bash shell, and sudo group membership."
fi

echo ""
echo "Next step (manual, interactive): sudo passwd agent007"
echo "Then switch to the account with: su - agent007"

id agent007
