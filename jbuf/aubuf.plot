#!/usr/bin/gnuplot

# Choose your preferred gnuplot terminal or use e.g. evince to view the
# jbuf.eps!

set terminal wxt title "aubuf receive"
#set terminal postscript eps size 30,20 enhanced color
#set output 'jbuf.eps'
#set terminal png size 1280,480
#set output 'jbuf.png'
set datafile separator ","
set key outside
set xlabel "time/ms"
set ylabel "delay (ms)"

stats "aubuf_cur_sz_ms.dat" using ($2) name "N"
event_h(i) = (0.5*N_max) + 0.3*N_max*(i/6.0)

plot 'aubuf_cur_sz_ms.dat' using ($1/1000):2 title 'size' with linespoints, \
     'aubuf_underrun.dat' using ($1/1000):(event_h(1)) title sprintf("Underrun: %d", U_records)  with points, \
     'aubuf_overrun.dat' using ($1/1000):(event_h(2)) title sprintf("Overrun: %d", O_records)  with points, \
     'aubuf_filling.dat' using ($1/1000):(event_h(3)) title sprintf("Filling: %d", F_records)  with points

pause mouse close # Comment for non-interactive terminals
