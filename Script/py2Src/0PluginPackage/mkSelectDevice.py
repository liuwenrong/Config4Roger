#!/usr/bin/env python
# Filename:plgAudio.py

import subprocess,os,sys
from subprocess import Popen, PIPE, STDOUT
def exeCmdRealTime(command):
	printNormal ('*****start*****' + command)
	p = subprocess.Popen(command, stdout=subprocess.PIPE)
	while p.poll() is None: 
		l = p.stdout.readline()     
		l = l.strip('\r\n')
		print (l)
	#print p.stdout.read()
	printNormal ('*****end*****' + '\n')
def popen(command):
	printNormal ('*****start*****' + command)
	r = os.popen(command)	
	info = r.readlines()
	for line in info:
		line = line.strip('\r\n')
		print (line)
	printNormal ('*****end*****' + '\n')
def system(command):
	printNormal ('*****start*****' + command)
	r = os.system(command)
	printNormal ('*****end*****' + '\n')
	return r

# if __name__ == '__main__':
# 	exeCmd('adb root')

def printGreen(str) :
	print ('\033[1;32;40m ' + str)
	printNormal('')

def Green(string) :
	return ('\033[1;32;40m ' + str(string))

def normal(string) :
	return('\033[1;37;40m ' + str(string))

def printRed(str) :
	print ('\033[1;31;40m ' + str)
	printNormal('')

def printNormal(str) :
	print ('\033[1;37;40m ' + str)

def isWindows() :
	if 'win32' in sys.platform :
		return True
	else :
		return False
deviceslist = []
deviceId = '0';
def searchDevice():
	command = 'adb devices'
	r = system(command)
	system('adb devices -l')
	output = os.popen(command).read()
	if 'List of devices attached' in output:
		global deviceslist
# List of devices attached
# 0f1381d4ea9e6bb1        device
# e0cf8bb9        device
# 
		deviceslist = [device.split('\t')[0] for device in output.split('\n')[1:] if device != '']
		# ['0f1381d4ea9e6bb1', 'e0cf8bb9', '\r']
		printGreen(str(deviceslist))
		count = len(deviceslist)
		return count
	else :
	        return 0

def install(apkName, assembleName) :
	r = system(r'rm -r app/build/outputs/plugin/')
	global deviceId
	r = searchDevice()
	if r == 0 :
		printRed('\nInstall failed : no devices\n')
		exit(1)
	if r == 1 :
		deviceId = deviceslist[0]
	if r > 1 :
		printGreen('\n more than one device\n')
		printGreen("please selecte device by input num Index,eg 0,1,2,3\n")
		deviceIdIndex = input(normal("\n"))
		deviceId = deviceslist[deviceIdIndex]
		# if deviceIdIndex >= r : 
		# 	printRed('\nInstall failed : not exist this device\n')
		
		# else :

		# exit(1)

	gradleCommand = './gradlew'
	if isWindows() :
		gradleCommand = 'gradlew'

	system(gradleCommand + ' clean assemble' + flavorNameUpperCase + assembleName)

 	# r = cmd.system('adb shell rm sdcard/' + apkNameNoDebug + '/*.apk')

	reNameCmd = 'mv ./app/build/outputs/plugin/' + flavorName + 'release/* ./app/build/outputs/plugin/' + flavorName + 'Release/'+ apkName +'.apk'
	system(reNameCmd)
	command = 'adb shell rm -f /data/data/com.zhangyue.iReader.Eink/plugins/apks/' + apkName + '.apk'
	r = system(command)
	# command = 'adb push .\\plugin_audiobook\\build\\outputs\\plugin\\release\\*' + ' sdcard/' + apkNameNoDebug + '.apk'
	command = 'adb -s ' + deviceId + ' push ./app/build/outputs/plugin/' + flavorName + 'release/' + apkName + '.apk /data/data/com.zhangyue.iReader.Eink/plugins/apks/' + apkName + '.apk'
	r = system(command)
	
	if (r == 0):
		system('adb -s ' + deviceId + ' shell am force-stop com.zhangyue.iReader.Eink')
		system('adb -s ' + deviceId + ' shell am start com.zhangyue.iReader.Eink')
		printGreen('\nInstall successful!\n')
	else :
		printRed('\nInstall failed.\n')

def getFlavorName() :
	paramLen = len(sys.argv)
	if(paramLen > 1) : # input with flavorName eg : make.py r608
 		flavorName = sys.argv[1]
 		flavorNameUpperCase = flavorName.upper()
 	else :
 		printNormal(" You maybe want this ?")
 		printGreen("make.py r608")
 		printNormal("or")
 		printGreen("make.py r1001")
 		printNormal("or")
 		printGreen("\n You maybe want this? \n r1001 or r608? \n type 0 for r1001, or 1 for 608. \n")

		flavorIndex = input(normal(""))
		if(flavorIndex == 0) :
			flavorName = 'r1001' 
			flavorNameUpperCase = 'R1001'
		if(flavorIndex == 1) :
			flavorName = 'r608'
			flavorNameUpperCase = 'R608'

if __name__ == '__main__' :
	global flavorName
	global flavorNameUpperCase
	flavorName = ''
	flavorNameUpperCase = ''
	# getFlavorName()
	printNormal(flavorName + "  upperCase : " + flavorNameUpperCase)
	install('plugin_music', 'Plugin')

