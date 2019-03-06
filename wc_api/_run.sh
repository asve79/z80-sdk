#!/bin/sh

set -x
here=`pwd`
prog="WC_DEMO.WMF"
labels="demo.lab"
unreal="${HOME}/zx-speccy/unreal-ts"

for i in $prog;do
 if [ ! -f $i ];then
  echo "no file $i found"
  exit 1
 fi
done

if [ -f  ${unreal}/${labels} ]; then
 rm -f ${unreal}/${labels}
fi

if [ -f ${labels} ];then
 pwd
 cp ${labels} ${unreal}/
fi

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
if [ -f ${unreal}/${labels} ];then
 wine "Unreal.exe" "-l${labels}"
else
 wine "Unreal.exe"
fi