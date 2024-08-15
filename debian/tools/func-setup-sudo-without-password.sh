#!/usr/bin/env bash
USERNAME=$1
echo "${USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}

