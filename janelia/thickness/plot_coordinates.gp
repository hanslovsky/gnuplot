reset

set datafile separator ','

set term wxt

set key top left

set term pdf enhanced size 3in,3in font 'URW Palladio L';
set output 'fit_coordinates.pdf'

# coordinate system
set style line 11 lc rgb '#101010' lt 1
set border 3 back linestyle 11;
set xtics axis;
set ytics axis;
set tics scale 0.5;


#grid
set style line 12 lc rgb'#808080' lt 0 lw 1;
set grid front ls 12;



load "~/git/gnuplot/colors/sequential/hhmi.plt"

fraction(x) = x / 100.0

unset colorbox

set xrange[0:60]
set yrange[0:60]

plot 'fit_coordinates/fitCoordinates_0.csv' title 'start' with lines lc rgb 'gray' lw 3, \
     for [idx=1:100:1] 'fit_coordinates/fitCoordinates_'.idx.'.csv' using 1:3 with lines notitle lc palette frac fraction(idx) lw 2, \
     'fit_coordinates/fitCoordinates_100.csv' using 1:3 with lines title 'end'  lc rgb 'black' lw 3, \
     'fit_coordinates/fitCoordinates_100.csv' using 1:2 with lines title 'end - sorted' lc rgb 'orange' lw 3

set output
