#!/bin/sh

prog=WC_DEMO.WMF

./_make.sh
if [ $? -eq 0 ];then
 ./_run.sh
else
 rm $prog
fi
