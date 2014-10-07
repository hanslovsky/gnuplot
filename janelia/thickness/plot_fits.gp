#!/usr/bin/gnuplot --persist

reset

set datafile separator ','

set term wxt

set key top right

# set term pdf enhanced size 12,7.5
# set output 'fit_tracker.pdf'

# awesome gnuplot colormaps:
# https://github.com/aschn/gnuplot-colorbrewer

f(x) = -x
fraction(x) = x/( 1000.0 )

load '~/git/gnuplot-colorbrewer/sequential/GnBu.plt'

plot 'fit_tracker/fitTracker_1.csv' using 0:(-($1)) title 'iteration=1' with lines lc rgb 'black', \
     for [idx=50:1000:50] 'fit_tracker/fitTracker_'.idx.'.csv' using 0:(-($1)) with lines title 'iteration='.idx lc palette frac fraction(idx), \
     'fit_tracker/fitTracker_1000.csv' using 0:(-($1)) with lines title 'iteration=1000' lc palette frac fraction(1000)

# set output
