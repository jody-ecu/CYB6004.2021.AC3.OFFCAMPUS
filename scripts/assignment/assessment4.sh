#!/bin/bash
clear
figlet "Assessment 4"
figlet "Screen Scraping"
figlet "Jody Petroni"
figlet "840131"

#Scrape content from website to look for all the url's containing statistical data.
#Store these in an array
array=( $(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
https://www.statista.com/topics/1731/smb-and-cyber-crime/ | sed -n '/Dataset/,/name/p' | \
sed -n -r -e '/url/ {
 s/"url": "https/https/g
 s/",//g
p
}'
))

#Now show the statistics description.
arraylength=${#array[@]}
curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" https://www.statista.com/topics/1731/smb-and-cyber-crime/ | \
sed -n 's/                                "description": "/"/p' | awk 'BEGIN {
									print "\033[34mGathering statistics from U.S. companies and cyber crime - statistics & facts\033[32m"
								       }
								       {
									print NR "\033[32m. " $0
								       }'
echo 
echo "Type q to exit"

while [ "$selection" != "q" ]
do
	echo -e "\e[31m"
	read -p "Enter a selection (1-$arraylength) to view the statistics: " selection
	if [ "$selection" = "q" ]; then
  		echo -e "\033[34mGoodbye and thanks for using!!"
  		exit;
	fi
	echo -e "\033[0m"
	var="${array[($selection - 1)]}"
	echo "Reading statistics from - $var"
	echo
	#using the statistics url scrape all the statistics
	result=$(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
	$var | grep "<table id=\"statTableHTML")

	echo $result | sed -n '/<tr><td >/ {
	 s/<thead><tr><th>//g	
	 s/<\/th><th>/~/g
	 s/<\/th><\/tr><\/thead>/\n/g
	 s/<tbody><tr><td >//g
	 s/<\/td><td >/~/g
	 s/<\/td><\/tr><tr><td >/\n/g
	 s/<\/td><\/tr><\/tbody><\/table>//g 
	 s/<\/div>//g
	 s/class="statisticChart statisticChart--typeTable hide ">//g
	 s/<div class="dataTables_wrapper">//g
	 s/<div id="statTable"><\/div>"//g
	 s/<table id="statTableHTML" class="table hidden">//g
	 s/<\/div><div data-statistic-chart//g
 	 s/<div id="statTable">//g
 	 s/<div data-statistic-chart//g
	 s/class="statisticChart statisticChart--typeTable display-block ">//g
 	 s/<span>%<\/span>//g
	 p
	}' | awk 'BEGIN {
		   FS="~"
		} 
		{
		 cnt=1
		 for (i = 1; i <= NF; i++) 
		 {
			printf "%-60s",$i
			if (NF == cnt) 
				printf "\n"  
			cnt = cnt + 1
		 }
		}'
done
