#!/usr/bin/env python
# Filename:stop.py
import sys,cmd

def printGreen(str) :
	print ('\033[1;32;40m ' + str)
	printNormal('')

def printRed(str) :
	print ('\033[1;31;40m ' + str)
	printNormal('')

def printNormal(str) :
	print ('\033[1;37;40m ' + str)

paramLen = len(sys.argv)
if(paramLen > 1) :
	arg1 = sys.argv[1]
        print 'arg1 = ' + arg1
        cmd.system('adb shell am force-stop '+arg1)
        printGreen('\nstop successful!\n')
else :
	bd.printRed('\nERROR:You need one param. Please input packageName, and try again.\n')
