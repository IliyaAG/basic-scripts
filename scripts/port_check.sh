#!/usr/bin/env bash

#IP=$1
#PORT=$2
#echo "" > /dev/tcp/$IP/$PORT
usage() {
    echo "Usage: $0 [-z | -d] -i <ip> -p <port>"
    echo
    echo "Options:"
    echo "    -z        Check port using nc (netcat)"
    echo "    -d        Check port using /dev/tcp"
    echo "    -i <ip>   Target ip address"
    echo "    -p <port>   Target port"
    exit 1
}
METHOD="devtcp"
while getopts ":zdi:p:" opt; do
    case $opt in
        z)
            METHOD="nc"
            ;;
        d)
            METHOD="devtcp"
            ;;
        i)
            IP="$OPTARGS"
            ;;
        p)
            PORT="$OPTARGS"
            ;;
        *)
            usage
            ;;
    esac
done


if [[ -z "$IP" || -z "$PORT" ]]; then
    usage
fi

if [[ "METHOD" == "nc" ]]; then
    echo "testing"
    nc -z -w 3 "$IP" "$PORT"
    result=$?
elif [[ "METHOD" == "devtcp" ]]; then
    echo "blahbla"
    timeout 3 bash -c "</dev/tcp/$IP/$PORT" &>/dev/null
    result=$?
fi

if [[ $result -eq 0 ]]; then
    echo "opem"
else
    echo "close"
fi
