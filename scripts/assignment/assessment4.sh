#!/bin/bash
clear
figlet "Assignment 2"
figlet "Screen Scraping"

echo "Getting Statistics ..."
array=( $(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
https://www.statista.com/topics/1731/smb-and-cyber-crime/ | awk '/Dataset/,/url/' |  grep -o 'http[s]*://[^/][^\\]*' | cut -f1 -d'"') )

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ));
do
  echo -e "$(($i+1))\t${array[$i]}"
done

read -p "Enter a selection (1-$arraylength) to view the statistics: " selection
echo "Preparing statistics for selection ($selection) ....."
var="${array[($selection - 1)]}"

echo

result=$(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
$var | grep "<table id=\"statTableHTML")



echo $result | awk -v RS='<span>|<tr><th>|<tr><td>|</td></tr>|</th></tr>|</span>' -F'(</?td>|</?th>|</?span>)+' -v OFS='\t' 'NF>1{$1=$1; print}' | column -s$'\t' -t
