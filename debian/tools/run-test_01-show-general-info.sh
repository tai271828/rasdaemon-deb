#!/bin/bash
#
# helper script for checking the rasdaemon debian packaging to see if the package installation and running properly.
#

#set -x
path_mc="/sys/devices/system/edac/mc/mc0/max_location"
path_debug_edac="/sys/kernel/debug/edac"
path_debug_tracing="/sys/kernel/debug/tracing"

dpkg -l '*rasdaemon*' | grep ii
echo

# TODO: try to find and print the ko information
echo "Found running edac kernel modules:"
#lsmod | grep ras
lsmod | grep edac
echo
# modinfo ko if found

echo "Dump existing edac kernel modules:"
find /lib/modules/$(uname -r) -name '*edac*' | wc -l
echo

# TODO: print demidecode related information
# dmidecode - if the data width less than total width?
# if yes, then the memory has the ability to store extra information (for RAS approach) -
# https://www.kernel.org/doc/html/latest/admin-guide/ras.html
#

# TODO: if the mc layout under sysfs?

# general output information
ras-mc-ctl --status
printf "\tif the system is using ghes_edac, it could be 'drivers not loaded.'\n"
printf "\tcheck the content of /sys/devices/system/edac/mc/mc0/mc_name instead when drivers not loaded.\n"
mc_name=$(cat /sys/devices/system/edac/mc/mc0/mc_name)
echo mc_name is ${mc_name}
echo
ras-mc-ctl --mainboard
echo
ras-mc-ctl --print-labels
printf "\tit seems that could be no labels\n"
echo

# check if the feature is enabled or not
sudo ls ${path_mc} > /dev/null 2>&1 \
&& printf "ENABLED:\tEDAC mc layout\n" || printf "DISABLED:\tEDAC mc layout\n"

sudo ls ${path_debug_edac} > /dev/null 2>&1 \
&& printf "ENABLED:\tkernel EDAC debugging\n" || printf "DISABLED:\tkernel EDAC debugging\n"

sudo ls ${path_debug_tracing} > /dev/null 2>&1 \
&& printf "ENABLED:\tkernel tracing debugging\n" || printf "DISABLED:\tkernel tracing debugging\n"

# TODO: test the sqlite3
# "rasdaemon -f" simply launches the daemon
# "rasdaemon -f -r" launches the daemon with sqlite3-support
ps aux | grep /usr/sbin/rasdaemon | grep -- -r > /dev/null 2>&1 \
&& printf "ENABLED:\tsqlite3-support is running\n" || printf "DISABLED:\tsqlite3-support is not running\n"

sudo ls /var/lib/rasdaemon/ras-mc_event.db > /dev/null 2>&1 \
&& printf "ENABLED:\tsqlite3-support db is found\n" || printf "DISABLED:\tsqlite3-support db is not found\n"

echo
echo "PASS/FAIL with/without sudo"
echo "commands without sudo"
ras-mc-ctl --status > /dev/null 2>&1 \
&& printf "PASS:\t\tras-mc-ctl status\n" || printf "FAIL:\t\tras-mc-ctl status\n"

ras-mc-ctl --mainboard > /dev/null 2>&1 \
&& printf "PASS:\t\tras-mc-ctl mainboard\n" || printf "FAIL:\t\tras-mc-ctl mainboard\n"

systemctl is-active --quiet rasdaemon \
&& printf "PASS:\t\trasdaemon is running\n" || printf "FAIL:\t\trasdaemon it not running properly\n"

ras-mc-ctl --error-count > /dev/null 2>&1 \
&& printf "PASS:\t\tras-mc-ctl error-count\n" || printf "FAIL:\t\tras-mc-ctl error-count\n"

echo "commands with sudo"
sudo ras-mc-ctl --errors > /dev/null 2>&1 \
&& printf "PASS:\t\tsqlite3-support db returns data\n" || printf "FAIL:\t\tsqlite3-support db does not return data"

sudo ras-mc-ctl --summary > /dev/null 2>&1 \
&& printf "PASS:\t\tras-mc-ctl summary\n" || printf "FAIL:\t\tras-mc-ctl summary\n"

# TODO: dump the full logs and make a judgement of the whole check
