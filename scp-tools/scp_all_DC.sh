#! /bin/bash
# Just Use for double-controller RAID
# usage:
# ./scp_all.sh				--will sync all the file in current directory
# ./scp_all.sh file_name	--will just sync one file
# ./scp_all.sh 1 2 3		--will sync three files

function help(){
	echo -e "......................................................."
	echo -e "USAGE:"
	echo -e " ./scp_all.sh -h [--help|-help] for usage"
	echo -e " ./scp_all.sh           --will sync \e[31mall the files\e[0m in current directory"
	echo -e " ./scp_all.sh file_name --will just sync one file"
	echo -e " ./scp_all.sh 1 2 3     --will sync three files"
	echo -e "NOTE:"
	echo -e " We can use 'alias syn=/root/scp_all.sh' "
	echo -e " then we will just input 'syn' to use it "
	echo -e "......................................................."
}

#IP='115.156.158.44'
#IPM='115.156.158.39'

path=$(pwd)
ip=$(ifconfig -a | grep $IP)
if [[ -z $ip ]]; then
	ip=$IP
else
	ip=$IPM
fi

echo -e "----------------------------"
echo -e " mirror path: \e[31m$path\e[0m"
echo -e " mirror ip  : \e[31m$ip\e[0m"
echo -e "----------------------------"

if [[ $# -ge 1 ]]; then 
	echo "to $ip:$path"
	for f in $@; do
		if [[ -e $f ]]; then
			echo -e "Now we sync the file \e[1m$path/$f\e[0m"
			scp  $path/$f root@$ip:$path
		elif [[ $f == '-h' || $f == '--help' || $f == '-help' ]]; then
			help
		else
			echo -e "\e[31m$path/$f not exist!\e[0m"
		fi
	done
	exit 0
fi

echo -e "Do you want to sync \e[31m$path\e[0m directory?"
echo -e "input 'y' to sync, or just press ENTER to quit"
read bool

if [[ $bool == 'y' ]]; then
	echo "now we sync the file $path"
	echo "to $ip:$path"
	scp  $path/* root@$ip:$path
else
	echo "just do nothing, bye !"
fi

