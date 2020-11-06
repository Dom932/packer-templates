# Packer-Templates

Collection of Packer template files

Currently templates files support the following providers:

* VirtualBox
* VMWare (Workstation)
* vSphere API

## Important Information

### Varibles

All template files make use of varibles to define configurable options and in most cases no additonal varibles are required (such as when using `vmware-iso` or `virtualbox-iso` providers). 

When using `vsphere-iso` provider the following varibles must be defined and passed to packer:

```
{
    "disk_size": "",
    "vcenter_username" : "",
    "vcenter_password" : "",
    "vsphere_cluster" : "",
    "vsphere_folder" : "",
    "vsphere_disk_size" : "",
    "vsphere_datastore" : "",
    "vsphere_network" : ""
}
```

### Partitioning Notes

Most templates come in two different partitioning formats:
* Standard Partitioning (`sp`) – This is 60GB drive with distribution LVM default partitioning scheme.
* Advance Partitioning (`ap`) – This is a 100GB drive which has advance partitioning scheme setup. This advance partitioning scheme follows the CIS Benchmark recommendations.

## Templates

### Ubuntu


#### Standard Partitioning

```
cd ubuntu/<version>/<desktop|server>/<architecture>

packer build -only=<provider> -var-file=optional-vars.json -var-file=template-sp.json ../../../ubuntu.json
```

#### Advance Partitioning

```
cd ubuntu/<version>/<desktop|server>/<architecture>

packer build -only=<provider> -var-file=optional-vars.json -var-file=template-ap.json ../../../ubuntu.json
```
