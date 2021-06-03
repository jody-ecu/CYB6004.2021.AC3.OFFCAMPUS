#!/bin/bash
read -sp "Enter Password: " pwd
hash=$(echo $pwd | sha256sum)

result=$(grep "$hash" secret.txt)


if [ "$result" = "$hash" ] 
then
	echo -e "\n\033[32mAccess Granted"
	exit 0
else
	echo -e "\nAccess Denied"
	exit 1
fi



