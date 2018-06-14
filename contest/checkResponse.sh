#!/bin/bash
#echo "">./result/error.log
key="CC_CACHE"
#value="TCP_MISS"
value=$1
if [ "$1" != "" ];then
    value=$1
else
    value="TCP_MISS"
fi
for k in result/tmp_*;
do
    args=$(sed -n "/${key}/p" ${k}|cut -f2 -d\:|tr -d '\n'|tr -d '[ \r]')
    if [ "${args}" != "${value}" ];then
        url=$(sed -n "/GET/p" ${k}|cut -f3 -d' ')
        #echo  "${url}; check key:${key}; value:${value}; in fact:${args}" >> ./result/error.log
        echo  "$(date +%s);${k};${url}; check key:${key}; value:${value}; in fact:${args}">> log/error.log 2>&1
    fi
done
