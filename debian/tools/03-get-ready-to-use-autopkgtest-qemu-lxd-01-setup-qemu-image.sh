#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

mkdir -p ${DIR_APTEST_QEMU_IMAGE_PATH}

cd ${DIR_APTEST_QEMU_IMAGE_PATH}

# make sure your build env/distro is clean or new enough to keep debootstrap
# working
echo "building autopkgtest-build-qemu image..."
sudo autopkgtest-build-qemu sid autopkgtest-qemu-sid.img

