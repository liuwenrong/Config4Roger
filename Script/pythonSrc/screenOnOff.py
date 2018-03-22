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

cmd.system('adb shell input keyevent 26')
printGreen('\nscreenOn or screenOff successful!\n')
