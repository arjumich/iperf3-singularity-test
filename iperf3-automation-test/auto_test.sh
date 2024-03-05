#!/bin/bash

DELAY_LIST=(0 25 50 75 100 200
)

OUTPUT_FOLDER=HPC_BUF_autotune_testrun_1

mkdir $OUTPUT_FOLDER

for DELAY in "${DELAY_LIST[@]}" ; do

	echo "Generating test results for default and modified buffer for "$DELAY"ms delay and 0.1% loss... "
	echo "---------------------------------------------------------------------------- "

	echo "Default Buffer: "
	echo "--------------------------------"
	./emmulate_wan.sh -d enp0s3
	echo "--------------------------------"
	./emmulate_wan.sh enp0s3 "$DELAY" 0.1
	echo "------------------------------- "
	./calc_modify_tcp_buffer_size.sh 3
	echo "------------------------------- "
	./iperf3-tests.sh | tee $OUTPUT_FOLDER/"$DELAY"ms_0.1_loss_no_mod_output.txt


	echo "Modified Buffer: "
	echo "---------------------------------------------------------------------------- "
        ./calc_modify_tcp_buffer_size.sh 2 $DELAY
        ./iperf3-tests.sh | tee $OUTPUT_FOLDER/"$DELAY"ms_0.1_loss_mod_output.txt

done
