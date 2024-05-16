#!/usr/bin/gnuplot
#
# Choose your preferred gnuplot terminal or use e.g. evince to view the
# jbuf.eps!

set terminal wxt title "jbuf clocks"
#set terminal postscript eps size 30,20 enhanced color
#set output 'jbuf.eps'
#set terminal png size 1280,480
#set output 'jbuf.png'
set datafile separator ","
set key outside
set xlabel "time/ms"
set ylabel "delay (ms)"

plot 'data/jbuf_clock_skew.dat' using ($1/1000):2 title 'clock_skew' with linespoints, \
     'data/jbuf_jitter.dat' using ($1/1000):2 title 'jitter' with linespoints

pause mouse close # Comment for non-interactive terminals
