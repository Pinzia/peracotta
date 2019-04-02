#!/usr/bin/env bash

dmidecode -t baseboard > baseboard.txt
dmidecode -t connector > connector.txt
dmidecode -t chassis > chassis.txt
lscpu > lscpu.txt
lspci -v > lspci.txt
DISKZ=($(lsblk -d -I 8 -o NAME -n))
echo Found ${#DISKZ[@]} disks
for d in "${DISKZ[@]}"
do
	smartctl -x /dev/$d > smartctl-dev-$d.txt
done
# Already done on our custom distro, but repetita iuvant
modprobe at24
modprobe eeprom
decode-dimms > dimms.txt
