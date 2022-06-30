#!/bin/env bash
#===============================================================
#
# FUNCTIONS
#
# Arguably, some functions defined here are quite big.
# If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
#
#===============================================================
function func ()
{
	echo -e "\n${cyan}Available functions:${NC}"
	echo -e "${cyan}--------------------${NC}"
	echo -e "\n${magenta}extract 	${yellow}--> ${green}to extract files with different programs"
	echo -e "${magenta}pcinfo 		${yellow}--> ${green}display system information using inxi"
	echo -e "${magenta}lg 		${yellow}--> ${green}display various logs with last entry first"
	echo -e "${magenta}lj 		${yellow}--> ${green}display messages with journalctl"
	echo -e "${magenta}netinfo 	${yellow}--> ${green}network information"
	echo -e "${magenta}myinfo 		${yellow}--> ${green}display various system information"
	echo -e "${magenta}colors 		${yellow}--> ${green}display various color schemes"
	echo -e "${magenta}save 		${yellow}--> ${green}execute different backup's"
	echo -e "${magenta}desk 		${yellow}--> ${green}display desktop name and version"
	echo -e "${magenta}doc 		${yellow}--> ${green}start DocFetcher from /mnt/NAS/software"
	echo -e "${magenta}ebook 		${yellow}--> ${green}Start Calibre for specific Libraries"
	echo -e "${magenta}extip 		${yellow}--> ${green}Display external ip address"
	echo -e "${magenta}bt 		${yellow}--> ${green}Boot Time with systemd-analyze"
	echo -e "${magenta}fn 	 	${yellow}--> ${green}find all files with a pattern in current directory"
	echo -e "${magenta}fr 	 	${yellow}--> ${green}find all files with a pattern in complete system excluding /proc"
	echo -e "${magenta}fs	 	${yellow}--> ${green}find all files with specified size in current directory"
	echo -e "${magenta}docker-cleanup   ${yellow}--> ${green}Cleanup docker, use --dry-run to check"
	echo "${NC}"
}

function extract ()	# extract function - use different programs
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1        ;;
             *.bz2)       bunzip2 $1        ;;
             *.rar)       rar x $1          ;;
             *.gz)        gunzip $1         ;;
             *.tar)       tar xf $1         ;;
             *.tbz2)      tar xjf $1        ;;
             *.tgz)       tar xzf $1        ;;
             *.zip)       unzip $1          ;;
             *.Z)         uncompress $1     ;;
             *.7z)        7z x $1           ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
function dis-colors ()
{
	echo -e "\n${cyan}Display various color schemes:${NC}"
	echo -e "${cyan}------------------------------${NC}"
	echo -e "\n${green}1 ${magenta}256colors 	${yellow}--> ${green}scheme for 256 colors terminal"
	echo -e "${green}2 ${magenta}8colors  	${yellow}--> ${green}scheme for 8 colors terminal"
	echo -e "${green}3 ${magenta}dircolors  	${yellow}--> ${green}colors for ls command (.dircolors file)"
	echo -e "${green}4 ${magenta}ansi colors	${yellow}--> ${green}display ansi color values"
	echo -e "${green}5 ${magenta}tput colors	${yellow}--> ${green}scheme for tput colors"
    	echo -e "${green}6 ${magenta}Hex colors 	${yellow}--> ${green}Hex colors on hexcol.com"
	echo "${NC}"
	read -p "==>_" answer
	echo " "
  	case $answer in
		1) 256color.sh
		;;
		2) 8color.sh
		;;
		3) dislscols.sh
		;;
		4) ansi-colors.sh
		;;
		5) tputcolors.sh
		;;
                6) firefox https://hexcol.com/color/b200b2
                ;;
	esac
}

function pcinfo ()	# script to display lots of system information "inxi package"
{
   inxi-system-info.sh
}

function lg ()
{
    dislogs.sh		# script to display various log files
}

function lj ()
{
    disjournal.sh		# script to display journalctl messages
}

function netinfo ()	#netinfo - shows network information for your system
{
    echo "--------------- Network Information ---------------"
    inxi -i
    echo "--------------- Network Connections ---------------"
	nmcli con
	echo "---------------------------------------------------"
}

function extip ()  # Get External IP address
{
	curl -s ifconfig.co
}

function myinfo ()
{
	printf "CPU:    "
	cat /proc/cpuinfo | grep "model name" | head -1 | awk '{ for (i = 4; i <= NF; i++) printf "%s ", $i }'
	printf "\n"
	head /sys/devices/system/cpu/vulnerabilities/*
	printf "\n"
	cputemp
	printf "\n"
	hostnamectl | ccze -A
	printf "\n"
	uptime | awk '{ printf "Uptime: %s %s %s", $3, $4, $5 }' | sed 's/,//g'
}

function fn ()				# function to search for files in current directory
{
	tmp=$*
	if [ -z "$tmp" ]; then
		read -p "File pattern (i.e. *.pdf or *steuer*): " tmp
	fi
	find . -iname "*$tmp*"
}

function fr ()				# function to search for files in complete system excluding /proc and /mnt
{
	tmp=$*
	if [ -z "$tmp" ]; then
		read -p "File pattern (i.e. *.pdf or *steuer*): " tmp
	fi
	sudo find / \( -path /proc -o -path /mnt \) -prune -o -iname "$tmp"
}

function fs ()				# function to search for files in current directory
{
	tmp=$*
	if [ -z "$tmp" ]; then
		read -p "File size in MB or GB (i.e. 4000M or 4G): " tmp
	fi
	find . -type f -size "+$tmp"
}

function save ()
{
	echo -e "\n${cyan}Execute backup jobs to NAS or HDD:${NC}"
	echo -e "${cyan}----------------------------------${NC}"
	echo -e "\n${green}1 ${magenta}Home dir dry-run 		${yellow}--> ${green}Dry run of home directory"
	echo -e "${green}2 ${magenta}Home dir  			${yellow}--> ${green}Backup of home directory to NAS"
	echo -e "${green}3 ${magenta}Full backup 			${yellow}--> ${green}Full backup to HDD"
	echo -e "${green}4 ${magenta}Synchronize Digikam dry-run 	${yellow}--> ${green}Dry run all *.jpg pictures to /mnt/Digikam"
	echo -e "${green}5 ${magenta}Synchronize Digikam 		${yellow}--> ${green}Copy all *.jpg pictures to /mnt/Digikam"
	echo "${NC}"
	read -p "==>_" answer
	echo " "
  	case $answer in
		1) backup-home-dry.sh
		;;
		2) backup-home.sh
		;;
		3) backup-full.sh
		;;
		4) sync-digikam-dry.sh
		;;
		5) sync-digikam.sh
		;;
	esac
}

function desk ()
{
	case "$DESKTOP_SESSION" in
		budgie-desktop)
			TOP="$XDG_CURRENT_DESKTOP"
			VER=$(budgie-desktop --version | egrep budgie | awk '{ print $2 }')
			;;
		Ubuntu|ubuntu|gnome)
			TOP="$XDG_CURRENT_DESKTOP"
			VER=$(gnome-shell --version | awk '{ print $3 }')
			;;
		Xubuntu|xubuntu)
			TOP="$XDG_CURRENT_DESKTOP"
			VER=$(xfdesktop --version | egrep xfdesktop | awk '{ print $9 }')
			;;
		Lubuntu|lubuntu)
#			We can detect LXDE version only thru package manager
			TOP="$XDG_CURRENT_DESKTOP"
			VER=$(apt-cache show lxde-common | egrep 'Version:' | awk '{print $2}' | awk -F '-' '{print $1}')
			;;
		*)
			;;
	esac
echo ${yellow}"Desktop: "${magenta}$TOP${yellow} "Version: "${magenta}$VER${NC}
}

function doc ()
{
	echo "It will take a while to bring up DocFetcher...."
	cd ~/DocFetcher-1.1.22
	./DocFetcher-GTK3.sh
	cd
}

function ebook ()
{
	echo -e "\n${cyan}Start Calibre with specified Library:${NC}"
	echo -e "${cyan}------------------${NC}"
	echo -e "\n${green}1 ${magenta}Linux 			${yellow}--> ${green}Start with /mnt/Data/CalibreLibrary/Linux"
	echo -e "${green}2 ${magenta}LinuxWelt 			${yellow}--> ${green}Start with /mnt/Data/CalibreLibrary/LinuxWelt"
	echo -e "${green}3 ${magenta}LibreOffice    	    	${yellow}--> ${green}Start with /mnt/Data/CalibreLibrary/LibreOffice"
	echo -e "${green}4 ${magenta}Hardware 			${yellow}--> ${green}Start with /mnt/Data/CalibreLibrary/Hardware"
	echo -e "${green}5 ${magenta}Software 			${yellow}--> ${green}Start with /mnt/Data/CalibreLibrary/Software"
	echo "${NC}"
	read -p "==>_" answer
	echo " "
  	case $answer in
		1) calibre --with-library=/mnt/Data/CalibreLibrary/Linux
		;;
		2) calibre --with-library=/mnt/Data/CalibreLibrary/LinuxWelt
		;;
		3) calibre --with-library=/mnt/Data/CalibreLibrary/LibreOffice
		;;
		4) calibre --with-library=/mnt/Data/CalibreLibrary/Hardware
		;;
		5) calibre --with-library=/mnt/Data/CalibreLibrary/Software
		;;
	esac
}
function bt ()
{
	echo -e "\n${cyan}Analyze Boot Time:${NC}"
	echo -e "${cyan}------------------${NC}"
	echo -e "\n${green}1 ${magenta}Overview 			${yellow}--> ${green}Just an overview of analyze"
	echo -e "${green}2 ${magenta}Slowest services 		${yellow}--> ${green}Blame list of analyze"
	echo -e "${green}3 ${magenta}Plot all services 		${yellow}--> ${green}Plot of analyze"
	echo -e "${green}4 ${magenta}Critical chain 		${yellow}--> ${green}Tree of critical chain"
	echo "${NC}"
	read -p "==>_" answer
	echo " "
  	case $answer in
		1) systemd-analyze
		;;
		2) systemd-analyze blame
		;;
		3)  echo "Plotting Boot Times and display with Firefox"
			if [ -f ~/boot.svg ]; then
				rm ~/boot.svg
			fi
			systemd-analyze plot > boot.svg
			firefox boot.svg
		;;
		4) systemd-analyze critical-chain
		;;
	esac
}

