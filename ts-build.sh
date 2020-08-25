#!/bin/bash
#
# Kernel Build Script v1.0 by ThunderStorms Team
#

LOG=compile_build.log
RDIR=$(pwd)
export K_VERSION="v1.0"
export K_NAME="ThundeRStormS-Kernel"
export K_BASE="CTG4"

# MAIN PROGRAM
# ------------

MAIN()
{
(
	START_TIME=`date +%T`
    if [ $MODEL = "G970F" ]; then
    ./build mkimg model=G970F name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "G970N" ]; then
    ./build mkimg model=G970N name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "G973F" ]; then
    ./build mkimg model=G973F name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "G975F" ]; then
    ./build mkimg model=G975F name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "G977B" ]; then
    ./build mkimg model=G977B name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "N970F" ]; then
    ./build mkimg model=N970F name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "N971N" ]; then
    ./build mkimg model=N971N name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "N975F" ]; then
    ./build mkimg model=N975F name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "N976N" ]; then
    ./build mkimg model=N976N name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    elif [ $MODEL = "N976B" ]; then
    ./build mkimg model=N976B name="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    fi

	END_TIME=`date +%T`
	echo "Start compile time is $START_TIME"
	echo "Start compile time is $END_TIME"
	echo ""
	echo "Your flasheable release can be found in the builds folder with name :"
	echo "$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION-`date +%Y-%m-%d`.img"
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
	# echo "Compressing kernels..."
	echo "Copying kernels to ts folder..."
	# tar cv *.img | xz -9 > kernel.tar.xz
	# mv kernel.tar.xz ts/
	mv *.img ts/

    rm -rf *.img	
	zip -9 -r ../$ZIP_NAME *

	cd ..
    rm -rf temp2
}

RUN_PROGRAM()
{
    MAIN
    cp -f boot.img builds/$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION.img
    BUILD_FLASHABLES
}

RUN_PROGRAM2()
{
    MAIN
    cp -f boot.img builds/$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION.img
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
echo "(1) SM-G970F"
echo "(2) SM-G970N"
echo "(3) SM-G973F"
echo "(4) SM-G975F"
echo "(5) SM-G977B"
echo "(6) SM-N970F"
echo "(7) SM-N971N"
echo "(8) SM-N975F"
echo "(9) SM-N976N"
echo "(10) SM-N976B"
echo "(11) All variants"
echo ""
echo ""
read -p "Select an option to compile the kernel: " prompt


if [ $prompt = "1" ]; then
    MODEL=G970F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-G970F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "2" ]; then
    MODEL=G970N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-G973N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "3" ]; then
    MODEL=G973F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-G973F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "4" ]; then
    MODEL=G975F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-G975F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "5" ]; then
    MODEL=G977B
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-G977B Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "6" ]; then
    MODEL=N970F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-N970F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "7" ]; then
    MODEL=N971N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-N971N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "8" ]; then
    MODEL=N975F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-N975F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "9" ]; then
    MODEL=N976N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-N976N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "10" ]; then
    MODEL=N976B
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "SM-N976B Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "11" ]; then
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-S10-N10-OneUIQ-$K_VERSION-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-OneUI-Q-$MODEL-$K_VERSION"
    echo "All variants Selected"
    MODEL=G970F
    echo "Compiling SM-G970F ..."
    RUN_PROGRAM2
    MODEL=G970N
    echo "Compiling SM-G970N ..."
    RUN_PROGRAM2
    MODEL=G973F
    echo "Compiling SM-G973F ..."
    RUN_PROGRAM2
    MODEL=G975F
    echo "Compiling SM-G975F ..."
    RUN_PROGRAM2
    MODEL=G977B
    echo "Compiling SM-G977B ..."
    RUN_PROGRAM2
    MODEL=N970F
    echo "Compiling SM-N970F ..."
    RUN_PROGRAM2
    MODEL=N971N
    echo "Compiling SM-N971N ..."
    RUN_PROGRAM2
    MODEL=N975F
    echo "Compiling SM-N975F ..."
    RUN_PROGRAM2
    MODEL=N976N
    echo "Compiling SM-N976N ..."
    RUN_PROGRAM2
    MODEL=N976B
    echo "Compiling SM-N976B ..."
    RUN_PROGRAM
    BUILD_FLASHABLES
fi
    


