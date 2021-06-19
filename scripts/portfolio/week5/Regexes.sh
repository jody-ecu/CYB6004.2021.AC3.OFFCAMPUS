#!/bin/bash
cd ~/student/scripts/portfolio/
echo "all sed statements"
grep -r 'sed ' 
echo "all lines that start with the letter m"
grep -r '^m'
echo "all line that contain 3 digit number"
grep -Er '\b[0-9]{3}\b' 
echo "all echo statements with at least 3 words"
grep -Er 'echo "(\w+\b.){3,}$'
echo "all lines that would make a good password"
grep -Er '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}'
