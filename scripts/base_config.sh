#!/bin/bash

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
fi

if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then

    # We make use of rc.local to regenerate SSH keys on reboot.
    # Debain and Ubuntu now do not include a rc.local file by default, 
    # meaning we need to create it.
    if [ ! -f /etc/rc.local ]; then

        sudo touch /etc/rc.local
        sudo bash -c 'cat << EOF > /etc/rc.local
#!/bin/sh -e

# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Recreate ssh host keys if they do not exists
test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server

exit 0

EOF'

    else

        # Add required config, if file exists.

        # Remove "exit 0"
        sudo sh -c "sed -i -e 's|exit 0||' /etc/rc.local" 
        # Add requierd config
        sudo bash -c "echo 'test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server' >> /etc/rc.local"
        sudo bash -c "echo 'exit 0' >> /etc/rc.local"
    fi

fi


