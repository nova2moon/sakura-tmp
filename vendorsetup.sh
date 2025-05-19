#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

FDEVICE="sakura"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C.UTF-8"
 	export ALLOW_MISSING_DEPENDENCIES=true

 	#OFR build settings & info
 	#export FOX_VANILLA_BUILD=1
	## export FOX_RESET_SETTINGS="disabled"  # (We want to reset on zip install)
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
        export TARGET_DEVICE_ALT="sakura_india"
        export FOX_TARGET_DEVICES="sakura,sakura_india"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

	# OFR Misc
	export OF_USE_GREEN_LED=0
	export OF_FLASHLIGHT_ENABLE=1
	export OF_ALLOW_DISABLE_NAVBAR=0
	export OF_QUICK_BACKUP_LIST="/data;/boot;"
	export OF_ENABLE_USB_STORAGE=1
	export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
	export OF_BIND_MOUNT_SDCARD_ON_FORMAT=1
	export OF_FORCE_CASEFOLDING=1
	export OF_SPLASH_MAX_SIZE=512
	export OF_SCREEN_H=2280
	export OF_STATUS_H=50
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1
	export OF_OPTIONS_LIST_NUM=6
	export OF_ENABLE_LPTOOLS=1
	export OF_RECOVERY_AB_FULL_REFLASH_RAMDISK=1
	export OF_DISABLE_OTA_MENU=1
	export OF_PATCH_AVB20=1
	export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1

	#OFR binary files
	export FOX_USE_BASH_SHELL=1
   	export FOX_ASH_IS_BASH=1
   	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
    	export FOX_USE_XZ_UTILS=1
   	export FOX_REPLACE_BUSYBOX_PS=1
   	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
   	export OF_USE_MAGISKBOOT="1"
   	export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
   	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1510672800"; # Tue Nov 14 15:20:00 GMT 2017
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
	export OF_USE_SYSTEM_FINGERPRINT="1"
	export FOX_REPLACE_TOOLBOX_GETPROP=1

	# MIUI
	export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

	# dm-verity/forced-encryption
	export OF_KEEP_DM_VERITY=1
   	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export OF_DEFAULT_KEYMASTER_VERSION=3.0

	# run a process after formatting data to work-around MTP issues
	export OF_RUN_POST_FORMAT_PROCESS=1


	#OTA
	export FOX_VIRTUAL_AB_DEVICE=0
	export FOX_DELETE_AROMAFM=0
	export FOX_ENABLE_APP_MANAGER=1

	# Versioning
 	export FOX_VARIANT="rev12"
  	export FOX_BUILD_TYPE="experimental"
	export OF_MAINTAINER="Nova Moon"

	## lunch twrp_$FDEVICE-eng
	
	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
