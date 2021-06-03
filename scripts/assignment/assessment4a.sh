#!/bin/bash
clear
figlet "Assessment 4"
figlet "Screen Scraping"
figlet "Jody Petroni"
figlet "840131"
#Scrape content from website to look for all the url's containing statistical data.
echo "Getting Statistics from the website https://www.statista.com/topics/1731/smb-and-cyber-crime/ ..."
array=( $(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
https://www.statista.com/topics/1731/smb-and-cyber-crime/ | sed -n '/Dataset/,/name/p' | \
sed -n -r -e '/url/ {
 s/"url": "https/https/g
 s/",//g
p
}'
))
#now adding the statistics description.
arraylength=${#array[@]}
echo "$arraylength"
array+=( $(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
https://www.statista.com/topics/1731/smb-and-cyber-crime/ | sed -n '/Dataset/,/name/p' | \
sed -n -r -e '/"name":/ { 
 s/"name": "//g 
 s/ /?/g
 s/",//g
p
}' ) )

arraylength2=${#array[@]}
echo "$arraylength2"

# use for loop to read all values and indexes
for (( i=${arraylength}; i<${arraylength2}; i++ ));
do
  o=$(echo -e "$(($i+1-$arraylength))\t${array[$i]}" | tr "?" " ")
#  x=$(echo "$o" | tr " " ".")
  echo "$o"
done


read -p "Enter a selection (1-$arraylength) to view the statistics: " selection
statisticDesc=$(echo "${array[$selection + $arraylength-1]}" | tr "?" " ")
echo "Preparing statistics for selection ($selection) $statisticDesc"
var="${array[($selection - 1)]}"

#using the statistics url scrape all the statistics
result=$(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
$var | grep "<table id=\"statTableHTML")


#show the statistics in a nice to read format on the screen
echo $result | sed -n '/<tr><td>/ {
 s/<tr><td>//g
 s/<tr><th>//g
 s/<\/td><\/tr>/\n/g
 s/<\/td><td>/\t\t\t\t/g
 s/<\/th><th>/\t\t\t/g
 s/<\/th><\/tr><\/thead><tbody>\n//g
 s/class="statisticChart statisticChart--typeTable hide "><div class="dataTables_wrapper"><div id="statTable"><\/div><\/div><table id="statTableHTML" class="table hidden"><thead>//g
 s/class="statisticChart statisticChart--typeTable display-block "><div class="dataTables_wrapper"><div id="statTable"><\/div><\/div><table id="statTableHTML" class="table hidden"><thead>//g
 s/<\/tbody><\/table><\/div><div data-statistic-chart//g
 s/<\/th><\/tr><\/thead><tbody>/\n/g
 s/<span>%<\/span>/%/g
p

}'

