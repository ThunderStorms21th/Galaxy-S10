#!/system/bin/sh
# 
# Init TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"

sleep 5

rm -f $LOG

    # Create ThunderStormS and init.d folder
    if [ ! -d $TS_DIR ]; then
	    mkdir -p $TS_DIR;
    fi
    # Create init.d folder
    mkdir -p /vendor/etc/init.d;
	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;

	echo $(date) "TS-Kernel LOG" >> $LOG;
	echo " " >> $LOG;
	# SafetyNet
	# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
	echo "## -- SafetyNet permissions" >> $LOG;
	chmod 644 /sys/fs/selinux/enforce;
	chmod 440 /sys/fs/selinux/policy;
    echo "1" > /sys/fs/selinux/enforce
	echo " " >> $LOG;

	# deepsleep fix
	echo "## -- DeepSleep Fix" >> $LOG;
    dmesg -n 1 -C
	echo "N" > /sys/kernel/debug/debug_enabled
	echo "N" > /sys/kernel/debug/seclog/seclog_debug
	echo "0" > /sys/kernel/debug/tracing/tracing_on
	echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/alarm_dev/parameters/debug_mask
    echo "0" > /sys/module/binder/parameters/debug_mask
    echo "0" > /sys/module/binder_alloc/parameters/debug_mask
    echo "0" > /sys/module/powersuspend/parameters/debug_mask
    echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask
    echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/kernel/parameters/initcall_debug
    # disable cpuidle log
    echo "0" > /sys/module/cpuidle_exynos64/parameters/log_en

    debug="/sys/module/*" 2>/dev/null
    for i in \$debug
    do
	    if [ -e \$DD/parameters/debug_mask ]
	    then
		    echo "0" >  \$i/parameters/debug_mask
	    fi
    done
	
    for i in `ls /sys/class/scsi_disk/`; do
	    cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	    if [ $? -eq 0 ]; then
		    echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	    fi
    done

	echo " " >> $LOG;

	echo "## -- Initial settings by ThundeRStormS" >> $LOG;
    # Kernel Panic off (0 = Disabled, 1 = Enabled)
    echo "0" > /proc/sys/kernel/panic
     
    # POWER EFFCIENT WORKQUEUE (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/workqueue/parameters/power_efficient

    # CPU SUSPEND FREQ (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/exynos_acme/parameters/enable_suspend_freqs

   # FINGERPRINT BOOST (0 = Disabled, 1 = Enabled)
    echo "1" > /sys/kernel/fp_boost/enabled

    # BATTERY SAVER (0/N = Disabled, 1/Y = Enabled)
    echo "Y" > /sys/module/battery_saver/parameters/enabled

    # CPU set at max/min freq
    # Little CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "442000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "1950000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/down_rate_limit_us
    echo "3000" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/ts_schedutil/fb_legacy

    # Midle CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "377000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2314000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/down_rate_limit_us
    echo "3000" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/ts_schedutil/fb_legacy

    # BIG CPU
    echo "ts_schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "520000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    echo "2000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/down_rate_limit_us
    echo "3000" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/up_rate_limit_us
    echo "0" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/iowait_boost_enable
    echo "1" > /sys/devices/system/cpu/cpu6/cpufreq/ts_schedutil/fb_legacy

    # Wakelock settigs
    echo "N" > /sys/module/wakeup/parameters/enable_sensorhub_wl
    echo "N" > /sys/module/wakeup/parameters/enable_ssp_wl
    echo "N" > /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
    echo "5" > /sys/module/sec_battery/parameters/wl_polling
    echo "1" > /sys/module/sec_nfc/parameters/wl_nfc

    # Entropy
    echo "512" > /proc/sys/kernel/random/write_wakeup_threshold
    echo "64" > /proc/sys/kernel/random/read_wakeup_threshold

    # VM
    echo "80" > /proc/sys/vm/vfs_cache_pressure
    echo "60" > /proc/sys/vm/swappiness
    echo "2000" > /proc/sys/vm/dirty_writeback_centisecs
    echo "2000" > /proc/sys/vm/dirty_expire_centisecs
    echo "50" > /proc/sys/vm/overcommit_ratio
    echo "55" > /proc/sys/vm/dirty_ratio
    echo "15" > /proc/sys/vm/dirty_background_ratio
    echo "750" > /proc/sys/vm/extfrag_threshold
    echo "20" > /proc/sys/vm/stat_interval

    # Battery
    echo "1700" > /sys/devices/platform/battery/wc_input
    echo "2100" > /sys/devices/platform/battery/wc_charge
    echo "1650" > /sys/devices/platform/battery/ac_input
    echo "2300" > /sys/devices/platform/battery/ac_charge
    echo "1700" > /sys/devices/platform/battery/ps_input
    echo "2300" > /sys/devices/platform/battery/ps_charge
    echo "1650" > /sys/devices/platform/battery/usb_input
    echo "2300" > /sys/devices/platform/battery/usb_charge

    # Better DeepSleep 
    # echo "mem" > /sys/power/autosleep
    echo "deep" > /sys/power/mem_sleep

    # GPU set at max/min freq
    # echo "702000" > /sys/kernel/gpu/gpu_max_clock
    # echo "100000" > /sys/kernel/gpu/gpu_min_clock
    # echo "coarse_demand" > /sys/devices/platform/18500000.mali/power_policy
    # echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "433000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "90" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "0" > /sys/devices/platform/18500000.mali/highspeed_delay

   # Misc settings : bbr2, bbr, cubic or westwood
   echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
   echo "N" > /sys/module/mmc_core/parameters/use_spi_crc
   echo "1" > /sys/module/sync/parameters/fsync_enabled
   echo "0" > /sys/kernel/sched/gentle_fair_sleepers
   echo "3" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_mode
   # echo "1" > /sys/kernel/power_suspend/power_suspend_state

   # I/O sched settings
   echo "cfq" > /sys/block/sda/queue/scheduler
   # echo "256" > /sys/block/sda/queue/read_ahead_kb
   echo "noop" > /sys/block/mmcblk0/queue/scheduler
   # echo "256" > /sys/block/mmcblk0/queue/read_ahead_kb
   echo "0" > /sys/block/sda/queue/iostats
   echo "0" > /sys/block/mmcblk0/queue/iostats
   echo "1" > /sys/block/sda/queue/rq_affinity
   echo "1" > /sys/block/mmcblk0/queue/rq_affinity
   echo "128" > /sys/block/sda/queue/nr_requests
   echo "64" > /sys/block/mmcblk0/queue/nr_requests
   echo "24" > /sys/block/mmcblk0/queue/iosched/fifo_batch
   echo "600" > /sys/block/sda/queue/iosched/target_latency

    if [ -e /proc/sys/kernel/sched_schedstats ]; then
      echo 0 > /proc/sys/kernel/sched_schedstats
    fi
      echo off > /proc/sys/kernel/printk_devkmsg
    for queue in /sys/block/*/queue
    do
      echo 0 > "$queue/iostats"
    done

   #Devfreq
   # default 2093 MHz
   # echo "1794000" > /sys/devices/platform/17000010.devfreq_mif/devfreq/17000010.devfreq_mif/max_freq

    # Initial ThundeRStormS Stune and CPU set settings
	echo "## -- Initial Stune settings by ThundeRStormS" >> $LOG;

   ## Kernel Stune											DEFAULT VALUES
   # GLOBAL
   echo "3" > /dev/stune/schedtune.boost					# 0
   echo "0" > /dev/stune/schedtune.band					    # 0
   echo "0" > /dev/stune/schedtune.prefer_idle				# 0
   echo "0" > /dev/stune/schedtune.prefer_perf				# 0
   echo "0" > /dev/stune/schedtune.util_est_en				# 0
   echo "0" > /dev/stune/schedtune.ontime_en				# 0
   
   # TOP-APP
   echo "3" > /dev/stune/top-app/schedtune.boost			# 20
   echo "0" > /dev/stune/top-app/schedtune.band			    # 0
   echo "0" > /dev/stune/top-app/schedtune.prefer_idle		# 1
   echo "0" > /dev/stune/top-app/schedtune.prefer_perf		# 0
   echo "1" > /dev/stune/top-app/schedtune.util_est_en		# 1
   echo "1" > /dev/stune/top-app/schedtune.ontime_en		# 1
   
   # RT
   echo "0" > /dev/stune/rt/schedtune.boost					# 0
   echo "0" > /dev/stune/rt/schedtune.band					# 0
   echo "0" > /dev/stune/rt/schedtune.prefer_idle			# 0
   echo "0" > /dev/stune/rt/schedtune.prefer_perf			# 0
   echo "0" > /dev/stune/rt/schedtune.util_est_en			# 0
   echo "0" > /dev/stune/rt/schedtune.ontime_en				# 0
 
   # FOREGROUND-APP
   echo "0" > /dev/stune/foreground/schedtune.boost			# 0
   echo "0" > /dev/stune/foreground/schedtune.band			# 0
   echo "0" > /dev/stune/foreground/schedtune.prefer_idle	# 0
   echo "0" > /dev/stune/foreground/schedtune.prefer_perf	# 0
   echo "1" > /dev/stune/foreground/schedtune.util_est_en	# 1
   echo "1" > /dev/stune/foreground/schedtune.ontime_en		# 1
 
   # BACKGROUND-APP
   echo "0" > /dev/stune/background/schedtune.boost		    # 0
   echo "0" > /dev/stune/background/schedtune.band			# 0
   echo "1" > /dev/stune/background/schedtune.prefer_idle	# 0
   echo "0" > /dev/stune/background/schedtune.prefer_perf	# 0
   echo "1" > /dev/stune/background/schedtune.util_est_en	# 0
   echo "1" > /dev/stune/background/schedtune.ontime_en	    # 0

   # CPU SET
   # RESTRICKTED 
   echo "0-7" >   /dev/cpuset/restricted/cpus				# 0-7
   # ABNORMAL 
   echo "0-3" >   /dev/cpuset/abnormal/cpus					# 0-3
   # GLOBAL
   echo "0-7" > /dev/cpuset/cpus							# 0-7
   # TOP-APP
   echo "0-7" > /dev/cpuset/top-app/cpus					# 0-7
   # FOREGROUND
   echo "0-3,4-6" > /dev/cpuset/foreground/cpus				# 0-3,4-6
   # BACKGROUND
   echo "0-2" > /dev/cpuset/background/cpus				    # 0-2
   # SYSTEM-BACKGROUND
   echo "0-2" > /dev/cpuset/system-background/cpus		    # 0-2
   # MODERATE
   echo "0-3,4-5" > /dev/cpuset/moderate/cpus				# 0-3,4-6
   # DEXOPT
   echo "0-5" > /dev/cpuset/dexopt/cpus					    # 0-3

   ## CPU Fluid RT
   echo "5" > sys/kernel/ems/frt/coregroup0/active_ratio
   echo "10" > sys/kernel/ems/frt/coregroup0/active_ratio_boost
   echo "15" > sys/kernel/ems/frt/coregroup0/coverage_ratio
   echo "20" > sys/kernel/ems/frt/coregroup0/coverage_ratio_boost

   echo "20" > sys/kernel/ems/frt/coregroup1/active_ratio
   echo "30" > sys/kernel/ems/frt/coregroup1/active_ratio_boost
   echo "5" > sys/kernel/ems/frt/coregroup1/coverage_ratio
   echo "10" > sys/kernel/ems/frt/coregroup1/coverage_ratio_boost

   echo "20" > sys/kernel/ems/frt/coregroup2/active_ratio
   echo "30" > sys/kernel/ems/frt/coregroup2/active_ratio_boost
   echo "10" > sys/kernel/ems/frt/coregroup2/coverage_ratio
   echo "15" > sys/kernel/ems/frt/coregroup2/coverage_ratio_boost

   ## Kernel Scheduler
   echo "5000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
   echo "400000" > /proc/sys/kernel/sched_latency_ns
   echo "1500000" > /proc/sys/kernel/sched_min_granularity_ns
   echo "500000" > /proc/sys/kernel/sched_migration_cost_ns
   echo "1000000" > /proc/sys/kernel/sched_rt_period_us
   echo "3" > /proc/sys/kernel/perf_cpu_time_max_percent  #25
   echo "10" > /proc/sys/kernel/sched_rr_timeslice_ms  #30
   echo "64" > /proc/sys/kernel/sched_nr_migrate
   echo "0" > /sys/module/cpuidle/parameters/off  # 0
   echo "default" > /sys/module/pcie_aspm/parameters/policy
   # policy - default performance powersave powersupersave
   echo "ff" > /proc/irq/default_smp_affinity  #01
   echo "f0" > /sys/bus/workqueue/devices/writeback/cpumask   # f0
   echo "ff" > /sys/devices/virtual/workqueue/cpumask   # ff
   echo "0" > /dev/cpuset/sched_load_balance    # 0
   echo "0" > /proc/sys/kernel/timer_migration  # 1
   echo "0" > /proc/sys/kernel/sched_schedstats # 1

    # Fs
    echo "0" > /proc/sys/fs/dir-notify-enable
    echo "20" > /proc/sys/fs/lease-break-time
    echo "131072" > /proc/sys/fs/aio-max-nr

   # CPU EFF_mode
   echo "0" > /sys/kernel/ems/eff_mode						# 0

   # CPU Energy Aware
   echo "1" > /proc/sys/kernel/sched_energy_aware			# 0
   echo "0" > /proc/sys/kernel/sched_tunable_scaling		# 0

   # Boeffla wakelocks
   chmod 0644 /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
   echo 'wlan_pm_wake;wlan_rx_wake;wlan_wake;wlan_ctrl_wake;wlan_txfl_wake;BT_bt_wake;BT_host_wake;nfc_wake_lock;rmnet0;nfc_wake_lock;bluetooth_timer;event0;GPSD;umts_ipc0;NETLINK;ssp_comm_wake_lock;epoll_system_server_file:[timerfd4_system_server];epoll_system_server_file:[timerfd7_system_server];epoll_InputReader_file:event1;epoll_system_server_file:[timerfd5_system_server];epoll_InputReader_file:event10;epoll_InputReader_file:event0;epoll_InputReader_epollfd;epoll_system_server_epollfd' > /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
	echo " " >> $LOG;

	# echo "## -- Sched features Fix" >> $LOG;

	## Noatime settings
    echo "## -- Noatime mount settings" >> $LOG;
    busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /;
    busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /proc;
    busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /sys;
    busybox mount -o remount,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /system;
	echo " " >> $LOG;

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

