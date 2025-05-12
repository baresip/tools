#!/bin/bash

trace_file="../../re_trace.json"

function gen_datfile_arg() {
    cat=$1
    ph=$2
    id=$3
    filename=data/${cat}_${ph}.dat

    jqc=".traceEvents[] | select (.id == \"${id}\" and .cat == \"${cat}\" and .name == \"${ph}\") | \"\(.ts),\(.args.${ph})\""
    jq -c "${jqc}" ${trace_file} | sed 's/"//g' > "${filename}"
}

function gen_datfile() {
    cat=$1
    ph=$2
    id=$3
    filename=data/${cat}_${ph}.dat

    jqc=".traceEvents[] | select (.id == \"${id}\" and .cat == \"${cat}\" and .name == \"${ph}\") | \"\(.ts)\""
    jq -c "${jqc}" ${trace_file} | sed 's/"//g' > "${filename}"
}

mkdir -p data

gen_datfile_arg jbuf recv_delay audio
gen_datfile_arg jbuf play_delay audio
gen_datfile_arg jbuf jitter_adjust audio
gen_datfile_arg jbuf playout_diff audio
gen_datfile_arg jbuf clock_skew audio
gen_datfile_arg jbuf get audio
gen_datfile_arg jbuf late_play audio
gen_datfile_arg jbuf jitter audio
gen_datfile_arg jbuf lost audio
gen_datfile_arg aubuf cur_sz_ms aureceiver
gen_datfile_arg aubuf append_delay aureceiver
gen_datfile_arg aubuf read_delay aureceiver
gen_datfile aubuf underrun aureceiver 
gen_datfile aubuf overrun aureceiver
gen_datfile aubuf filling aureceiver

pkill -f gnuplot
./jbuf.plot &
./jbuf_clocks.plot &
./aubuf.plot &

wait
