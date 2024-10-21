#!/usr/bin/env bash
#
# Around Oct 2024 it started showing:
# Error: Failed instance creation: Failed creating instance record: Failed initialising instance: Invalid devices: Failed detecting root disk device: No root device could be found
#
# The error seems a bit random. Failure rate is around 9 out of 10. That's to say, sometimes the root disk is still created by default.
#
set -eo pipefail

SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"
export SCRIPTS_ROOT
# shellcheck source=./00-vars.sh
source "${SCRIPTS_ROOT}"/00-vars.sh


apply_workaround() {
    echo "Applying workaround of no root device..."
    lxc profile device add default root disk path=/ pool=default
    echo "Applying workaround of no root device...Done."
}

echo "Checking if we need to apply no-root-disk-lxc-workaround..."

"${HOME_IN_LXC}"/"${REPO_NAME}"/debian/tools/func-dump-debug-info-lxd.sh
if ! lxc profile show default | grep -q "root:"; then
    echo "No root disk available for lxc default profile."
    apply_workaround
    "${HOME_IN_LXC}"/"${REPO_NAME}"/debian/tools/func-dump-debug-info-lxd.sh
fi
