#!/usr/bin/env python2
# Filename:0slidePage4read.py
# -- coding: utf-8 --
import os,sys,bd,cmd,time,datetime
from threading import Timer
#import schedule
import threading
import random
import json,re

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
def searchDevice():
    print('adb devcies -l')
    command = 'adb devices'
    r = os.system(command)
    os.system('adb devices -l')
    output = os.popen(command).read()
    if 'List of devices attached' in output:
        global deviceslist
        deviceslist = [device.split('\t')[0] for device in output.split('\r\n')[1:] if device != '']
        print(deviceslist)
        count = len(deviceslist)
        # printGreen(str(count))
        return count
    else :
            return 0

deviceId = '0'
def getDeviceId():
    r = searchDevice()
    if r == 0 :
        printRed('\n failed : no devices\n')
        exit(1)
    if r == 1 :
        global deviceId 
        deviceId = deviceslist[0]
    if r > 1 :
        # global deviceId
        printGreen(deviceId)
        if deviceId == '0' :
            printGreen('\n more than one device\n')
            printGreen("please selecte device by input num Index,eg 0,1,2,3\n")
            deviceIdIndexStr = input(normal(''))
            # deviceIdIndex = 1
            deviceIdIndex = int(deviceIdIndexStr)
            print(deviceIdIndex)
            # deviceId = deviceslist[deviceIdIndex]
            global deviceId
            deviceId = deviceslist[deviceIdIndex]
        # if deviceIdIndex >= r : 
        #     print('\nInstall failed : not exist this device\n')
        # else :
        #     deviceId = deviceslist[deviceIdIndex]


def swipePage() :
    getDeviceId()
    global deviceId
    cmd.system('adb -s ' + deviceId + ' shell input swipe 500 500 50 500')
    print 'adb swipe !'

def click():
    y = random.randint(0, 1280)
    x = random.randint(900, 1070)
    #x = random.randint(700, 720)
    cmd.system('adb -s ' + deviceId + ' shell input tap ' + str(x) + ' ' + str(y))
    print 'adb tap !'

print 'adb swipe !'
#s = threading.Timer(2, swipePage())
#s.start()
def getScreenSize():
    getDeviceId()
    size_str = os.popen('adb -s ' + deviceId + ' shell wm size').read()
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
    # intervalTime = random.randint(1, 5)
    # intervalTime = random.randint(8, 12)
    # intervalTime = random.randint(10, 15)
    intervalTime = random.randint(18, 20)
    print 'intervalTime = ' + str(intervalTime)
    time.sleep(intervalTime)
