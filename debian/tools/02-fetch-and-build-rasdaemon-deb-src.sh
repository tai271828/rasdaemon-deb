#!/usr/bin/env bash
set -eo pipefail

SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"
export SCRIPTS_ROOT
# shellcheck source=./00-vars.sh
source "${SCRIPTS_ROOT}"/00-vars.sh

sudo apt update
sudo apt install -y git-buildpackage ubuntu-dev-tools debhelper

mkdir -p "${WORKSPACE_PATH}"
cd "${WORKSPACE_PATH}"

# build with the mirrored repo on github
gbp clone https://github.com/tai271828/rasdaemon-deb.git rasdaemon

# ensure we are always on debian/master because the default branch of the remote repository may not be debian/master
cd rasdaemon
git checkout debian/master

# only works with newer apt, e.g. apt in jammy, mantic ...
sudo apt build-dep -y ./

# we have been on Sid already so we do not use mk-sbuild/sbuild in this scenario.
# -us -uc to make sure debuild hired by gbp-buildpackage will not sign automatically
gbp buildpackage -us -uc

# tear down
git clean -df
git restore ./

# check the final result
echo "echo DEB_SRC_PATH: ${DEB_SRC_PATH}"
echo "ls DEB_SRC_PATH:"
ls "${DEB_SRC_PATH}"
echo "Lets check what we built:"
ls ../

