#!/bin/sh

#set -x

prog="demo-ts-conf"
#frompage=02
#topage=61

for i in ${prog}.asm; do
 sjasmplus --labels $i
done

if [ -f ${prog}.lab ];then
# sed -i "s/${frompage}:/${topage}:/g" ${prog}.lab
 sed -i "s/main\./m\./g" ${prog}.lab
 sed -i "s/zifi\./z\./g" ${prog}.lab
 sed -i "s/string\./s\./g" ${prog}.lab
 sed -i "s/uart_ts_zifi\./utz\./g" ${prog}.lab 
fi