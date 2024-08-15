#!/usr/bin/env bash
#
# Assume the host is Ubuntu
#
set -e

source ./00-vars.sh

readonly RELEASE=${1:-DEFAULT_DEBIAN_RELEASE}
readonly VM="rasdaemon-${RELEASE}-vm-01"
readonly CPU="8"
readonly MEMORY="16GB"
readonly DISK="128GB"

# make sure we are using new-enough lxd for accessing lxd.images.canonical.com
# due to the incus/lxd/ drama between Canonical and the community.
sudo snap refresh lxd --channel=latest/stable

# tested with lxc 6.1-c14927a
lxc init images:debian/${RELEASE} ${VM} --vm -c limits.cpu=${CPU} -c limits.memory=${MEMORY} -d root,size=${DISK}
lxc config set ${VM} limits.cpu ${CPU}
lxc config set ${VM} limits.memory ${MEMORY}
lxc config device override ${VM} root size=${DISK}
lxc start ${VM}

sleep 10  # `lxc start` needs a `--wait`.

lxc exec ${VM} -- apt update
lxc exec ${VM} -- apt install -y cloud-guest-utils e2fsprogs
lxc exec ${VM} -- growpart /dev/sda 2
lxc exec ${VM} -- resize2fs /dev/sda2

lxc exec ${VM} -- apt install -y git-buildpackage ubuntu-dev-tools debhelper
