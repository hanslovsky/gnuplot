#!/bin/bash

MIN="${MIN:-0}"
MAX="${MAX:-1000}"
STEP="${STEP:-1}"
DIGITS="${#MAX}"
N_ZERO_PADDING="${N_ZERO_PADDING:-$DIGITS}"
N_WHITESPACE_PADDING="${N_WHITESPACE_PADDING:-$DIGITS}"
SOURCE_DIR="${SOURCE_DIR:-fit_coordinates}"
TARGET_DIR="${TARGET_DIR:-plot_animation}"
SOURCE_FORMAT="$SOURCE_DIR/fitCoordinates_%d.csv"
SEPARATOR="${SEPARATOR:-,}"
TITLE_FORMAT="Iteration: %$N_WHITESPACE_PADDING""d"
SIZE_X="${SIZE_X:-480}"
SIZE_Y="${SIZE_Y:-$SIZE_X}"
TERM_TYPE="${TERM_TYPE:-pngcairo}"
TARGET_DIR="$TARGET_DIR""_$TERM_TYPE""_$SIZE_X""x$SIZE_Y"

if [[ "$TERM_TYPE" = "pngcairo" ]]; then
    SUFFIX="png"
elif [[ "$TERM_TYPE" = "pdf" ]]; then
    SUFFIX="pdf"
else
    SUFFIX="unknown"
fi

TARGET_FORMAT="$TARGET_DIR/%0$N_ZERO_PADDING""d.$SUFFIX"

mkdir -p "$TARGET_DIR"

# can this help with mixed italic/normal text?
# http://stackoverflow.com/questions/17809917/gnuplot-text-color-palette

for index in $(seq $MIN $STEP $MAX); do
    SOURCE_FILE=$(printf "$SOURCE_FORMAT" "$index" )
    TARGET_FILE=$(printf "$TARGET_FORMAT" "$index" )
    PLOT_TITLE="$(printf "$TITLE_FORMAT" $index)"
    echo "reset;
# set key top left;
unset key
set datafile separator '$SEPARATOR';

# coordinate system
set style line 11 lc rgb '#101010' lt 1
set border 3 back linestyle 11;
set xtics axis;
set ytics axis;
set tics scale 0.5;

# arrows
# set arrow from graph 1,0 to graph 1.05,0 size screen 0.015,20 filled linestyle 11;
# set arrow from graph 0,1 to graph 0,1.05 size screen 0.015,20 filled linestyle 11;

#grid
set style line 12 lc rgb'#808080' lt 0 lw 1;
set grid front ls 12;

# set term wxt
# set term pngcairo size 640,480 enhanced font 'monofur,12';
set term $TERM_TYPE size $SIZE_X,$SIZE_Y enhanced font 'URW Palladio L';

STRDIST = 0.025
CORRECTED_LENGTH=0.165
set title '$PLOT_TITLE';
set output '$TARGET_FILE';
set xlabel 'z-index';
set ylabel 'corrected z-index';
# set label 1 'z' at screen 0.5,0.5 font 'URW Palladio L-Italic';
# set label 2 '-' at screen 0.5+1*STRDIST,0.5;
# set label 3 'index' at screen 0.5+2*STRDIST,0.5;

# set label 4 'corrected' at screen 0.3,0.5 rotate by 90;
# set label 5 'z' at screen 0.3,0.5+CORRECTED_LENGTH rotate by 90 font 'URW Palladio L-Italic';
# set label 6 '-' at screen 0.3,0.5+CORRECTED_LENGTH+1*STRDIST rotate by 90;
# set label 7 'index' at screen 0.3,0.5+CORRECTED_LENGTH+2*STRDIST rotate by 90;

load '/groups/saalfeld/home/hanslovskyp/git/gnuplot/colors/sequential/hhmi.plt'

fraction(x) = ( x - $MIN ) * 1.0 / ($MAX - $MIN)

set xrange [0:]
set yrange [0:]

unset colorbox

# set object 1 rectangle from 750,750 to 950,950 back fs solid 0.15 noborder fc palette frac fraction($index)

plot '$SOURCE_FILE' using 1:2 title 'coordinate mapping' pointtype 7 pointsize 1.0 linecolor palette frac fraction($index) , \
     '$SOURCE_FILE' using 1:1 with lines title 'one-to-one mapping' linetype 0 linecolor rgb 'black';
" | gnuplot
done
