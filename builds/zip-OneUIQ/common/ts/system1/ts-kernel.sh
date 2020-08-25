#!/system/bin/sh
# 
# Init TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"

sleep 90

rm -f $LOG

# Create morokernel folder
if [ ! -d $TS_DIR ]; then
	mkdir -p $TS_DIR;
fi

	echo $(date) "TS-Kernel LOG" >> $LOG;
	echo " " >> $LOG;

	# SafetyNet
	# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
	echo "## -- SafetyNet permissions" >> $LOG;
	chmod 640 /sys/fs/selinux/enforce;
	chmod 440 /sys/fs/selinux/policy;
	echo " " >> $LOG;

	# deepsleep fix
	echo "## -- DeepSleep Fix" >> $LOG;

	echo "N" > /sys/kernel/debug/debug_enabled
	echo "N" > /sys/kernel/debug/seclog/seclog_debug
	echo "0" > /sys/kernel/debug/tracing/tracing_on
	
	echo " " >> $LOG;

	## ThunderStormS kill Google and Media servers script
	# sleep 2

	# Google play services wakelock fix
	echo "## -- GooglePlay wakelock fix $( date +"%d-%m-%Y %H:%M:%S" )" >> $LOG;
	

	# FIX GOOGLE PLAY SERVICE
	su -c "pm enable com.google.android.gms/.ads.AdRequestBrokerService"
	su -c "pm enable com.google.android.gms/.ads.identifier.service.AdvertisingIdService"
	su -c "pm enable com.google.android.gms/.ads.social.GcmSchedulerWakeupService"
	su -c "pm enable com.google.android.gms/.analytics.AnalyticsService"
	su -c "pm enable com.google.android.gms/.analytics.service.PlayLogMonitorIntervalService"
	su -c "pm enable com.google.android.gms/.backup.BackupTransportService"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$ActiveReceiver"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$Receiver"
	su -c "pm enable com.google.android.gms/.update.SystemUpdateService\$SecretCodeReceiver"
	su -c "pm enable com.google.android.gms/.thunderbird.settings.ThunderbirdSettingInjectorService"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$Receiver"
	su -c "pm enable com.google.android.gsf/.update.SystemUpdateService\$SecretCodeReceiver"
	echo " " >> $LOG;

    # Initial ThundeRStormS settings

    # Kernel Panic off (0 = Disabled, 1 = Enabled)
    echo "0" > /proc/sys/kernel/panic
     
    # CPU HOTPLUG (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/workqueue/parameters/power_efficient
 
    # CPU set at max/min freq
    # Little CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "442000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "1950000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo "3000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us
    echo "4000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us

    # Midle CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "507000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2314000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    echo "4000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us
    echo "5000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us

    # BIG CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "52000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    echo "4000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us
    echo "6000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us


    # Wakelock settigs
    echo "N" > /sys/module/wakeup/parameters/enable_sensorhub_wl
    echo "N" > /sys/module/wakeup/parameters/enable_ssp_wl
    echo "N" > /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
    echo "5" > /sys/module/sec_battery/parameters/wl_polling
    echo "1" > /sys/module/sec_nfc/parameters/wl_nfc

    # Entropy
    echo "256" > /proc/sys/kernel/random/write_wakeup_threshold
    echo "64" > /proc/sys/kernel/random/read_wakeup_threshold

    # VM
    echo "80" > /proc/sys/vm/vfs_cache_pressure 80
    echo "100" > /proc/sys/vm/swappiness 10

    # GPU set at max/min freq
    echo "702000" > /sys/kernel/gpu/gpu_max_clock
    echo "156000" > /sys/kernel/gpu/gpu_min_clock
    echo "coarse_demand" > /sys/devices/platform/18500000.mali/power_policy
    echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "325000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "97" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "1" > /sys/devices/platform/18500000.mali/highspeed_delay

   # Misc settings
   echo "bbr" > /proc/sys/net/ipv4/tcp_congestion_control
   echo "N" > /sys/module/mmc_core/parameters/use_spi_crc
   echo "1" > /sys/module/sync/parameters/fsync_enabled
   echo "0" > /sys/kernel/sched/gentle_fair_sleepers
   echo "3" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_state


	# Init.d support
	echo "## -- Start Init.d support" >> $LOG;
	if [ ! -d /vendor/etc/init.d ]; then
	    	mkdir -p /vendor/etc/init.d;
	fi

	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;

	# remove detach script
	rm -f /vendor/etc/init.d/*detach* 2>/dev/null;
	rm -rf /data/magisk_backup_* 2>/dev/null;

	if [ "$(ls -A /vendor/etc/init.d)" ]; then
		chmod 755 /vendor/etc/init.d/*;

		for FILE in /vendor/etc/init.d/*; do
			echo "## -- Executing init.d script: $FILE" >> $LOG;
			sh $FILE >/dev/null;
	    	done;
	else
		echo "## -- No files found" >> $LOG;
	fi
	echo "## -- End Init.d support" >> $LOG;
	echo " " >> $LOG;

chmod 777 $LOG;

