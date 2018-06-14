#!/bin/bash
pidpath=main.pid
function checkPid()
{
    if [ -f "${pidpath}" ];then
        n=$(ps -ef|grep `cat ${pidpath}`|grep main.sh|wc -l)
        if [ "${n}" -ne 0 ];then
            kill -9 $(cat $pidpath) 
        fi
        rm -f $pidpath
    fi
    #echo $$
    echo $$ > $pidpath
    sleep 1
}
function setUp()
{
    if [ -d result ];then
        rm -rf result/*
    else
        mkdir result
    fi
   
    if [ -d log ];then
        echo ""> log/error.log
    else
        mkdir log
    fi
}
function tearDown()
{
    rm -f $pidpath
}
checkPid
setUp
/bin/sh urlGet.sh urllist &
wait 
/bin/sh checkResponse.sh TCP_HIT 

tearDown
