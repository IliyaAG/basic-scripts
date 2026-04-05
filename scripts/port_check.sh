#!/usr/bin/env bash

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
    echo "Using netcat method..."
    nc -z -w 3 "$IP" "$PORT"
    result=$?
elif [[ "METHOD" == "devtcp" ]]; then
    echo "Using /dev/tcp method..."
    timeout 3 bash -c "</dev/tcp/$IP/$PORT" &>/dev/null
    result=$?
fi

if [[ $result -eq 0 ]]; then
    echo -e "\033[0;32m port $PORT is open \033[0m"
else
    echo -e "\033[0;31m port $PORT is close \033[0m"
fi
