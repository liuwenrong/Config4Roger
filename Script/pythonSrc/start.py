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
	arg2 = sys.argv[2]
        print 'arg2 = ' + arg2
        cmd.system('adb shell am start -n '+ arg1 + '/' + arg2)
        printGreen('\nstart successful!\n')
else :
	bd.printRed('\nERROR:You need two param. Please input packageName and className, and try again.\n')
