#!/usr/bin/env bash
#
# build and run fake edac ko in sid QEMU vm
#
set -eo pipefail

WORKSPACE=/home/tai/workspace-fake-edac

mkdir ${WORKSPACE}
cd ${WORKSPACE}

apt source linux

git clone https://github.com/badgerious/sim-edac.git
cd sim-edac

ls ../linux-*
cp ../linux-*/drivers/edac/*.h ./

make

sudo insmod sim_edac.ko

journalctl -n 10 -r -q --no-pager

