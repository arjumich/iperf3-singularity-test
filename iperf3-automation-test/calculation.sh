#!/bin/bash

#if [ "$#" -ne 1 ]; then
#        echo "Usage: 1: View current buffer size"
#        echo "Usage: 2: Set max buffer size (8MB)"
#        echo "Usage: 3: Reset to default buffer size"
#    exit 1
#fi


python3 buff_calculate.py "$1"

python_result=$(python3 buff_calculate.py "$1")

echo "$python_result"

#CALC_DELAY=$delay*0.001
#BYTE=1048576
#BANDWIDTH=2500
#PRODUCT=2*$BANDWIDTH*$CALC_DELAY
#BUF_SIZE_MB=$PRODUCT*0.125
#BUF=$BUF_SIZE_MB*$BYTE
#echo "$BUF"
