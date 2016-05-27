#!/usr/bin/python
#实现以下PHP代码
#$hash = hash('sha256', $hashstr ,1);
#$usableHash=strtr(base64_encode($hash), '+/', '-_');

import hashlib
import os,sys
import base64
import string
class Encode:
    def hhash(self,method,str,F):
        if cmp('Sha256',method) == 0:
            mm=hashlib.sha256()
        elif cmp('MD5',method)==0:
            mm=hashlib.md5()
        elif cmp('Sha1',method):
            mm=hashlib.sha1()
        else:
            mm=hashlib.sha256()
        mm.update(str)
        if bool(F):
            return mm.digest()
        else:
            return mm.hexdigest()
    def unicom(self,str):
        mm=hashlib.sha256()
        mm.update(str)
        hashstr = mm.digest()
        hash = base64.b64encode(hashstr)
        return hash.replace("+","-").replace("/","_")
if __name__=="__main__":
    hashstr = sys.argv[1]
    e=Encode()
    print e.unicom(hashstr)
    print e.hhash("Sha256",hashstr,0)
