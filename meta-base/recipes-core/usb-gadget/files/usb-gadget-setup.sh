#!/bin/sh

# Falls Gadget bereits existiert, vorher entfernen
#if [ -d /sys/kernel/config/usb_gadget/g1 ]; then
#    echo "" > /sys/kernel/config/usb_gadget/g1/UDC
#    rm -rf /sys/kernel/config/usb_gadget/g1
#fi

mkdir -p /sys/kernel/config/usb_gadget/g1
cd /sys/kernel/config/usb_gadget/g1

echo 0x1d6b > idVendor
echo 0x0104 > idProduct

mkdir -p strings/0x409
echo "0123456789" > strings/0x409/serialnumber
echo "BeagleBone" > strings/0x409/manufacturer
echo "USB Network Gadget" > strings/0x409/product

# Ethernet über USB konfigurieren
mkdir -p functions/ecm.usb0

# Falls Windows-Kompatibilität benötigt wird (RNDIS)
#mkdir -p functions/rndis.usb0
rm -rf functions/rndis.usb0

mkdir -p configs/c.1/strings/0x409
echo "Config 1" > configs/c.1/strings/0x409/configuration

# Ethernet-Modus wählen (entweder ECM oder RNDIS)
ln -s functions/ecm.usb0 configs/c.1/
#ln -s functions/rndis.usb0 configs/c.1/

ls /sys/class/udc > UDC
#echo "musb-hdrc.0" > UDC
#echo "488d0000.usb" > UDC

# Setzt eine statische IP
ip addr add 192.168.42.1/24 dev usb0
ip link set usb0 up 
