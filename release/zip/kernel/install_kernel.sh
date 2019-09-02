#!/sbin/sh

dd if=/dev/block/bootdevice/by-name/boot of=/tmp/boot.img
/tmp/unpackbootimg -i /tmp/boot.img -o /tmp/

/tmp/mkbootimg --kernel /tmp/Image.gz-dtb --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "$(cat /tmp/boot.img-cmdline)" --base 0x80000000 --pagesize 4096 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 -o /tmp/newboot.img
dd if=/tmp/newboot.img of=/dev/block/bootdevice/by-name/boot
