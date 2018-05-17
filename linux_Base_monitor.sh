#!/bin/sh
#coding=utf-8
function GetPID #User #Name
{
PsUser=$1
PsName=$2
pid=`ps -u $PsUser|grep $PsName|grep -v grep|grep -v vi|grep -v dbx|grep -v tail|grep -v start|grep -v stop|sed -n 1p|awk '{print $1}'`
echo $pid
}

function  GetPIDCpu
{
CpuValue=`ps -p $1 -o pcpu|grep -v CPU|awk -F'.' '{print $1}'`
echo $CpuValue
}

function GetPIDMem
{
MemValue=`ps -p $1 -o vsz|grep -v VSZ`
((MemValue/=1000))
echo $MemValue
}

function GetDes
{
DES=`ls /proc/$1/fd|wc -l`
echo $DES
}

function Listening
{
TCPListen=`netstat -an|grep ":$1 "|awk '$1=="tcp"&&$NF=="LISTEN"{print $0}'|wc -l`
UDPListen=`netstat -an|grep ":$1 "|awk '$1=="udp"&&$NF=="LISTEN"{print $0}'|wc -l`
((Listen=TCPListen+UDPListen))
echo $Listen
}

RunNum=`ps -ef|grep -v vi|grep -v tail|grep "$1"|grep -v grep|wc -l`

function SysCpu
{
CpuIdle=`vmstat 1 5|sed -n '3,$p'|awk '{x=x+$15}END{print x/5}'|awk -F'.' '{print $1}'`
CpuUsage=`echo "100-$CpuIdle"|bc`
echo $CpuUsage
}

function SysDisk
{
Folder="$1$"
DiskSpace=`df -k|grep $Folder|awk '{print $5}'|awk -F'%' {print $1}`
echo $DiskSpace
}

PID=`GetPID root CFTESTAPP`
if ["-$PID"=="-"]
then
{
echo "the process does not exist"
}

function CheckCpu
{
PID=$1
cpu=`GetCpu $1`
if [ $cpu -gt 80 ]
then
{
echo 'the usage of cpu is larger than 80%'
}
else{
echo 'the usage of cpu is normal'
}
}
#mem使用最多的进程号及mem使用量
msg1=`ps aux|sort -k4nr|head -1|awk '{print $2,$4}'`
##cpu使用最多的进程号及CPU使用量
msg2=`ps aux|sort -k3nr|head -1|awk '{print $2,$3}'`
