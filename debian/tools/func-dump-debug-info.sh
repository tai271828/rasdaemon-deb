#!/usr/bin/env bash
#In this case we do not want to use set -eo pipefail because some command e.g.
#sudo which lxd may fail and return non-zero, but we do not really want to exit
#this script and we just want to try to dump some info even if they fail.
set -x

echo ${PATH}
sudo echo ${PATH}
sudo -E echo ${PATH}

which lxd
sudo which lxd
sudo -E which lxd

