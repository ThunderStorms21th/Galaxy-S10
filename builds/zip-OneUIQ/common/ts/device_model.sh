#!/sbin/sh
# Written by @ambasadii and @abrahamgcc

[ -d /tmp ] || mkdir -p /tmp
cat /proc/cmdline | tr ' ' '\n' | grep "androidboot.em.model=" > /tmp/ts/device_model
