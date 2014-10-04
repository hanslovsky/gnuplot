# line styles for new hhmi logo colors 
# for use with sequential data
# provides 8 dark to light green colors
# compatible with gnuplot >=4.2
# author: Philipp Hanslovsky
# interpolation done in rgb space

# line styles
set style line 1 lc rgb '#338F98' # H
set style line 2 lc rgb '#2EA948' # H
set style line 3 lc rgb '#4CB938' # M
set style line 4 lc rgb '#7DC92C' # I

# palette
set palette defined ( 0 '#338F98',\
		      1 '#2EA948',\
		      2 '#4CB938',\
		      3 '#7DC92C' )