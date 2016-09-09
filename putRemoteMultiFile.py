#!/usr/bin/python
import paramiko
import os
import pdb
def connect(host,uname,passwd):
        #ssh=paramiko.SSHClient()
        #ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        #try:
        #       ssh.connect(host,port,username=uname,password=passwd)
        #       #return ssh
        #except:
        #       return None
        #ftp=ssh.open_sftp()
        t=paramiko.Transport(host,22)
        t.connect(username=uname,password=passwd)
        ftp=paramiko.SFTPClient.from_transport(t)
        return ftp
def putMultiFile(conn,pathFile):
        for k in pathFile:
                path,file=os.path.split(k)
                try:
                        #conn.chdir(path)
                        conn.stat(path)
                except IOError:
                        #print("%s Not Exit;;;;;;;;;;;;;;;;;" %path)
                        conn.mkdir(path)
                conn.put(k,k)
                print("put %s OK!!!!!!!!!!" % k)
        conn.close()
def getPathFile(localpath):
        pathFile=[]
        if os.path.isfile(localpath):
                pathFile.append(localpath)
        elif os.path.isdir(localpath):
                for rts,dirs,files in os.walk(localpath):
                        for f in files:
                                pathFile.append(rts+'/'+f)
        return pathFile

def main(host,uname,passwd,localpath):
        conn=connect(host,uname,passwd)
        pathFile=getPathFile(localpath)
        putMultiFile(conn,pathFile)

if __name__=='__main__':
        main('192.168.1.109','root','hpcc123<>','/usr/local/penny/code')
