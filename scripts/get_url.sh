#!/bin/bash

HOST=$1
PATH=${2:-/}
PORT=80

exec 3<>/dev/tcp/$HOST/$PORT

echo -e "GET $PATH HTTP/1.1\r\nHost: $HOST\r\nConnection: close\r\n\r\n" >&3
while RES= read -r line <&3; do
    echo "$line"
done

exec 3>&-
exec 3<&-
