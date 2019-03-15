#!/bin/sh

set -x
here=`pwd`
prog="demo-ts-conf.sna"
labels="demo-ts-conf.lab"
unreal_path="zx-speccy/unreal-ts"
unreal="${HOME}/${unreal_path}"

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

if [ ! -f ${unreal}/${prog} ];then
 ln -s ${here}/${prog} ${unreal}/${prog}
fi

#sudo mount -t vfat ~/zx-speccy/unreal-ts/wc.img /mnt/tmp -o loop
#if [ $? -ne 0 ];then
# echo "error mount image"
# exit 1
#fi
#for i in $prog; do
# sudo cp $i /mnt/tmp/WC
#done
#sudo umount /mnt/tmp
cd ~/${unreal_path}
if [ -f ${unreal}/${labels} ];then
 wine "Unreal.exe" "-l${labels}" "${prog}"
else
 wine "Unreal.exe" "${prog}"
fi