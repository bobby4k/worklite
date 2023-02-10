#!/bin/ash
#---------------------------------------------------------------- 
# Shell Name：miwifi_reload_smb.sh
# Description：
#	- miwifi smb win10+ 匿名用户登录不了，修改配置reload 
#	- crontab @reboot 不支持...
#		@reboot sh /etc/init.d/miwifi_reload_smb.sh
#
# mv /tmp/miwifi_reload_smb.sh /etc/init.d/ ; chmod +x /etc/init.d/miwifi_reload_smb.sh
# sh chmod +x /etc/init.d/miwifi_reload_smb.sh
# */5 * * * * sh /etc/init.d/miwifi_reload_smb.sh
# Author：bobby
# E-mail: bobby4kit@outlook.com
# Time：2023-02-11 03:02 CST
# Copyright © 2022 bobby4kit. All rights reserved.
#----------------------------------------------------------------*/
#sleep 3s
browseable=`grep 'browseable' /etc/config/samba | grep "'no'" | wc -l`

if [ "$browseable" != "0" ]; then
	sed -i "s/option 'browseable'     'no'/option 'browseable'     'yes'/" /etc/config/samba
	echo "samba reloading..."
	/etc/init.d/samba reload
fi


#END FILE
