#!/usr/bin/python
import os,sys
base = [str(x) for x in range(2)]
print base
def dec2bin(string_num):
    num = int(string_num)
    mid = []
    while True:
        if num == 0: break
        num,rem = divmod(num, 2)
        mid.append(base[rem])
    l=len(mid)
    if l!=8:
        for i in range(l,8):
            mid.append("0")
    return ''.join([str(x) for x in mid[::-1]])
def ip2bin(ip):
    decip=''
    list=ip.split(".")
    for item in list:
        decip=decip+dec2bin(item)
    return decip
print ip2bin("59.52.24.231")
