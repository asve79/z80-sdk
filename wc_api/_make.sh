#!/bin/sh

prog="demo.asm"

for i in $prog; do
 sjasmplus $i
done
