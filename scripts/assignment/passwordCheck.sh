#!/bin/bash
read -sp "Enter Password: " pwd
hash=$(echo $pwd | sha256sum)

result=$(grep "$hash" secret.txt)


if [ "$result" = "$hash" ] 
then
	echo "Access Granted"
	exit 0
else
	echo "Access Denied"
	exit 1
fi



