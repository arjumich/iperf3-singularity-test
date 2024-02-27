#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ] && [ "$#" -ne 2 ]; then
    echo "Usage: $0 <interface> <delay> <loss>"
    echo "Usage: $0 -d <interface>"
    exit 1
fi

# Function to apply delay and loss settings
apply_settings() {
    # Extract arguments
    local interface="$1"
    local delay="$2"
    local loss="$3"

    # Apply delay and loss using tc command
    tc qdisc add dev "$interface" root netem delay "${delay}ms" loss "${loss}%"
    echo "Delay of ${delay}ms and loss of ${loss}% applied to $interface"
}

# Function to delete delay and loss settings
delete_settings() {
    # Extract argument
    local interface="$1"

    # Delete delay and loss settings using tc command
    tc qdisc del dev "$interface" root netem
    echo "Delay and loss settings deleted for $interface"
}

# Check if the first argument is the delete option
if [ "$1" == "-d" ]; then
    # Delete settings
    delete_settings "$2"
#    tc qdisc show dev eth0
else
    # Apply settings
    apply_settings "$1" "$2" "$3"
fi

