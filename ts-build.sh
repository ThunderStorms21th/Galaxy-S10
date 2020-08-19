#!/bin/bash
#
# Kernel Build Script v1.0 by ThunderStorms Team
#

LOG=compile_build.log
RDIR=$(pwd)
export K_VERSION="v1.0"
export K_NAME="ThundeRStormS-Kernel"

# MAIN PROGRAM
# ------------

MAIN()
{

(
	START_TIME=`date +%T`
    ./build mkimg model=G973F name="$K_NAME-$MODEL-$K_VERSION"
	END_TIME=`date +%T`
	echo "Start compile time is $START_TIME"
	echo "Start compile time is $END_TIME"
	echo ""
	echo "Your flasheable release can be found in the builds folder with name :"
	echo "ThunderStorms-$MODEL-v1.0-`date +%Y-%m-%d`.img"
	echo ""
) 2>&1 | tee -a ./$LOG
}

BUILD_FLASHABLES()
{
	cd $RDIR/builds
	mkdir temp2
	cp -rf zip-OneUIQ/common/. temp2
    cp -rf *.img temp2/
	cd temp2
	echo ""
	echo "Compressing kernels..."
	tar cv *.img | xz -9 > kernel.tar.xz
	mv kernel.tar.xz ts/

    rm -rf *.img	
	zip -9 -r ../$ZIP_NAME *

	cd ..
    rm -rf temp2
}

RUN_PROGRAM()
{
    MAIN
    cp -f boot.img builds/$K_NAME-$MODEL-$K_VERSION.img
    BUILD_FLASHABLES
    ## rm -f boot.img builds/ThunderStorms-G973-v1.0-`date +%Y-%m-%d`.img
}

RUN_PROGRAM2()
{
    MAIN
    cp -f boot.img builds/$K_NAME-$MODEL-$K_VERSION.img
    ## rm -f boot.img builds/ThunderStorms-G973-v1.0-`date +%Y-%m-%d`.img
}

# RUN PROGRAM
# -----------

# PROGRAM START
# -------------
clear
echo "*****************************************"
echo "*   ThunderStorms Kernel Build Script   *"
echo "*****************************************"
echo ""
echo "    CUSTOMIZABLE STOCK SAMSUNG KERNEL"
echo ""
echo "           Build Kernel for:"
echo ""
echo "S10/N10 OneUI Q"
echo "(1) SM-G975"
echo "(2) SM-G973"
echo "(3) SM-G970"
echo "(4) SM-N970"
echo "(5) SM-N975"
echo "(6) SM-N976"
echo "(7) SM-N971"
echo "(8) All variants"
echo ""
echo ""
read -p "Select an option to compile the kernel: " prompt


if [ $prompt = "1" ]; then
    MODEL=G975
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-G975 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "2" ]; then
    MODEL=G973
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-G973 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "3" ]; then
    MODEL=G970
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-G970 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "4" ]; then
    MODEL=N970
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-N970 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "5" ]; then
    MODEL=N975
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-N975 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "6" ]; then
    MODEL=N976
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-N976 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "7" ]; then
    MODEL=N971
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "SM-N971 Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "8" ]; then
    echo "All variants Selected"
    MODEL=G975
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-S10-N10-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    echo "Compiling SM-G975 ..."
    RUN_PROGRAM2
    MODEL=G973
    echo "Compiling SM-G973 ..."
    RUN_PROGRAM2
    MODEL=G970
    echo "Compiling SM-G970 ..."
    RUN_PROGRAM2
    MODEL=N970
    echo "Compiling SM-N970 ..."
    RUN_PROGRAM2
    MODEL=N975
    echo "Compiling SM-N975 ..."
    RUN_PROGRAM2
    MODEL=N976
    echo "Compiling SM-N976 ..."
    RUN_PROGRAM2
    MODEL=N971
    echo "Compiling SM-N971 ..."
    RUN_PROGRAM
    BUILD_FLASHABLES
fi
    


