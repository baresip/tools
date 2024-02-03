#!/bin/bash

trace_file="../../re_trace.json"

function gen_datfile() {
    ph=$1
    filename=$2

    jqc=".traceEvents[] | select (.id == \"audio\" and .cat == \"jbuf\" and .name == \"${ph}\") | \"\(.ts),\(.args.${ph})\""
    jq -c "${jqc}" ${trace_file} | sed 's/"//g' > "${filename}"
}

gen_datfile recv_delay jbuf_recv_delay.dat
gen_datfile play_delay jbuf_play_delay.dat
gen_datfile jitter_adjust jbuf_jitter_adapt.dat
gen_datfile playout_diff jbuf_playout_diff.dat
gen_datfile clock_skew jbuf_clock_skew.dat
gen_datfile get jbuf_get.dat
gen_datfile late_play jbuf_late_play.dat
gen_datfile jitter jbuf_jitter.dat

./jbuf.plot
./jbuf_clocks.plot
