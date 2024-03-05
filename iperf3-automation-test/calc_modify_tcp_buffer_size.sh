#!/bin/bash

if [ "$#" -gt 2 ] || [ $# -lt 1 ]; then
   	echo "Usage: <1>: 	 View current buffer size"
	echo "Usage: <2,Delay>:  Set max buffer size according to Delay. Pass Delay as second argument"
	echo "Usage: <3>:	 Reset to default buffer size"
    exit 1
fi

choice="$1"
delay="$2"


case $choice in
    1)
        sysctl net.core.rmem_max
	sysctl net.core.wmem_max
	sysctl net.ipv4.tcp_rmem
	sysctl net.ipv4.tcp_wmem
	;;
    2)
	python3 buff_calculate.py "$delay"

	MAX_BUF=$(python3 buff_calculate.py "$delay")
	
#	mem_max=$((MAX_BUF*2))
#	echo "$mem_max"
	echo "$MAX_BUF"
        
	sysctl -w net.core.rmem_max=$MAX_BUF
	sysctl -w net.core.wmem_max=$MAX_BUF
	sysctl -w net.ipv4.tcp_rmem="$MAX_BUF $MAX_BUF $MAX_BUF"
	sysctl -w net.ipv4.tcp_wmem="$MAX_BUF $MAX_BUF $MAX_BUF"
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
