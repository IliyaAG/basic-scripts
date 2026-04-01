#!/bin/bash

HOST=$1
PATH=$2
PORT=80

exec 3<>/dev/tcp/$HOST/$PORT

#echo -e "GET $PATH"
#

exec 3>&-
exec 3<&-
