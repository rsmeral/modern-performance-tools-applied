# set xdata time
# set timefmt "%s"
# set format x "%H:%M:%S" # or whatever
# set yrange [20000:40000] 
set terminal pdf
set output 'perfcake-applied-tps-response.pdf'

set xlabel "Time (s)"
set ylabel "TPS"
set ytics nomirror
set y2label "Response time (ms)"
set y2range [0:700]
set y2tics nomirror

set style line 1 lt rgb "red" lw 3
set style line 2 lt rgb "red" lw 1

set style line 3 lt rgb "olive" lw 3
set style line 4 lt rgb "olive" lw 1

set style line 5 lt rgb "blue" lw 3
set style line 6 lt rgb "blue" lw 1

set style line 7 lt rgb "black" lw 3
set style line 8 lt rgb "black" lw 1

set key t r Left notitle 

plot    "applied-tps-response.dat" using 1:2 with lines ls 1 title "TPS" axes x1y1,\
        "applied-tps-response.dat" using 1:3 with lines ls 5 title "Response time (ms)" axes x1y2