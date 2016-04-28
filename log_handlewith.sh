#!/bin/bash
#shell：cat ./access.log|gawk '{print $4}'|sort|uniq -c|sort -nr
#log_format
#192.168.152.117 - - [26/Apr/2016:06:40:42 -0700] "GET http://jiandan.com/50x.html HTTP/1.1" 200 537 "-" "curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.14.0.0 zlib/1.2.3 libidn/1.18 libssh2/1.4.2" "-"
#

if [-z $1] ;then
log=/usr/local/nginx/logs/access.log
else
log=$1
fi

if [ ! -f $log ];then
echo 'file not exits......'
exit(1)
fi

if[ -z $file ];then
echo 'file is zero......'
exit(1)
fi

awk '
{
if ( $9 ~ /200/){
  ok_num++;
  bit_num += $10
}
END{
print "ok_num",ok_num;
print "bit_num",bit_num;
}
' $log
exit(0)
