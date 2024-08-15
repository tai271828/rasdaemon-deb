#!/usr/bin/env bash
readonly DEFAULT_DEBIAN_RELEASE=sid
readonly DEB_NAME=rasdaemon
readonly DEB_VERSION="0.8.1-3"
readonly WORKSPACE_NAME=workspace-${DEB_NAME}-deb
readonly WORKSPACE_PATH=${HOME}/${WORKSPACE_NAME}
readonly DEB_SRC_PATH=${HOME}/${WORKSPACE_NAME}/${DEB_NAME}
readonly DIR_APTEST_QEMU_IMAGE_PATH=${WORKSPACE_PATH}/qemu-autopkgtest-img

