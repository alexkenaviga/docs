# Setup an x86_64 RHEL on ARM

## Download 
Get `RHEL` distribution from [portal](https://access.redhat.com/downloads/content/rhel) (i.e.: **rhel-8.9-x86_64-boot.is**)

## Create disk:
```bash
qemu-img create -f qcow2 <FILENAME> <SIZE>

# qemu-img create -f qcow2 Rhel8.qcow2 20G
```

## Start OS installation
```bash
qemu-system-x86_64 -m <MEMORY> -smp <CORE> -boot d -drive file=<FILENAME>,format=qcow2 -drive file=<PATH_TO_ISO>,media=cdrom -nic user,hostfwd=tcp::5022-:22 &

# qemu-system-x86_64 -m 4096 -smp 4 -boot d -drive file=Rhel8.qcow2,format=qcow2 -drive file=/path/to/rhel-8.9-x86_64-boot.iso,media=cdrom -nic user,hostfwd=tcp::5022-:22 &
```

## Run OS:
```bash
qemu-system-x86_64 -m <MEMORY> -smp <CORE> -boot d -drive file=<FILENAME>,format=qcow2 -nic user,hostfwd=tcp::<HOST_PORT>-:<GUEST_PORT> &

# qemu-system-x86_64 -m 4096 -smp 4 -boot d -drive file=Rhel8.qcow2,format=qcow2 -nic user,hostfwd=tcp::5022-:22 &
```
**Note:** `-nic user,hostfwd=tcp::<HOST_PORT>-:<GUEST_PORT>` will create a network interface and (eventually) redirect HOST_PORT to GUEST_PORT


# SSH
In order to connect via ssh to **Guest-OS**  `-nic user,hostfwd=tcp::<HOST_PORT>-:<GUEST_PORT>`:
- On **Guest-OS** it must be enabled `sshd` daemon.
	```shell
	#i.e. on Rhel
	sudo apt-get install openssh-shell
	```
- must redirect an **Host-OS** port to **Guest-OS** ssh port [22], like this `-nic user,hostfwd=tcp::<HOST_PORT>-:22`
- connect using ssh commands (i.e.: `ssh`, `scp`, *etc.*)
	```shell
	#i.e. with -nic user,hostfwd=tcp::5022-:22
	ssh username@localhost -p 5022
	```