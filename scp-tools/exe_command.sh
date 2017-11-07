#! /bin/bash

# just execute some commands

#IP='115.156.158.39'
#IPM='115.156.158.44'
IP='192.168.167.84'

function help(){
	echo -e "----------------------------------"
	echo -e "PARA:"
	echo -e "  \e[31m-s\e[0m start the raid"
	echo -e "  \e[31m-r\e[0m reboot the system"
	echo -e "  \e[31m-p\e[0m shut down the system"
	echo -e "  \e[31m-m\e[0m make src/cache"
	echo -e "  \e[31m-ma\e[0m make all just ./wan"
	echo -e "----------------------------------"
}

#ip=$(ifconfig -a | grep $IP)
#if [[ -z $ip ]]; then
	#ipm=$IP
	#ip=$IPM
#else
	#ipm=$IPM
	#ip=$IP
#fi
ipm=$IP
echo "mirror: $ipm"
#echo "local:  $ip"

# commands 
cmd_s='/root/_start_raid.sh'
cmd_r='reboot'
cmd_m="cd /data/raid/src/cache ; make 1>/dev/null "
cmd_ma="cd /data/raid ; ./wan 1>/dev/null"
cmd_poweroff='poweroff'

if [[ $# -lt 1 ]]; then 
	help
else
	case $1 in
		'-s') 
			#ssh -t -t -p 22 root@$ipm $cmd_s &
			ssh -t -t -p 22 root@$ipm $cmd_s
			#$cmd_s
			;;
		'-r') 
			ssh -t -t -p 22 root@$ipm $cmd_r
			#$cmd_r
			;;
		'-p')
			ssh -t -t p 22 root @ipm $cmd_poweroff
			#$cmd_poweroff
			;;
		'-m')
			echo '>>>please wait for ...'
			ssh -t -t -p 22 root@$ipm $cmd_m
			#cd /data/raid/src/cache
			#make 1>/dev/null
			echo '===============cache compile end========='
			#$cmd_m
			;;
		'-ma')
			echo '>>>please wait for ...'
			ssh -t -t -p 22 root@$ipm $cmd_ma
			#cd /data/raid
			#./wan 1>/dev/null
			echo '==============raid compile end=========='
			;;
		*) 
			help
			;;
	esac
fi
