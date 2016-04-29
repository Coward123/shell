#!/bin/bash
#
tHex="57287d41"
t=0
for i in `seq 8`;
do
t=$[t*16]
x=${tHex:$i-1:1}
case $x in
[0-9])
t=`expr $t + $x`
;;
a|A)
t=`expr $t + 10`
;;
b|B)
t=`expr $t + 11`
;;
c|C)
t=`expr $t + 12`
;;
d|D)
t=`expr $t + 13`
;;
e|E)
t=`expr $t + 14`
;;
f|F)
t=`expr $t + 15`
;;
*)
echo 'erro'
break
;;
esac
done
echo "tHex="$tHex
echo "t="$t
echo "time="`date -d @${t} "+%Y-%m-%d %H:%M:%S"`
