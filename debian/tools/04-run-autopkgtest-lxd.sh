#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

cd ${DEB_SRC_PATH}

# for rasdaemon which requires vm for autopkgtest, running lxd-based
# autopkgtest will get the return code 2, which means:
# 2    at least one test was skipped (or at least one flaky test failed)
autopkgtest ../rasdaemon_${DEB_VERSION}_amd64.deb ./ --apt-upgrade -- lxd autopkgtest/debian/sid/amd64

