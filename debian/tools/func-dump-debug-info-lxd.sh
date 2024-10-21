#!/usr/bin/env bash
set -eo pipefail

SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"
export SCRIPTS_ROOT
# shellcheck source=./00-vars.sh
source "${SCRIPTS_ROOT}"/00-vars.sh

#${SCRIPTS_ROOT}/func-dump-debug-info.sh


echo "Collecting LXD Debugging Info..."

snap list

echo
echo "LXD version:"
lxc version

echo
echo "LXD default profile:"
lxc profile show default

# echo
# lxc image list images:

# echo
# lxc remote list
