#!/usr/bin/env bash

OUTPUT="/var/lib/node_exporter/textfile_collector/custom_metrics.prom"

emit_metric() {
    local name="$1"
    local help="$2"
    local type="${3:-gauge}"
    local value="$4"
    local labels="$5"

    echo "# HELP ${name} ${help}"
    echo "# TYPE ${name} ${type}"

    if [ -n "$labels" ]; then
        echo "${name}{${labels}} ${value}"
    else
        echo "${name} ${value}"
    fi
    echo
}

add_metric() {
    emit_metric "$@" >> "$OUTPUT"
}

