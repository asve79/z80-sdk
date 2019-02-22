#!/bin/sh

set -x
prog="WC_DEMO.WMF"

for i in $prog;do
 if [ ! -f $i ];then
  echo "no file $i found"
  exit 1
 fi
done

sudo mount -t vfat ~/zx-speccy/unreal-ts/wc.img /mnt/tmp -o loop
if [ $? -ne 0 ];then
 echo "error mount image"
 exit 1
fi
for i in $prog; do
 sudo cp $i /mnt/tmp/WC
done
sudo umount /mnt/tmp
cd ~/zx-speccy/unreal-ts
wine "Unreal.exe"
