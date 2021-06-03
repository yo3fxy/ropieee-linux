#!/bin/bash

_update_realtek_driver() {
   local chipset=$1
   local url=$2

   if [ ! -d $chipset ]
   then
      echo
      echo "Error: unknown chipset!"
   fi

   tmpdir=$( mktemp -d /tmp/realtekXXXXX )
   echo "cloning $url in $tmpdir..."
   git clone $url $tmpdir
   cp -rp $tmpdir/* $chipset

}

# rtl8192eu
_update_realtek_driver rtl8192eu 'https://github.com/Mange/rtl8192eu-linux-driver'
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y'/ rtl8192eu/Makefile
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n'/ rtl8192eu/Makefile

# rtl8723bu
_update_realtek_driver rtl8723bu 'https://github.com/lwfinger/rtl8723bu'
sed -i 's/EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE/#EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE'/ rtl8723bu/Makefile
cat << _EOF_ > rtl8723bu/Kconfig
config RTL8723BU
	tristate "Realtek 8723B USB WiFi"
	depends on USB
	help
	  Help message of RTL8723BU

_EOF_

# rtl8812au
_update_realtek_driver rtl8812au 'https://github.com/aircrack-ng/rtl8812au'
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y'/ rtl8812au/Makefile
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n'/ rtl8812au/Makefile

# rtl88x2bu
_update_realtek_driver rtl88x2bu 'https://github.com/cilynx/rtl88x2bu'
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y'/ rtl88x2bu/Makefile
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n'/ rtl88x2bu/Makefile
cat << _EOF_ > rtl88x2bu/Kconfig
config RTL8822BU
	tristate "Realtek 8822B USB WiFi"
	depends on USB
	help
	  RTL88X2BU driver updated for current kernels.

_EOF_

