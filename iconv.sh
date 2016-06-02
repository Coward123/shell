#!/bin/bash
'''
将代码中的注释改变格式显示
'''
SFILE='/usr/local/wenping.yang/src'
function iconvv(){
        dir_name=` dirname $1`
        file_name=` basename $1 `
        if [ "${file_name##*.}" == "py" ]
        then
                split -b 1K $1 ${1}new
                i=0
                for j in `ls ${1}new*`
                do
                        iconv -f utf-8 -t gb2312 $j > ${1}N${i}
                        i=`expr $i + 1`
                done
                rm -rf ${1}new*
                cat ${1}N* >>${1}My
                rm -rf ${1}N* ${1}
                mv ${1}My ${1}
        fi
}
function egodic(){
        for file in `ls $1`
        do
                f=$1'/'$file
                if [ ! -d $f ]
                then
                        iconvv $f
                else
                        egodic $f
                fi
        done
}
egodic $SFILE
