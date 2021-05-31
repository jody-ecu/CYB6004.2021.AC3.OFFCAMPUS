#!/bin/bash
match=0
while read p; do
  [ -f "$p" ] && echo "$p - That file exists!" && match=1
  [ -d "$p" ] && echo "$p - This directory exists!" && match=1
  if [ $match -eq 0 ]; then
	echo "$p - I dont know what that is"
  fi
done <$1
