#!/bin/bash
now=`date +%s`
#now=`date --day='+1 day' +%s`
tHex=''
t=$now
while (( $t > 0))
do
x=$(($t%16))
case $x in
[0-9])
tHex=${x}${tHex}
;;
10)
tHex='a'${tHex}
;;
11)
tHex='b'${tHex}
;;
12)
tHex='c'${tHex}
;;
13)
tHex='d'${tHex}
;;
14)
tHex='e'${tHex}
;;
15)
tHex='f'${tHex}
;;
*)
echo 'erro'
break
;;
esac
t=$(($t/16))
done
echo "now=$now"
echo "tHex="$tHex
