#!/bin/bash

INSTALL_PATH="/usr/local/bin/vpnroulette"
DEPENDENCIES=('openvpn' 'curl' 'python' 'pip')
PSR="\e[35m >> \e[92m"
PSRE="\e[31m >> \e[92m"
DEF="\e[39m "


function banner() {
	printf "${PSR} Thank you for using VPNROULETTE! [https://vpnroulette.net]${DEF}\n"
	printf "${PSR} ----------------------------------------------------------${DEF}\n"
	echo ""
	printf "${PSR} After the installation type: ${DEF}vpnroulette and press ENTER \n"
	printf "${PSR} Enjoy your VPN connection!${DEF}\n"
	printf "${PSR} For more information please visit our website or join our Discord server! [ https://discord.gg/6CCD6P3T ]${DEF}\n"
}

function install() {
	printf "${PSR} Installing vpnroulette into ${INSTALL_PATH}...............${DEF}\n"
	curl -o ${INSTALL_PATH} -s "https://raw.githubusercontent.com/vpnroulette/client-linux/main/vpnroulette"
	chmod +x ${INSTALL_PATH}
}

function is_installed() {
	II=$(which $1 |grep -c $1)
	echo "${II}"
}

function init() {
	clear
	printf "${PSR} I'm going to install VPNROULETTE in your computer, do you want to continue? [y/n] ${DEF}\n"
	read r
	case $r in
		y|Y) check_dependencies && clear &&	banner;;
		n|N) echo "${PSR} Aborting, have a nice day! :) ${DEF}"; exit 0;;
		*) echo "What?" ; exit 33 ;;
	esac
}

function check_dependencies() {
	printf "${PSR} Checking dependencies.......... ${DEF}\n"
	for pkg in ${DEPENDENCIES[@]}; do
		i=$(is_installed $pkg)
		if [ ${i} != "1" ]; then
			printf "${PSRE} ${pkg} is not installed (installing via brew, may ask for your password)${DEF}\n"
			brew install ${pkg}
			if [ $? != "0" ]; then 
				printf "${PSRE} ${pkg} could not be installed${DEF}\n"
				exit 1
			fi
		else
			printf "${PSR} ${pkg} is installed ......OK${DEF}\n"
		fi
	done
	install
}

function install_py_modules() {
	pip install requests json re colorama pyfiglet termcolor importlib_metadata itsdangerous
}

#init
check_dependencies
install_py_modules
banner
