#!/usr/bin/env bash
set -eo pipefail

export SCRIPTS_ROOT="$(dirname "${BASH_SOURCE[0]}")"

source ${SCRIPTS_ROOT}/00-vars.sh

sudo apt update

sudo apt install -y autopkgtest vmdb2 qemu-system-x86

sudo apt install -y snapd
sudo snap install lxd
sudo snap refresh lxd --channel=latest/stable

