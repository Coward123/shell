#!/bin/bash
#-s :save file timestamp into file
#-r ：restore the timestamp of file
# to hide your hack  operation
if [ $# -eq 0 ];then
    echo "Usage: Use a save (-s) or restore (-r) parameter."
    exit 1
fi
path=$(dirname $0)
if [ $1 = "-s" ];then
    rm -f timestamps;
    ls -l $path|sed -n 's/^.*Jan/01/p;s/^.*Feb/02/p;s/^.*Mar/03/p;s/^.*Apr/04/p;s/^.*May/05/p;s/^.*Jun/06/p;s/^.*Jul/07/p;s/^.*Aug/08/p;s/^.*Sep/09/p;s/^.*Otc/10/p;s/^.*Nov/11/p;s/^.*Dec/12/p;' >timestamps
fi

if [ $1 = "-r" ];then
    cat timestamps |while read line
    do
        MONTH=$(echo $line|cut -f1 -d\ );
        DAY=$(echo $line|cut -f2 -d\ );
        YEAR=$(echo $line|cut -f3 -d\ );
        FILENAME=$(echo $line|cut -f4 -d\ );
        CURRENTYEAR=$(cal| head -1|cut -c12-|sed 's/ //g')
        if [[ $YEAR == *:* ]];then
            touch -d  "$CURRENTYEAR-$MONTH-$DAY $YEAR:00" ${path}/$FILENAME    
        else
            touch -d "$YEAR-$MONTH-$DAY" ${path}/$FILENAME
        fi
    done
fi
