#!/bin/bash 
# IP address of the iperf server
IP_ADDRESS="172.31.43.131"

# Number of iperf parallel client connections
NUM_CONNECTIONS_LIST=(1 4 8 12
)

#for connection numbers 1, grep '\[  4\]' | awk '{print $7}' | tail -n 2 | head -n 1 | bc)


# Duration of the iperf test (in seconds)
TEST_DURATION=30

echo "Running iperf3 tests for $TEST_DURATION seconds on each pass with single and multiple stream"
echo "Test starting...."


#loop over single/parallel connections in range
for NUM_CONNECTIONS in "${NUM_CONNECTIONS_LIST[@]}" ; do

        echo "Running test for $NUM_CONNECTIONS stream: "
        total_bandwidth=0

#run 3 times for one setting and take average of 3 passes
        for ((i = 1; i <= 3; i++)); do
                # Run iperf test
                iperf_result=$(iperf3 -c "$IP_ADDRESS" -P "$NUM_CONNECTIONS" -w 416K -t "$TEST_DURATION" -f m)
#               echo "$iperf_result"


                # Extract bandwidth from iperf result
                #for connection numbers 1, grep '\[  4\]' | awk '{print $7}' | tail -n 2 | head -n 1 | bc)
                if [ $NUM_CONNECTIONS -eq 1 ]; then
                        sender_bandwidth=$(echo "$iperf_result" | grep '\[  5\]' | awk '{print $7}' | tail -n 2 | head -n 1 | bc)
#                       echo "$sender_bandwidth"
#                       sender_bandwidth2=$(echo $"sender_bandwidth/1" | bc)
#                       echo "$sender_bandwidth2"
                else
                        sender_bandwidth=$(echo "$iperf_result" | grep SUM | awk '{print $6}' | tail -n 2 | head -n 1 | bc)
#                       sender_bandwidth=$(echo $"sender_bandwidth/1" | bc)
                fi

                echo "Bandwidth rate on $i Pass: $sender_bandwidth Mbits/sec"

#               total_bandwidth=$((total_bandwidth + sender_bandwidth))
                total_bandwidth=$((total_bandwidth + $(echo "$sender_bandwidth / 1" | bc)))
#               echo "$total_bandwidth"

#		if [i -eq 1] || [i -eq 2];then
#		sysctl -w net.ipv4.route.flush=1
		echo "Taking 5 second brake before next pass..."
		sleep 5
#		fi
        done

        average=$((total_bandwidth/3))

        echo "Average Bandwidth for $NUM_CONNECTIONS stream after 3 passes: $average Mbits/sec"
        echo " "

	echo "Taking 5 second brake before next Pass"
	sleep 5
done
