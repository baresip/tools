#!/usr/bin/gnuplot
#
# Choose your preferred gnuplot terminal or use e.g. evince to view the
# jbuf.eps!

set terminal wxt title "jbuf delay"
#set terminal qt persist
#set terminal postscript eps size 30,20 enhanced color
#set output 'jbuf.eps'
#set terminal png size 1280,480
#set output 'jbuf.png'
set datafile separator ","
set key outside
set xlabel "time/ms"
set ylabel "delay (ms)"

stats "data/jbuf_recv_delay.dat" using ($2) name "N"
stats "data/jbuf_late_play.dat" using ($2) name "L" nooutput
stats "data/jbuf_lost.dat" using ($2) name "X" nooutput

plot 'data/jbuf_recv_delay.dat' using ($1/1000):2 title 'receive' with linespoints, \
  'data/jbuf_play_delay.dat' using ($1/1000):2 title 'playout' with points, \
  'data/jbuf_jitter_adjust.dat' using ($1/1000):2 title 'adapt' with points, \
  'data/jbuf_playout_diff.dat' using ($1/1000):2 title 'playout_diff' with linespoints, \
  'data/jbuf_late_play.dat' using ($1/1000):2 title sprintf("Late: %d", L_records) with points, \
  'data/jbuf_lost.dat' using ($1/1000):2 title sprintf("Lost: %d", X_sum) with points

pause mouse close # Comment for non-interactive terminals
