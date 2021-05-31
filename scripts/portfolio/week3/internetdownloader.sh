#!/bin/bash
while [ "$reply" != "exit" ]
do
  read -p "Please type the URL of a file to download or 'exit' to quit: " reply
  if  [ "$reply" != "exit" ]; then
    read -p "Type the location where you would like to save the file: " location
    wget -P "$location" "$reply"
  fi
done
