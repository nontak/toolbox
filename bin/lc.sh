#!/bin/sh

CACHE=~/.linecache
[[ ! -e "$CACHE" ]] && touch $CACHE

while getopts hn OPT
do
  case $OPT in
    h) FLG_h=true;;
    n) FLG_n=true;;
  esac
done
shift $((OPTIND - 1))
PRINT="$*"

help() {
cat << EOF
lc : line cache
Usage:
  lc [-h] [-n] [linenums...]
Example:
  1. Cache (and show) new lines:
    cat README | lc
  2. Show the cache with numbers:
    lc -n
  3. Show the specific lines 1, 3to5, and 10
    lc 1 3,5 10
EOF
}

[[ "$PRINT" ]] && PRINT=`echo "$PRINT" | sed -e "s/ /p;/g" -e "s/$/p/"`
[[ "$PRINT" ]] && SED="sed -n $PRINT"

if [ "$FLG_n" ]; then CAT="cat -n"; else CAT="cat"; fi
if [ "$FLG_h" ]; then help; exit 0; fi
if [ -p /dev/stdin ]; then INPUT="/dev/stdin"; else INPUT="$CACHE"; fi

if [ "$SED" ]; then
  cat $INPUT | tee $CACHE | $CAT | $SED
else
  cat $INPUT | tee $CACHE | $CAT
fi

exit 0
