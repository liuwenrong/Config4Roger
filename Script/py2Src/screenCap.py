#!/usr/bin/env python
# Filename:screenCap.py
import sys,cmd,datetime,time

#fileName = time.mktime(datetime.datetime.now().timetuple())
fileName = time.strftime('%Y%m%d%H%M%S',time.localtime(time.time()))
print fileName
paramLen = len(sys.argv)
if(paramLen > 1) :
	arg1 = sys.argv[1]
        print 'arg1 = ' + arg1
        fileName = arg1
print 'fileName = ' + fileName
r = cmd.system('adb shell system/bin/screencap -p sdcard/' + fileName + '.png')
if (r == 0) :
    print 'screenCap success!'
    # from sdcard to  E:\0Pic\0screenCap
    pullPath = 'D:/0Pic/0screenCap/'
    r = cmd.system('adb pull sdcard/' + fileName + '.png ' + pullPath)
    if (r == 0) :
        print 'pull success!'
    else :
        print 'pull fail !'
else :
    print 'screenCap fail'
