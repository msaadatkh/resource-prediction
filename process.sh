#!/usr/bin/env bash

python3 checker.py $2 300 &
for i in {1..3}
do
    $1 -t $(shuf -i2-4 -n1) -c $(shuf -i10-80 -n1) -n $(shuf -i1000-10000 -n1)
    sleep $(shuf -i1-4 -n1)
done &
wait -n
sleep 5
kill 0
echo done
