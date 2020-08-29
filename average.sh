#!/bin/bash

# I have found the on internet - https://www.log2base2.com/shell-script-examples/loop/shell-program-to-find-average-of-n-numbers.html

echo "Enter Size(N)"
read N

i=0
sum=0

echo "Enter Numbers"
while [ $i -lt $N ]
do
  read num               #get number
  sum=$((sum + num))     #sum+=num
  i=$((i + 1))
done

avg=$(echo $sum / $N | bc -l)

printf "%0.1f\n" $avg