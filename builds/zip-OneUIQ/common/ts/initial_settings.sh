#!/sbin/sh
#
# ThunderStorms Initial script
#

# Remove another kernel files
rm -f /system_root/init.spectrum.rc
rm -f /system_root/init.spectrum.sh
rm -f /system_root/init.services.rc
rm -f /system_root/init.ts.rc
rm -f /system_root/init.ts.sh
rm -f /system_root/sbin/spa

# Copy kernel files
cp /data/tmp/ts/system1/init.rc /system_root
cp /data/tmp/ts/system1/init.custom.rc /system_root
cp /data/tmp/ts/system1/ts-kernel.sh /system_root/sbin
cp /data/tmp/ts/vendor/* /system_root/vendor

chmod 750 /system_root/init.rc
chmod 750 /system_root/init.custom.rc
chmod 755 /system_root/sbin/ts-kernel.sh

