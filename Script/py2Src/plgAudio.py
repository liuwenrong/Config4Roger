#!/usr/bin/env python
# Filename:plgAudio.py

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

# if __name__ == '__main__':
# 	exeCmd('adb root')

def printGreen(str) :
	print ('\033[1;32;40m ' + str)
	printNormal('')

def printRed(str) :
	print ('\033[1;31;40m ' + str)
	printNormal('')

def printNormal(str) :
	print ('\033[1;37;40m ' + str)

def searchDevice():
	command = 'adb devices'
	r = system(command)
	output = os.popen(command).read()
	if 'List of devices attached' in output:
		deviceslist = [device.split('\t')[0] for device in output.split('\n')[1:] if device != '']
		count = len(deviceslist)
		return count
	else :
	        return 0

def install(apkName, assembleName) :
	r = system(r'rm plugin_audiobook/build/outputs/plugin/release/*')

	r = searchDevice()
	if r == 0 :
		printRed('\nInstall failed : no devices\n')
		exit(1)
	if r > 1 :
		printRed('\nInstall failed : more than one device\n')
                print r
                print 'device, continue? y/n'
                guess = raw_input('Enter y/n : ')
                if guess in 'y':
                    print 'continue'
                else:
                    exit(1)

	#cmd.exeCmdRealTime('gradlew assemble' + assembleName)
        exeCmdRealTime('gradlew.bat assemble' + assembleName)

	r = system('adb root')
	if (r != 0) :
		printRed('\ninstall failed.\n')
		exit(1);
	r = system('adb remount')
	if (r != 0) :
		printGreen('\ninstall failed.\n')
		exit(1);

	if('-debug' in apkName):
		apkNameNoDebug = apkName.replace('-debug', '')
	else :
		apkNameNoDebug = apkName
 	# r = cmd.system('adb shell rm sdcard/' + apkNameNoDebug + '/*.apk')
	reNameCmd = 'mv ./plugin_audiobook/build/outputs/plugin/release/* ./plugin_audiobook/build/outputs/plugin/release/audio.apk'
	system(reNameCmd)
	# command = 'adb push .\\plugin_audiobook\\build\\outputs\\plugin\\release\\*' + ' sdcard/' + apkNameNoDebug + '.apk'
	command = 'adb push ./plugin_audiobook/build/outputs/plugin/release/' + apkNameNoDebug + '.apk sdcard/' + apkNameNoDebug + '.apk'
	r = system(command)
	if (r == 0):
		system('adb shell am force-stop com.zhangyue.iReader.Eink')
		# system('adb shell am start -n com.zhangyue.iReader.Eink')
		printGreen('\nInstall successful!\n')
	else :
		printRed('\nInstall failed.\n')

if __name__ == '__main__' :
	install('audio', 'Plugin')

