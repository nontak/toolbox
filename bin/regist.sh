#!/bin/sh 

args() {
  while getopts hfs:r: OPT
  do
    case $OPT in
      h) OPT_h=true;;
      f) OPT_f=true;;
      s) OPT_s="$OPTARG";;
      r) OPT_r="$OPTARG";;
    esac
  done
}

# It treat to long options.
ARGS=
for arg in $*
do
  case $arg in
    "--source_dir") arg="-s";;
    "--regist_dir") arg="-r";;
  esac
  ARGS="$ARGS $arg"
done
args $ARGS

fullpath() {
  echo `cd $1; pwd`
}

help() {
cat << EOF
regist : It register scripts in the shell in the form of a symboliclink.
Usage:
  regist [-h] [-f] [-s, --source_dir path] [-r, --regist_dir path]
    -f: force
EOF
}

if [ "$OPT_h" ]; then help; exit 0; fi 
if [ -z "$OPT_s" -o -z "$OPT_r" ]; then help; exit 1; fi
SOURCEDIR=`fullpath ${OPT_s}`
REGISTDIR=`fullpath ${OPT_r}`

if [ "$OPT_f" ]; then LS_OPT="-sf"; else LS_OPT="-s"; fi
for file in `find $SOURCEDIR -name "*.sh"`
do
  alias=`basename $file`
  ln ${LS_OPT} $file $REGISTDIR/${alias%.*}
done

exit 0
