#!/usr/bin/env python
# coding=utf-8
import sys,os,cmd,bd

def clear(dataPath, isReboot):
	r = bd.searchDevice()
	if r == 0 :
		printRed('\nInstall failed : no devices\n')
		exit(1)
	if r > 1 :
		printRed('\nInstall failed : more than one device\n')
		exit(1)

	r = cmd.system('adb root')
	if (r != 0) :
		printRed('\ninstall failed.\n')
		exit(1);
	r = cmd.system('adb remount')
	if (r != 0) :
		printGreen('\ninstall failed.\n')
		exit(1);
	
	if('BL' in dataPath):
 	 r = cmd.system('adb shell rm -r data/data/com.android.jv.ink.launcherink')
	 if (r == 0):
             if("rb" in isReboot):
                cmd.system('adb reboot')
             else :
                cmd.system('adb shell am force-stop com.android.jv.ink.launcherink')
             bd.printGreen('\nClearData successful!\n')
	 else :
	  bd.printRed('\nClearData failed.\n')
 
paramLen = len(sys.argv)
if(paramLen > 1) :
 arg1 = sys.argv[1]
 arg2 = sys.argv[2]
 clear(arg1,arg2)

