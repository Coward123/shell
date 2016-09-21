#!/usr/bin/python
#http://www.testwp.com/bt_hls/CCTV7/index.m3u8?AuthInfo=%2bJdDiwzbrGYhhOY9yb7eqXaqnzavcs7kojkBmYYqM3Te5GuZ%2bxNRqITvMF2BoZOr&version=key1&fileID=1265
# "%2bJdDiwzbrGYhhOY9yb7eqXaqnzavcs7kojkBmYYqM3Te5GuZ%2bxNRqITvMF2BoZOr"
#urldecode后“+JdDiwzbrGYhhOY9yb7eqXaqnzavcs7kojkBmYYqM3Te5GuZ+xNRqITvMF2BoZOr”
#base64 decrypt后“f897438b0cdbac662184e63dc9bedea976aa9f36af72cee4a2390199862a3374dee46b99fb1351a884ef305d81a193ab”
#aes-128-ecb pcsk7解密后“31363737373230302b6fc821c32b43435456372b35376531636266382b6a045620202956d2cc86df7ad8cb937b030303af284f93207f64048c46a40c0dce4b38”
#然后解出stdID、IP、contentID、timesstamp、MD5
import sys,re
import socket,struct
import base64
from Crypto.Cipher import AES
from urllib import unquote
def deCrypt():
        aesPrivateKey = "73836305993891"
        bBs64Str = unquote(sys.argv[1])
        print bBs64Str
        aB64Str = base64.b64decode(bBs64Str)
        print aB64Str.encode('hex')

        BS = AES.block_size
        mode = AES.MODE_ECB
        padKey = lambda s : s + (BS - len(s) % BS) * "0"
        encryptor = AES.new(padKey(aesPrivateKey), mode)
        pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
        unpad = lambda s : s + (BS - len(s) % BS) * chr(0)
        afterPadAESStr = encryptor.decrypt(pad(aB64Str)).encode('hex')
        afterNoPadAESStr = encryptor.decrypt(unpad(aB64Str))
        print afterPadAESStr

        try:
                index = afterPadAESStr.find('2b')
                stbID = afterPadAESStr[:index].decode('hex')
                print "stbID="+stbID
                if (len(sys.argv)>2) and (sys.argv[2] == "6"):
                        ipStr = afterPadAESStr[index+2:index+34]
                        ip = ':'.join(re.findall(r'(.{4})',ipStr))
                        print "IPv6="+ip
                        aesStr1 = afterPadAESStr[index+36:]
                else:
                        ipStr = afterPadAESStr[index+2:index+10]
                        ipList = re.findall(r'(.{2})',ipStr)
                        iip = []
                        for k in ipList:
                                iip.append(str(int(k,16)))
                        ip = '.'.join(iip)
                        print "IP="+ip
                        aesStr1 = afterPadAESStr[index+12:]
                #print aesStr1
                index1 = aesStr1.find('2b')
                conID = aesStr1[:index1]
                print "contentID="+conID.decode('hex')
                print "timestamp="+aesStr1[index1+2:index1+18]
                print "md5="+aesStr1[index1+20:index1+52]
        except:
                print "Error aesPrivateKey!!"
                sys.exit()
if __name__ == "__main__":
        deCrypt()

