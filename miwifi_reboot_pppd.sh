#!/bin/ash
#---------------------------------------------------------------- 
# Shell Name：miwifi_reboot_pppd.sh
# Description：
#	- miwifi pppoe 拨号时不时无故断网，通过重启pppd 实现自动重拨;
#	- 使用crontab 代替 sleep, 每12分钟检查一次;
#	- 日志输出至同一文件夹下;
#*/12 * * * * sh /tmp/bobby4kit/miwifi_reboot_pppd.sh >/tmp/bobby4kit/cron.log 2>&1
# Author：bobby
# E-mail: bobby4kit@outlook.com
# Time：2022-10-04 22:37 CST
# Copyright © 2022 bobby4kit. All rights reserved.
#----------------------------------------------------------------*/

#get gateway ip
IP=`route | grep 'default' | awk 'NR==1 {print $2}'`
PPOEUSER='12340987'

kill_deamon() {
	killall pppd
}

start_deamon(){
	/usr/sbin/pppd nodetach ipparam wan ifname pppoe-wan nodefaultroute usepeerdns persist maxfail 1 user $PPOEUSER
}

check_ping() {

	local total="0"
	local i="0"
	local whilec=10
 
	while [ $i -lt $whilec ]; do

		local line=""
		#echo "ping $IP"
		line=`ping $IP -c 1 -s 1 -W 1 | grep "100% packet loss" | wc -l`
			
		if [ "${line}" != "0" ]; then
			echo "[$i]ping failed!"
			total=$((total+1))
		else
			echo "[$i]ping ok!"
			total="0"
		fi
		
		i=$((i+1))
		sleep 1
	done
	
	#如果连续5次失败 则判断为网络中断
	if [ $total -eq $whilec ]; then
		echo "check failed!"
		return 1
	else 
		total=$((whilec-total))
		echo "check[$total] ok!"
		return 0
	fi
}

start(){
	local rtl=""
	local ttime=`date +"%Y-%m-%d %H:%M:%S"`
	
	#while [ 1 ]; do
	check_ping
	rtl=$?
	
	if [ "$rtl" != "0" ]; then
		echo "$ttime restart deamon start "
		kill_deamon
		#sysinit may do start
		#start_deamon
	else
		echo "$ttime ping gateway[$IP] be connect "
		#sleep 600;
	fi
	#done
}
 
start

#END FILE