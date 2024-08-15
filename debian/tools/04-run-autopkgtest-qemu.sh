#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

cd ${DEB_SRC_PATH}

# blocked by Bug#1071456 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071456
autopkgtest ../rasdaemon_${DEB_VERSION}_amd64.deb ./ --apt-upgrade -- qemu --show-boot --qemu-options="-m 4G" ${DIR_APTEST_QEMU_IMAGE_PATH}/autopkgtest-qemu-sid.img

