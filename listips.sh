#!/bin/bash

function help {
	echo "Convert IP ranges to a list of IPs"
	echo ""
	echo "Usage: listips [-h] [-f filename] [IP range]"
	echo ""
	echo "-f/--file: Specify a file containing IP ranges to convert"
	echo "-h/--help: Show this help info"
	exit
}

if [ $# -gt 0 ]; then
	case "$1" in
		--file|-f)
			nmap -n -sL -iL $2 | awk '/Nmap scan report/{print $NF}'
			;;
		--help|-h)
			help	
			;;
		*)
			nmap -n -sL $1 | awk '/Nmap scan report/{print $NF}'
			;;
	esac
else 
	help
fi
