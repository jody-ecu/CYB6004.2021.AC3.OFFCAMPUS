#!/bin/bash

./passwordCheck.sh

if [ $? -eq 0 ]
then
	echo "1. Create Folder"
	echo "2. Copy Folder"
	echo "3. Create Password"
else
	echo "Goodbye"
	exit 1
fi

read $REPLY

case $REPLY in

1)  ./foldermaker.sh
    ;;
2)  ./foldercopier.sh
    ;;
3)  ./setPassword.sh
    ;;
*) echo "Invalid Selection"
   ;;
esac
