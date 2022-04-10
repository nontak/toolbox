#!/bin/sh
########################################
#
# Cut the line number columns made with nl.
#
########################################
  cat | sed -e "s/^ *[0-9][0-9]*	//"
exit 0
