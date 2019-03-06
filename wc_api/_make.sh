#!/bin/sh

#set -x

prog="demo"
frompage=02
topage=61

for i in ${prog}.asm; do
 sjasmplus --labels $i
done

if [ -f ${prog}.lab ];then
 sed -i "s/${frompage}:/${topage}:/g" ${prog}.lab
fi