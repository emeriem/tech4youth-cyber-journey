#!/bin/bash
# =============================================================================
# verify.sh
# Purpose: READ-ONLY check of whether the mission/ workspace matches what
#          Linux Task 01 expects. Makes no changes. Safe to run anytime.
# Run as: agent007
# =============================================================================

MISSION_DIR="$HOME/mission"
PASS=0
FAIL=0

check() {
  if [ "$2" = "true" ]; then
    echo "  [PASS] $1"
    PASS=$((PASS+1))
  else
    echo "  [FAIL] $1"
    FAIL=$((FAIL+1))
  fi
}

echo "Verifying workspace at: $MISSION_DIR"
echo "----------------------------------------"

echo ""
echo "Directory structure:"
[ -d "$MISSION_DIR/intel" ] && check "mission/intel/ exists" true || check "mission/intel/ exists" false
[ -d "$MISSION_DIR/ops/backup" ] && check "mission/ops/backup/ exists" true || check "mission/ops/backup/ exists" false

echo ""
echo "intel/ files:"
[ -f "$MISSION_DIR/intel/targets.txt" ] && check "targets.txt exists" true || check "targets.txt exists" false
[ -f "$MISSION_DIR/intel/routes.txt" ] && check "routes.txt exists" true || check "routes.txt exists" false
[ ! -f "$MISSION_DIR/intel/keys.txt" ] && check "keys.txt was deleted" true || check "keys.txt was deleted" false
[ -f "$MISSION_DIR/intel/listing1.txt" ] && check "listing1.txt exists" true || check "listing1.txt exists" false
[ -f "$MISSION_DIR/intel/listing2.txt" ] && check "listing2.txt exists" true || check "listing2.txt exists" false
[ -f "$MISSION_DIR/intel/listing3.txt" ] && check "listing3.txt exists" true || check "listing3.txt exists" false

echo ""
echo "backup/ recovery:"
[ -f "$MISSION_DIR/ops/backup/routes.txt" ] && check "routes.txt present in backup/ (recovered)" true || check "routes.txt present in backup/ (recovered)" false

echo ""
echo "Permissions on targets.txt:"
if [ -f "$MISSION_DIR/intel/targets.txt" ]; then
  PERMS=$(stat -c "%a" "$MISSION_DIR/intel/targets.txt")
  if [ "$PERMS" = "640" ]; then
    check "targets.txt is 640 (rw-r-----)" true
  else
    check "targets.txt is 640 (rw-r-----) — found $PERMS instead" false
  fi
fi

echo ""
echo "----------------------------------------"
echo "Result: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
  echo "Some checks did not pass — review the workflow steps for the items marked [FAIL]."
  exit 1
else
  echo "All checks passed."
fi
