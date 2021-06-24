#!/bin/bash

# This program displays the vaious cyberseurity statistics from the website
# https://www.statista.com/topics/1731/smb-and-cyber-crime/ 
#
# Copyright 2021 Jody Petroni
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

clear

# Show a splash screen
figlet "Assessment 4"
figlet "Screen Scraping"
figlet "Jody Petroni"
figlet "840131"

# Reuse Password Check from Week 2
echo -e -n "\033[31m"
./passwordCheck.sh

if [ $? -eq 1 ]
then
	figlet "Goodbye"
	exit 1
fi

# Scrape content from website to look for all the url's containing statistical data.
# Use sed to Store these url's in an array so they can be searched and used later
echo -e "\033[34mGathering statistics from U.S. companies and cyber crime - statistics & facts - (this will take a couple of seconds!)\033[32m"
array=( $(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
https://www.statista.com/topics/1731/smb-and-cyber-crime/ | sed -n '/Dataset/,/name/p' | \
sed -n -r -e '/url/ {
 s/"url": "https/https/g
 s/",//g
p
}'
))
# Store the length of the array in a variable.
arraylength=${#array[@]}

# Now show each of the statistics description that is accessible from the array of URL's already stored.
# Use sed to search for descriptions and awk to display line numbers
curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" https://www.statista.com/topics/1731/smb-and-cyber-crime/ | \
sed -n 's/                                "description": "/"/p' | awk '{
									print NR "\033[32m. " $0
								       }'
echo 
echo "Type q to exit"

# Enter a loop so the user can view multiple statistics without re-running the program.
while [ "$selection" != "q" ]
do
	echo -e "\e[31m"
	# Ask user to enter a selection between 1 and the length of the array containing the url to the individual statistic.
	read -p "Enter a selection (1-$arraylength) to view the statistics: " selection
	if [ "$selection" = "q" ]; then
		# If the user types "q" then quit the program
  		figlet "Goodbye !!"
		# Exit gracefully
  		exit 0;
	fi
	# Check to see if the  selction is a Number
	if ! [[ "$selection" =~ ^-?[0-9]+$ ]]; then
	  echo "selection must be a number!"
	else
	  # Check to see if the number is between 1 and the length of the array
	  if [[ "$selection" -lt 1 ]] || [[ "$selection" -gt "$arraylength" ]]; then
	  	echo -e "Number must be between 1 and $arraylength!\n"
          else
		echo -e "\033[0m"
		# Lookup the URL from the array bassed on the users selection
		url="${array[($selection - 1)]}"
		echo "Reading statistics from - $url"
		echo
		# Using the statistics url scrape all the statistics and show in a formatted table.
		# Use grep to search for the begining of the statistics content.
		result=$(curl -s --user-agent "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
		$url | grep "<table id=\"statTableHTML")

		# Use sed to search for and replace common html Table elements to get the raw statistical data
		# Use awk to format and print the results in a formatted table.
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
				printf "%-50s",$i
				if (NF == cnt) 
					printf "\n"  
				cnt = cnt + 1
		 	 }
			}'
	   fi
	fi
done
