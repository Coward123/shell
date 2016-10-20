#!/usr/bin/python
"""
versionFilePath is 'http://hpcc:CChpcc@118.126.12.141/tmp/'
fileDstPath is '/usr/local/wenping.yang/code/'
first get all version name from html;
then get the newest version name,
finally download the version file
"""
import os,re
import urllib
urlPath = 'http://hpcc:CChpcc@118.126.12.141/tmp/'
vPath = '/usr/local/wenping.yang/code/'
sPattern = "HPC-LUA-0."
endPattern = ".x86_64.rpm"
#l = os.listdir(vPath)

def comp(str1,str2):
   i = 0
   while str1[i].isdigit() and str2[i].isdigit():
      if int(str1[i]) > int(str2[i]):
         return False
      elif int(str1[i]) < int(str2[i]):
         return True
      else:
         i += 1
   if str1[i].isdigit():
      return False
   else:
      return True

def getNewVersion(fileList,startPattern,endPattern):
   pattern = r'%s(.+?)%s' %(startPattern,endPattern)
   p = re.compile(pattern,re.IGNORECASE)
   flag = False
   for item in fileList:
      m = re.match(p,item)
      if m:
         mm = re.split(r'[.|-]',m.group(1))
         if flag == False:
            flag = True
            newVersion = item
            nV = mm
         else:
            if comp(nV,mm):
               newVersion = item
               nV = mm
   return newVersion
   #g.sort(key = lambda fn: int(fn.replace('.','')) if fn.replace('.','').isdigit() else 0)

def getFileList(url):
   resp = urllib.urlopen(url).read()
   urlList = map(lambda name: re.sub("<a href=.*?>","",name.strip().replace("</a>","")), re.findall("<a href=.*?>.*?</a>",resp))
   return urlList

def getFile(url,dst):
    resp = urllib.urlopen(url).read()
    f = open(dst,'w')
    f.write(resp)
    f.close()
if __name__ == '__main__':
   urlList = getFileList(urlPath)
   filename = getNewVersion(urlList,sPattern,endPattern)
   print filename
   getFile(urlPath+filename,vPath+filename)
