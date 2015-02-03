# Gnuplot Script
# To generate: C-x p
# script fixbb fixes bounding box. If not in system/bin, find at 
# http://www.gnuplot.info/scripts/files/fixbb
################################################################################
# This program by L A Ferres is in the public domain and freely copyable.
# (or, if there were problems, in the errata  --- see
#    http://www.udec.cl/~leo/programs.html)
# If you find any bugs, please report them immediately to: leo@inf.udec.cl
################################################################################
#
# FILE NAME:
#
# PURPOSE:
#
# FILE(S) GENERATING THIS DATA:
#
# CREATION DATE: ; MODIFIED:
#
################################################################################
#
# General options for Azu graphs
# They are inserted in Latex files in a picture environment
#
set terminal postscript portrait "Times-Roman" 12
set terminal postscript enhanced
set output "speedup.eps" # Output file
set border
set size 0.7,0.35
#unset time # Leave time on until we're done with paper (to know latest version)
set lmargin -1
set bmargin -1
set rmargin -1
set tmargin -1

# Details for this particular plot
set key at 8,33 # legend to the left (bottom is also an option)
#unset logscale y  #set for logarithmic scale y (add x for log x)
set xlabel "\# of processors" # XAxis title
set ylabel "Speedup" # YAxis title
set border 3 lw 0.5
set xtics nomirror
set ytics nomirror
show key
#set title "" # Graph title

# data usually in .dat files
# using syntax: <column number>:<column number>
plot "speedup.csv" using 2:xticlabel(1) title '{/Times=11 psta-ctree}' with linespoints lt 1 pt 3, \
     "speedup.csv" using 4 title '{/Times=11 psta-osm }' with linespoints lt 1 pt 9, \
     "speedup.csv" using 3 title '{/Times=11 sdsl-ctree}' with linespoints lt 3 pt 3, \
     "speedup.csv" using 5 title '{/Times=11 sdsl-osm }' with linespoints ls 3 pt 9
