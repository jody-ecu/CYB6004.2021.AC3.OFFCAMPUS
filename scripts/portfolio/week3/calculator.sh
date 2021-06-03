# !/bin/bash
  
# Take user Input
echo "Enter Two numbers : "
read a
read b
  
# Input type of operation
echo "Enter Choice :"
echo -e "\033[31m1. Addition"
echo -e "\033[32m2. Subtraction"
echo -e "\033[34m3. Multiplication"
echo -e "\033[35m4. Division\033[30m"
read -e ch
  
# Switch Case to perform
# calulator operations
case $ch in
  1)res=`echo $a + $b | bc`
  ;;
  2)res=`echo $a - $b | bc`
  ;;
  3)res=`echo $a \* $b | bc`
  ;;
  4)res=`echo "scale=2; $a / $b" | bc`
  ;;
esac
echo "Result : $res"
