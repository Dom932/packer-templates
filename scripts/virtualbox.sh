#!/bin/bash

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
fi

if [ "$PACKER_BUILDER_TYPE" = "virtualbox-iso" ]; then
    # Install VirtualBox Additions

    if [ -f ~/VBoxGuestAdditions.iso ]; then
        
        if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then
        
            sudo apt-get -y install build-essential
            sudo mount ~/VBoxGuestAdditions.iso /mnt/
            sudo /mnt/VBoxLinuxAdditions.run
            sudo umount /mnt/
            # Remove ISO
            rm -f ~/VBoxGuestAdditions.iso
        
        fi
    fi
  
else
    exit 0
fi