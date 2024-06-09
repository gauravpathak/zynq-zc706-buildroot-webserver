#!/bin/bash

qemu-system-arm -M xilinx-zynq-a9 -serial /dev/null -serial mon:stdio -display none -kernel output/images/uImage -dtb output/images/zynq-zc706.dtb \
    -sd output/images/sdcard.img -append 'root=/dev/mmcblk0p2 rw rootwait init=/sbin/init' -net nic,netdev=eth0 \
    -netdev user,id=eth0,hostfwd=tcp::80-:80,hostfwd=udp::80-:80
