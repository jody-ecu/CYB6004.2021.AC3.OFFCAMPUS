#!/bin/bash
echo -e -n "\033[31m"
../week2/passwordCheck.sh
if [ $? -eq 1 ]
then
	echo "Goodbye"
	exit 1
fi
reply=""
return=0
while [ "$reply" != "exit" ] 
do
	if [ $return -eq 0 ]
	then
		echo -e "\033[34mSelect an Option:\033[36m"
		echo " 1. Create a Folder"
		echo " 2. Copy a Folder"
		echo " 3. Set a Password"
		echo " 4. Calculator"
		echo " 5. Create Week Folders"
		echo " 6. Check Filenames"
		echo " 7. Download a File"
		echo -e "\033[30m 8. Exit"
	else
		echo "Goodbye"
		exit 1
	fi

	read -p "" reply

	case $reply in

	1)  ./foldermaker.sh
		return=$?
		;;
	2)  ./foldercopier.sh
		return=$?
		;;
	3)  ./setPassword.sh
		return=$?
		;;
	4)  ./calculator.sh
		return=$?
		;;
	5)   read -p "enter week numbers" from to
		./megafoldermaker.sh $from $to
		return=$?
		;;
	6)  ./filenames.sh ./filenames.txt
		return=$?
		;;
	7)  ./internetdownloader.sh
		return=$?
		;;
	8)  exit 0
	    ;;
	*) echo "Invalid Selection"
	;;
	esac
done
