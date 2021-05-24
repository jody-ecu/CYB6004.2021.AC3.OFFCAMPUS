#!/bin/bash
read -sp "Enter Password: " pwd
hash=$(echo $pwd | sha256sum | tr -d "\n *-")

result=$(grep "$hash" secret.txt)


if [ "$result" = "$hash" ] 
then
	echo "Match Found!"
else
	echo "No Match Found!"
fi


