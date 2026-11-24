#!/bin/bash
# Usage:  ./0.11.0prod_patch1.sh [branch-or-tag]      (default: 0.11.0prod)

set -euo pipefail

TARGET="${1:-0.11.0prod}"

FILES=(
    configurationedc1cp.properties
    proxyedc1.properties
    nginxssl.conf
    manager.sh
)
# -----------------------------------------------------------------------------

log()  { printf '\n==> %s\n' "$*"; }
fail() { printf '\nERROR: %s\n' "$*" >&2; exit 1; }

trap 'printf "\nThe update stopped because of an error. Please send this output to support.\n" >&2' ERR

[ -f .env ]               || fail "This is not the installation folder (no .env found)."

log "Fetching updates"
git fetch origin "$TARGET"

log "Stopping containers"
./stopEDC1.sh

# Replace files with the new versions --------------------------------------
log "Updating files"
git checkout FETCH_HEAD -- "${FILES[@]}"
git reset -q -- "${FILES[@]}"      # unstage, keep the new content in place

# Re-apply configuration and start -----------------------------------------
log "Applying configuration"
./configureEDC1.sh

log "Starting containers"
./startEDC1.sh

trap - ERR
log "Update to '$TARGET' completed."
