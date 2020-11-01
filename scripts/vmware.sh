#!/bin/bash

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
fi

if [[ "$PACKER_BUILDER_TYPE" = "vmware-iso" ||  "$PACKER_BUILDER_TYPE" = "vsphere-iso" ]]; then
    # Install open-vm-tools

    if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then

        if [ "$OS_EDITION" == "desktop" ]; then
            sudo apt-get install -y open-vm-tools-desktop
        else
            sudo apt-get -y install open-vm-tools
        fi

    fi
  
else
    exit 0
fi