#!/usr/bin/env python
# Filename:cmd.py
import subprocess,os
from subprocess import Popen, PIPE, STDOUT
def exeCmdRealTime(command):
	print '*****start*****' + command
	p = subprocess.Popen(command, stdout=subprocess.PIPE)
	while p.poll() is None: 
		l = p.stdout.readline()     
		l = l.strip('\r\n')
		print l
	#print p.stdout.read()
	print '*****end*****' + command + '\n'
def popen(command):
	print '*****start*****' + command
	r = os.popen(command)	
	info = r.readlines()
	for line in info:
		line = line.strip('\r\n')
		print line
	print '*****end*****' + command + '\n'
def system(command):
	print '*****start*****' + command
	r = os.system(command)
	print '*****end*****' + command + '\n'
	return r
if __name__ == '__main__':
	exeCmd('adb root')
