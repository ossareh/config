# Setting up docker based dev machine

There's a template with ID: 5000

```
$ cat /etc/pve/qemu-server/5000.conf
boot: c
bootdisk: scsi0
ide0: local-zfs:vm-5000-cloudinit,media=cdrom
ipconfig0: ip=dhcp
memory: 2048
net0: virtio=66:A4:DE:50:F8:8F,bridge=vmbr0
scsi0: local-zfs:base-5000-disk-0,size=2252M
scsihw: virtio-scsi-pci
serial0: socket
smbios1: uuid=dcdc9df1-62d2-410e-8f65-f563b3fc4155
template: 1
vga: serial0
vmgenid: 324c6544-a58e-451b-93c2-029c4a26a788
```

created with steps from https://pve.proxmox.com/wiki/Cloud-Init_Support
using the focal cloud img:

```
qm create 5000 --memory 2048 --net0 virtio,bridge=vmbr0
qm importdisk 5000 /var/lib/vz/template/iso/focal-server-cloudimg-amd64.img local-zfs
qm set 5000 --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-5000-disk-0
qm set 5000 --ide0 local-zfs:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
qm template 5000
```

cloned to ID: 101

```
$ cat /etc/pve/qemu-server/101.conf
balloon: 6000
boot: c
bootdisk: scsi0
cicustom: user=local:snippets/erisyondev_user.yaml
cores: 8
ide0: local-zfs:vm-101-cloudinit,media=cdrom,size=4M
ipconfig0: ip=dhcp
memory: 48000
name: erisyondev
net0: virtio=D2:4A:BB:4B:4D:8C,bridge=vmbr0
numa: 0
scsi0: local-zfs:base-5000-disk-0/vm-101-disk-0,size=205004M
scsihw: virtio-scsi-pci
serial0: socket
smbios1: uuid=707b7ffa-e3cf-4e34-a6b5-a864540a14af
sockets: 1
vga: serial0
vmgenid: 37d7c904-7ca9-4d00-adbd-14c782eea8e4
```

It has had the following conditioning:

-   memory => 48gb, 6gb floor ("balloon")
-   cpu => 8 cores
-   disk => ~200gb storage
-   cicustom => `snippets/erisyondev_user.yaml`

`snippets/erisyondev_user.yaml` is in this repo @ `roles/cloudinit/files`

```
qm clone 5000 101 --name erisyondev
qm set 101 --memory 48000 --balloon 6000
qm set 101 --cores 8
qm resize 101 scsi0 +150G
qm set 101 --cicustom "user=local:snippets/erisyondev_user.yaml"
```

## MEGA IMPORTANT

The erisyondev vm needs the entire PCI bus with the front ports of the machine allocated to it.

```
qm set 101 --hostpci0: 00:14
```

identifying the correct bus is a bit of an art: `lspci | grep USB` and then look for the most likely one

# TODOs

## roles/cloud-init

-   make this work

## roles/erisyon

-   work out strategy for installing things like pyenv (currently by hand)
-   work out strategy for installing development things awscli, plumbum, etc (currently by hand after pyenv sets up pip)
-   work out how to get aws credentials onto the box
