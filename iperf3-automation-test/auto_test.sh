#!/bin/bash

DELAY_LIST=(0 50 75 100 200
)

OUTPUT_FOLDER=automation_test

mkdir $OUTPUT_FOLDER

for DELAY in "${DELAY_LIST[@]}" ; do

	echo "Generating test results for default and modified buffer for "$DELAY"ms delay and 0.1% loss... "
	echo " "

	echo "Default Buffer: "
	./emmulate_wan.sh -d eth0
	./emmulate_wan.sh eth0 "$DELAY" 0.1
	./modify_tcp_buffer_size.sh 3
	./iperf3-tests.sh | tee $OUTPUT_FOLDER/"$DELAY"ms_0.1_loss_no_mod_output.txt

	echo "Modified Buffer: "
        ./modify_tcp_buffer_size.sh 2
        ./iperf3-tests.sh | tee $OUTPUT_FOLDER/"$DELAY"ms_0.1_loss_mod_output.txt

done
