# set xdata time
# set timefmt "%s"
# set format x "%H:%M:%S" # or whatever
# set yrange [20000:40000] 
set terminal pdf
set output 'http-summary.pdf'

set xlabel "Time (s)"
set ylabel "TPS"
set style line 1 lt rgb "red" lw 3
set style line 2 lt rgb "olive" lw 3
set style line 3 lt rgb "blue" lw 3
set style line 4 lt rgb "black" lw 3
set style line 5 lt rgb "magenta" lw 3

set key t rm Left notitle 

plot    "faban/http-tps.dat" using 1:5 with lines ls 1 title "Faban",\
        "gatling/http-tps.dat" using 0:4 with lines ls 2 title "Gatling",\
        "grinder/http-tps.dat" using 0:4 with lines ls 3 title "Grinder",\
        "jmeter/http-tps.dat" using 1:5 with lines ls 4 title "jMeter",\
        "perfcake/http-tps.dat" using 1:5 with lines ls 5 title "PerfCake"