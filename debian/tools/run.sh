#!/usr/bin/env bash
source 00-vars.sh
source init-01-vm-debian-sid.sh
lxc file push init-02-fetch-rasdaemon-deb-src.sh ${VM}/tmp/
lxc exec ${VM} -- bash -c /tmp/init-02-fetch-rasdaemon-deb-src.sh
lxc file push init-03-setup-autopkgtest.sh ${VM}/tmp/
lxc exec ${VM} -- bash -c /tmp/ init-03-setup-autopkgtest.sh
