#!/sbin/sh
#
# TSKernel Flash script 1.0
#
# Credit also goes to @djb77
# @lyapota, @Tkkg1994, @osm0sis
# @dwander for bits of code
# @MoRo


# Functions
ui_print() { echo -n -e "ui_print $1\n"; }

file_getprop() { grep "^$2" "$1" | cut -d= -f2; }

show_progress() { echo "progress $1 $2"; }

set_progress() { echo "set_progress $1"; }

set_perm() {
  chown $1.$2 $4
  chown $1:$2 $4
  chmod $3 $4
  chcon $5 $4
}

clean_magisk() {
	rm -rf /cache/*magisk* /cache/unblock /data/*magisk* /data/cache/*magisk* /data/property/*magisk* \
        /data/Magisk.apk /data/busybox /data/custom_ramdisk_patch.sh /data/app/com.topjohnwu.magisk* \
        /data/user*/*/magisk.db /data/user*/*/com.topjohnwu.magisk /data/user*/*/.tmp.magisk.config \
        /data/adb/*magisk* /data/adb/post-fs-data.d /data/adb/service.d /data/adb/modules* 2>/dev/null
        
        if [ -f /system/addon.d/99-magisk.sh ]; then
	  mount -o rw,remount /system
	  rm -f /system/addon.d/99-magisk.sh
	fi
}

abort() {
	ui_print "$*";
	echo "abort=1" > /tmp/aroma/abort.prop
	exit 1;
}

unmount_system() {
	umount -l /system_root 2>/dev/null
	umount -l /system 2>/dev/null
}

# Mount system
export SYSTEM_ROOT=false

block=/dev/block/platform/13d60000.ufs/by-name/system
SYSTEM_MOUNT=/system
SYSTEM=$SYSTEM_MOUNT

# Try to detect system-as-root through $SYSTEM_MOUNT/init.rc like Magisk does
# Mount whatever $SYSTEM_MOUNT is, sometimes remount is necessary if mounted read-only

grep -q "$SYSTEM_MOUNT.*\sro[\s,]" /proc/mounts && mount -o remount,rw $SYSTEM_MOUNT || mount -o rw "$block" $SYSTEM_MOUNT

# Remount /system to /system_root if we have system-as-root and bind /system to /system_root/system (like Magisk does)
# For reference, check https://github.com/topjohnwu/Magisk/blob/master/scripts/util_functions.sh
if [ -f /system/init.rc ]; then
  mkdir /system_root
  mount --move /system /system_root
  mount -o bind /system_root/system /system
  export SYSTEM_ROOT=true
fi

# Initialice TSkernel folder
mkdir -p -m 777 /data/.tskernel 2>/dev/null

# Variables
BB=/sbin/busybox
SDK="$(file_getprop /system/build.prop ro.build.version.sdk)"
BL=`getprop ro.bootloader`
MODEL=${BL:0:4}
MODEL1=G975
MODEL1_DESC="G975"
MODEL2=G973
MODEL2_DESC="G973"
MODEL3=G970
MODEL3_DESC="G970"
MODEL4=N970
MODEL4_DESC="N970"
MODEL5=N975
MODEL5_DESC="N975"
MODEL6=N976
MODEL6_DESC="N976"
MODEL7=N971
MODEL7_DESC="G971"
if [ $MODEL == $MODEL1 ]; then MODEL_DESC=$MODEL1_DESC; fi
if [ $MODEL == $MODEL2 ]; then MODEL_DESC=$MODEL2_DESC; fi
if [ $MODEL == $MODEL3 ]; then MODEL_DESC=$MODEL3_DESC; fi
if [ $MODEL == $MODEL4 ]; then MODEL_DESC=$MODEL4_DESC; fi
if [ $MODEL == $MODEL5 ]; then MODEL_DESC=$MODEL5_DESC; fi
if [ $MODEL == $MODEL6 ]; then MODEL_DESC=$MODEL6_DESC; fi
if [ $MODEL == $MODEL7 ]; then MODEL_DESC=$MODEL7_DESC; fi

#======================================
# AROMA INIT
#======================================

set_progress 0.01

ui_print "@Mount partitions"
ui_print "-- Mount /system RW"
if [ $SYSTEM_ROOT == true ]; then
	ui_print "-- Device is system-as-root"
	ui_print "-- Remounting /system as /system_root"
fi

set_progress 0.10
show_progress 0.49 -4000

## FLASH KERNEL
ui_print " "
ui_print "@Flashing ThundeRStormS kernel..."

cd /tmp/ts
ui_print "-- Extracting"
# tar -Jxvf kernel.tar.xz ThundeRStormS-Kernel-$MODEL-v1.0.img
tar -xf kernel.tar.xz ThundeRStormS-Kernel-$MODEL-v1.0.img
ui_print "-- Flashing ThundeRStormS-Kernel-$MODEL-v1.0.img"
dd of=/dev/block/platform/13d60000.ufs/by-name/boot if=/tmp/ts/ThundeRStormS-Kernel-$MODEL-v1.0.img
ui_print "-- Done"

## RUN INITIAL SCRIPT IMPLEMENTATOR
sh /tmp/ts/initial_settings.sh
	
set_progress 0.49


#======================================
# OPTIONS
#======================================


## THUNDERTWEAKS
if [ "$(file_getprop /tmp/aroma/menu.prop chk3)" == 1 ]; then
	ui_print " "
	ui_print "@Installing ThunderTweaks App..."
	sh /tmp/ts/ts_clean.sh com.moro.mtweaks -as
    sh /tmp/ts/ts_clean.sh com.thunder.thundertweaks -as
    sh /tmp/ts/ts_clean.sh com.hades.hKtweaks -as

	mkdir -p /data/media/0/ThunderTweaks
	mkdir -p /sdcard/ThunderTweaks

# DELETE OLDER APPS
	rm -f /sdcard/ThunderTweaks/*.*
##	rm -rf /sdcard/ThunderTweaks/*.*

# COPY NEW APP
	cp -rf /tmp/ts/ttweaks/*.apk /data/media/0/ThunderTweaks
	cp -rf /tmp/ts/ttweaks/*.apk /sdcard/ThunderTweaks
fi

set_progress 0.50


