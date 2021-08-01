#!/usr/bin/env bash

python3 checker.py $2 300 &
for i in {1..2}
do
    $1 --concurrency=$(shuf -i1-15 -n1) --iterations=$(shuf -i1-2 -n1)
    sleep $(shuf -i1-4 -n1)
done &
wait -n
sleep 5
kill 0
echo done
