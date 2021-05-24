#!/bin/bash
read -sp "enter your password: " pwd
echo $pwd | sha256sum >> ./secret.txt
echo
