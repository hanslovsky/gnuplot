#!/bin/bash

# run as TERM_TYPE={pgncairo|pdf} ./create_plots.sh
PNGCAIRO_SIZES=$(echo 480 640 960 | tr ' ' '\n' )
PDF_SIZES=$(echo 3in 5in 7in | tr ' ' '\n' )

if [[ "$TERM_TYPE" = pngcairo ]]; then
    SIZES=$PNGCAIRO_SIZES
elif [[ "$TERM_TYPE" = pdf ]]; then
    SIZES=$PDF_SIZES
else
    exit 1
fi

for s in $SIZES; do
    echo "Processing term type $TERM_TYPE at size $s ..."
    SIZE_X=$s TERM_TYPE=$TERM_TYPE ./plot_animation.sh
done
    

