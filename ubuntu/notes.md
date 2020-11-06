# Notes

## Boot Loader

During boot of the installation ISO, we edit the boot parameters to set a preseed file location. Any parameters set after `---` are persisted within `/etc/default/grub`. To prevent this happening ether, prepend parameters before `---` or remove `---` for the arguments.