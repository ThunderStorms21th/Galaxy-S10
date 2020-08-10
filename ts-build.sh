#!/bin/bash
#
# Kernel Build Script v1.0 by ThunderStorms Team
#

LOG=compile_build.log

# MAIN PROGRAM
# ------------

MAIN()
{

(
	START_TIME=`date +%T`
    ./build mkimg model=G973F name="ThunderStorms-S10-v1.0"
	END_TIME=`date +%T`
	echo "Start compile time is $START_TIME"
	echo "Start compile time is $END_TIME"
	echo ""
	echo "Your flasheable release can be found in the builds folder with name :"
	echo "ThunderStorms-S10-v1.0-`date +%Y-%m-%d`.img"
	echo ""
) 2>&1 | tee -a ./$LOG
}

# RUN PROGRAM
# -----------

MAIN

cp -f boot.img builds/ThunderStorms-S10-v1.0-`date +%Y-%m-%d`.img

