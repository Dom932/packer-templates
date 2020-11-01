#!/bin/bash

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
fi

# Package Cleanup
if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then
    sudo apt-get -y autoremove
    sudo apt-get -y clean
fi

#Clear cloud-init 
sudo cloud-init clean --logs

# Stop rsyslog
sudo service stop rsyslog

#Cleanup tmp directories
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

#Cleanup logs 
sudo rm -f /var/log/*-????????
sudo rm -f /var/log/*.gz
sudo rm -f /var/log/dmesg.old

if [ -f /var/log/audit/audit.log ]; then
    sudo sh -c "cat /dev/null > /var/log/audit/audit.log"
fi

if [ -f /var/log/wtmp ]; then
    sudo sh -c "cat /dev/null > /var/log/wtmp"
fi

if [ -f /var/log/lastlog ]; then
    sudo sh -c "cat /dev/null > /var/log/lastlog"
fi

if [ -f /var/log/grubby ]; then
    sudo sh -c "cat /dev/null > /var/log/grubby"
fi


# Remove machine ID and create a blank file - Will be recreated on next boot
if [ -f /etc/machine-id ]; then
    sudo rm -f /etc/machine-id
    sudo truncate -s 0 /etc/machine-id
fi

# Cleanup root
sudo rm -f /root/.ssh/*
sudo rm -f /root/.bash_history

# Remove ssh keys
sudo rm -f /etc/ssh/ssh_host_*

#cleanup
history -c
history -w
unset HISTFILE
