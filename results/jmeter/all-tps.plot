# set xdata time
# set timefmt "%s"
# set format x "%H:%M:%S" # or whatever
# set yrange [20000:40000] 
set terminal pdf
set output 'jmeter-tps.pdf'

set xlabel "Time (s)"
set ylabel "TPS"
set style line 1 lt rgb "red" lw 3 pt 3 ps 0.5
set style line 2 lt rgb "red" lw 1

set style line 3 lt rgb "olive" lw 3 pt 4 ps 0.5
set style line 4 lt rgb "olive" lw 1

set style line 5 lt rgb "blue" lw 3 pt 5 ps 0.5
set style line 6 lt rgb "blue" lw 1

set style line 7 lt rgb "black" lw 3 pt 6 ps 0.5
set style line 8 lt rgb "black" lw 1

set key t rm Left notitle 

plot    "http-tps.dat" using 1:5 with linespoints ls 1 title "HTTP",\
        "jms-tps.dat" using 1:5 with linespoints ls 3 title "JMS",\
        "rest-tps.dat" using 1:5 with linespoints ls 5 title "REST",\
        "ws-tps.dat" using 1:5 with linespoints ls 7 title "WS"
#"http-tps.dat" using 1:($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks ls 2 notitle,\
#"jms-tps.dat" using 1:($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks ls 4 notitle,\
#"rest-tps.dat" using 1:($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks ls 6 notitle,\
#"ws-tps.dat" using 1:($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks ls 8 notitle