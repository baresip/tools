#!/bin/bash

trace_file="../../re_trace.json"

function gen_datfile_arg() {
    cat=$1
    ph=$2
    id=$3
    filename=${cat}_${ph}.dat

    jqc=".traceEvents[] | select (.id == \"${id}\" and .cat == \"${cat}\" and .name == \"${ph}\") | \"\(.ts),\(.args.${ph})\""
    jq -c "${jqc}" ${trace_file} | sed 's/"//g' > "${filename}"
}

function gen_datfile() {
    cat=$1
    ph=$2
    id=$3
    filename=${cat}_${ph}.dat

    jqc=".traceEvents[] | select (.id == \"${id}\" and .cat == \"${cat}\" and .name == \"${ph}\") | \"\(.ts)\""
    jq -c "${jqc}" ${trace_file} | sed 's/"//g' > "${filename}"
}

gen_datfile_arg jbuf recv_delay video
gen_datfile_arg jbuf play_delay video
gen_datfile_arg jbuf jitter_adjust video
gen_datfile_arg jbuf playout_diff video
gen_datfile_arg jbuf clock_skew video
gen_datfile_arg jbuf get video
gen_datfile_arg jbuf late_play video
gen_datfile_arg jbuf jitter video

pkill -f gnuplot
./jbuf.plot &
./jbuf_clocks.plot &
./aubuf.plot &

wait
