#!/usr/bin/python
#statistic the files in the path,and write it in source.txt
import os,string
sfile=r'/usr/local/penny/source.txt'
path=r'/usr/local/penny/build/simplejson-3.8.2/'
def ifFileExit(filename):
        if os.path.exists(filename):
                return True
        else:
                return False
def wFile(path):
        f=open(sfile,'w')
        l=len(path)
        for root,dirs,files in os.walk(path):
                for fn in files:
                        r=root[l:]
                        if not r:
                                f.write(str(r)+str(fn)+'\n')
                        else:
                                f.write(str(r)+'/'+str(fn)+'\n')
        f.close()
wFile(path)
