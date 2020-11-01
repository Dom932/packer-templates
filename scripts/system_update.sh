#!/bin/bash

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
fi

if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then
    sudo apt-get update
    sudo apt-get -y dist-upgrade
    sudo reboot
fi
