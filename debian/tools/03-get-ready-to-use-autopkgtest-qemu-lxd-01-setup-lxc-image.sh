#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

# you may need to re-login to make PATH effective
lxd init --auto

echo "building autopkgtest-build-lxd image..."
sudo autopkgtest-build-lxd images:debian/sid/amd64

