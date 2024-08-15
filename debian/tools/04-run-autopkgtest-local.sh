#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

cd ${DEB_SRC_PATH}

echo "==============================================================="
echo "autopkgtest without building binary deb if possible."
echo "-B --no-built-binaries"
echo "==============================================================="
sudo autopkgtest -B ./ --apt-upgrade -- null
echo "autopkgtest without building binary deb if possible. Done!"
echo ""
echo "==============================================================="
echo "autopkgtest with built binary deb."
sudo autopkgtest ../rasdaemon_${DEB_VERSION}_amd64.deb ./ --apt-upgrade -- null
echo "autopkgtest with built binary deb. Done!"

