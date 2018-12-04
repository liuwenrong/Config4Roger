#!/usr/bin/env python
# Filename:ins.py
import sys,bd
paramLen = len(sys.argv)
if(paramLen > 2) :
	arg1 = sys.argv[1]
        print 'arg1 = ' + arg1
	arg2 = sys.argv[2]
        print 'arg2 = ' + arg2
	bd.install(arg1,arg2)
else :
	bd.printRed('\nERROR:You need two param. Please input apkName and assembleName, and try again.\n')
