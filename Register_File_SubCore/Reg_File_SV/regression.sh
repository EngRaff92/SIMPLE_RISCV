#!/bin/bash 
echo "Running Regression"
make compile
for i in $(seq 0 4)
do
    vvp vvpo +s=$i
done
echo "Regression End"