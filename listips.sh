#!/bin/bash

function help {
	echo "Convert IP ranges to a list of IPs"
	echo ""
	echo "Usage: listips.sh [-h] [-e IP range] [-ef filename] [IP range | -f filename]"
	echo ""
	echo "-e/--excl:  Specify an IP range to exclude"
	echo "-ef/--exfl: Specify a file containing IP ranges to exclude"
	echo "-f/--file:  Specify a file containing IP ranges to convert"
	echo "-h/--help:  Show this help info"
	exit
}

cmd='nmap -n -sL'
nextarg=1
skip=false

if [ $# -gt 0 ]; then
	for arg in $@; do
		nextarg=$((nextarg + 1))
		if [ $skip = false ]; then
			case $arg in
				--excl|-e)
					cmd="$cmd --exclude \$$nextarg"
					skip=true
					;;
				--exfl|-ef)
					cmd="$cmd --excludefile \$$nextarg"
					skip=true
					;;
				--file|-f)
					cmd="$cmd -iL \$$nextarg"
					break
					;;
				--help|-h)
					help	
					;;
				*)
					cmd="$cmd $arg"
					break
					;;
			esac
		else
			skip=false
		fi
	done
	cmd="$cmd | awk '/Nmap scan report/{print \$NF}'"
	eval $cmd
else 
	help
fi
