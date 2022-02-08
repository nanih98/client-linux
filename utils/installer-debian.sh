#!/bin/bash

INSTALL_PATH="/usr/local/bin/vpnroulette"
DEPENDENCIES=('openvpn' 'curl' 'pip3' 'python3' 'python3-pip')
PSR="\e[35m >> \e[92m"
PSRE="\e[31m >> \e[92m"
DEF="\e[39m "


function banner() {
	echo -e "${PSR} Thank you for using VPNROULETTE! [https://vpnroulette.com]${DEF}"
	echo -e "${PSR} ----------------------------------------------------------${DEF}"
	echo ""
	echo -e "${PSR} After the installation type: ${DEF}vpnroulette and press ENTER"
	echo -e "${PSR} Enjoy your VPN connection!${DEF}"
	echo -e "${PSR} For more information please visit our website or join our Discord server! [ https://discord.gg/6CCD6P3T ]${DEF}"
}

function install() {
	echo -e "${PSR} Installing vpnroulette into ${INSTALL_PATH}...............${DEF}"
	curl -o ${INSTALL_PATH} -s "https://raw.githubusercontent.com/vpnroulette/client-linux/main/vpnroulette"
	chmod +x ${INSTALL_PATH}
	pip3 install importlib_metadata
    pip3 install termcolor
    pip3 install pyfiglet
}

function is_installed() {
	II=$(which $1 |grep -c $1)
	echo "${II}"
}

function init() {
	clear
	echo -e "${PSR} I'm going to install VPNROULETTE in your computer, do you want to continue? [y/n] ${DEF}"
	read r
	case $r in
		y|Y) check_dependencies && clear &&	banner;;
		n|N) echo "${PSR} Aborting, have a nice day! :) ${DEF}"; exit 0;;
		*) echo "What?" ; exit 33 ;;
	esac
}

function check_dependencies() {
	echo -e "${PSR} Checking dependencies.......... ${DEF}\n"
	for pkg in ${DEPENDENCIES[@]}; do
		i=$(is_installed $pkg)
		if [ ${i} != "1" ]; then
			echo -e "${PSRE} ${pkg} is not installed (installing)${DEF}\n"
			sudo apt-get install -y ${pkg}
		else
			echo -e "${PSR} ${pkg} is installed ......OK${DEF}\n"
		fi
	done
	install
}



#init
check_dependencies
banner
