#!/bin/bash
read -sp "enter your password: " pwd
echo $pwd | sha256sum | tr -d "\n *-" >> ./secret.txt
echo
