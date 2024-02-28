#!/bin/bash

if [ "$#" -ne 1 ]; then
   	echo "Usage: 1: View current buffer size"
	echo "Usage: 2: Set max buffer size (8MB)"
	echo "Usage: 3: Reset to default buffer size"
    exit 1
fi

choice="$1"

case $choice in
    1)
        sysctl net.core.rmem_max
	sysctl net.core.wmem_max
	sysctl net.ipv4.tcp_rmem
	sysctl net.ipv4.tcp_wmem
	;;
    2)
        sysctl -w net.core.rmem_max=8388608
	sysctl -w net.core.wmem_max=8388608
	sysctl -w net.ipv4.tcp_rmem='8388608 8388608 8388608'
	sysctl -w net.ipv4.tcp_wmem='8388608 8388608 8388608'
	sysctl -w net.ipv4.route.flush=1
        ;;
    3)
        sysctl -w net.core.rmem_max=212992
        sysctl -w net.core.wmem_max=212992
        sysctl -w net.ipv4.tcp_rmem='4096 131072 5129504'
        sysctl -w net.ipv4.tcp_wmem='4096 16384 4194304'
	sysctl -w net.ipv4.route.flush=1
        ;;

esac
