#!/bin/bash
#urlfile="./urltxt"
IP=223.202.201.165
LOOP=1
CONCURRENT=10

if [ -d result ];then
    rm -rf result/*
else
    mkdir result
fi

urlfile=$1
if [ "$1" != "" ]; then
    urlfile=$1
else
    urlfile='./urltxt'
fi

url_num=`/bin/cat ${urlfile} |/usr/bin/wc -l`
flag=true
for((k=1;k<=url_num ;k++));do
    if [ $flag == "false" ];then
        break
    fi
    url=$(sed -n "${k}p" ${urlfile})
    curl -v ${url} -x ${IP}:80 -o /dev/null > ./result/tmp_${k} 2>&1 &
    currentNum=$(ps -ef|grep curl|grep -v grep|wc -l)
    #echo $k
    if [[ $currentNum -lt $CONCURRENT ]];then
        newNum=$((CONCURRENT-currentNum))
        for((j=0;j<newNum;j++));do
            k=$((k+1))
            if [ ${k} -gt ${url_num} ];then
                k=$((k%url_num))
                flag=false
            fi
            url=$(sed -n "${k}p" ${urlfile})
            curl -v ${url} -x ${IP}:80 -o /dev/null > ./result/tmp_${k} 2>&1 &
            #echo "new:$k"
        done
    fi
done
