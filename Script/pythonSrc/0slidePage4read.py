#!/usr/bin/env python2
# Filename:0slidePage4read.py
# -- coding: utf-8 --
import os,sys,bd,cmd,time,datetime
from threading import Timer
#import schedule
import threading
import random
import json,re

def swipePage() :
    cmd.system('adb shell input swipe 500 500 50 500')
    print 'adb swipe !'

def click():
    y = random.randint(0, 1280)
    x = random.randint(900, 1070)
    #x = random.randint(700, 720)
    cmd.system('adb shell input tap ' + str(x) + ' ' + str(y))
    print 'adb tap !'

print 'adb swipe !'
#s = threading.Timer(2, swipePage())
#s.start()
def getScreenSize():
    size_str = os.popen('adb shell wm size').read()
    if not size_str:
        sys.exit()
    m = re.search(r'(\d+)x(\d+)', size_str)
    if m:
        screenSize = "{height}x{width}".format(height=m.group(2), width=m.group(1))
        print 'height = ' + m.group(2)
        return screenSize
    return "1920x1080"

print getScreenSize()

time.sleep(2)
#schedule.every(2).seconds.do(swipePage())

#Timer(2, swipePage()).start()
while True:
    if (random.randint(0,1) == 0):
        swipePage()
    else:
        swipePage()
        #click()
    intervalTime = random.randint(1, 5)
    print 'intervalTime = ' + str(intervalTime)
    time.sleep(intervalTime)

