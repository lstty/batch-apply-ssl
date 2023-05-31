#!/bin/bash

while true
do
c=`ps aux | grep acme.sh | grep -v grep | wc -l`
echo "当前运行中的进程数 $c"

s=`grep -l "Cert success" *.log | wc -l`
echo "已成功数 $s"
sleep 1
done