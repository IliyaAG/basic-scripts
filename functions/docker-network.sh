create_network () {

    NETWORK_NAME="${1:-}"
    DRIVER="${DRIVER:-bridge}"
    SUBNET="${SUBNET:-172.19.0.0/16}"
    GATEWAY="${GATEWAY:-172.19.0.1}"
    IP_RANGE="${IP_RANGE:-}"
    INTERNAL="${INTERNAL:-false}"
    ATTACHABLE="${ATTACHABLE:-true}"
    LABELS="${LABELS:-}"
    OPTIONS="${OPTIONS:-}"

    NET_CMD="docker network create"
    if docker network inspect ${NETWORK_NAME} > /dev/null 2>&1 ; then
        echo -e "${NETWORK_NAME} exist"
    else
        echo -e "Creating ${NETWORK_NAME} network..."
        [ -n "$DRIVER" ] && NET_CMD+=" --driver $DRIVER"
        [ -n "$SUBNET" ] && NET_CMD+=" --subnet $SUBNET"
        [ -n "$GATEWAY" ] && NET_CMD+=" --gateway $GATEWAY"
        [ -n "$IP_RANGE" ] && NET_CMD+=" --ip-range $IP_RANGE"
        [ "$INTERNAL" = "true" ] && NET_CMD+=" --internal"
        [ "$ATTACHABLE" = "true" ] && NET_CMD+=" --attachable"
        IFS=',' read -ra LABEL_ARRAY <<< "$LABELS"
        for label in "${LABEL_ARRAY[@]}"; do
            [ -n "$label" ] && NET_CMD+=" --label $label"
        done
        IFS=',' read -ra OPT_ARRAY <<< "$OPTIONS"
        for opt in "${OPT_ARRAY[@]}"; do
            [ -n "$opt" ] && NET_CMD+=" --opt $opt"
        done
        NET_CMD+=" $NETWORK_NAME"
        eval "$NET_CMD"
        echo -e "${NETWORK_NAME} network created successfully"
    fi
}
