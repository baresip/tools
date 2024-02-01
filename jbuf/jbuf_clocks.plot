#!/usr/bin/gnuplot
#
# How to generate a plot
# ======================
# This gnuplot script plots DEBUG_LEVEL 6 output of jbuf.c. You have to
# increment the DEBUG_LEVEL in ajb.c if you want to get the table for
# jbuf.dat. Then call baresip like this:
#
# ./baresip 2>&1 | grep -Eo "jbuf.*" > jbuf.dat
#
# Call this script. Then compare the plot legend with the variables in jbuf.c!
#
#
# Description of the plot
# =======================
# The plot is a time based diagram.
#
# Events:
# - overflow
# - underflow
# - packet too late
# - out of sequence
# - lost packet
# Copyright (C) 2023 commend.com - Christian Spielberger


# Choose your preferred gnuplot terminal or use e.g. evince to view the
# jbuf.eps!

set terminal wxt persist
#set terminal postscript eps size 30,20 enhanced color
#set output 'jbuf.eps'
#set terminal png size 1280,480
#set output 'jbuf.png'
set datafile separator ","
set key outside
set xlabel "time/ms"
set ylabel "delay (ms)"

plot 'jbuf_clock_skew.dat' using ($1/1000):2 title 'clock_skew' with linespoints, \
     'jbuf_jitter.dat' using ($1/1000):2 title 'jitter' with linespoints

