#!/usr/bin/env python
# Filename:plgAudio.py

import subprocess, os, sys, shutil
from subprocess import Popen, PIPE, STDOUT

def system(command):
    printNormal('*****start*****' + command)
    r = os.system(command)
    printNormal('*****end*****' + '\n')
    return r


# if __name__ == '__main__':
# 	exeCmd('adb root')

def printGreen(str):
    print ('\033[1;32;40m ' + str)
    printNormal('')

def Green(string) :
    return ('\033[1;32;40m ' + str(string))

def green(string):
    return ('\033[1;32;40m ' + str(string))


def printRed(str):
    print ('\033[1;31;40m ' + str)
    printNormal('')


def printNormal(str):
    print ('\033[1;37;40m ' + str)


def isWindows():
    if 'win32' in sys.platform:
        return True
    else:
        return False


def searchDevice():
    command = 'adb devices'
    r = system(command)
    output = os.popen(command).read()
    if 'List of devices attached' in output:
        deviceslist = [device.split('\t')[0] for device in output.split('\n')[1:] if device != '']
        count = len(deviceslist)
        return count
    else:
        return 0

def check_git(path):
    os.chdir(path)
    output = os.popen('git pull --rebase').read()
    if 'up to date' in output:
        return 0
    return 1


def exit_with_msg(msg):
    printRed('\nPackage failed : ' + msg + '\n')
    exit(1)


def package(main_path, plugin_root_list, plugin_apk_list):

    # check devices
    printGreen('check devices')
    r = searchDevice()
    if r == 0:
        exit_with_msg('no devices!')
    if r > 1:
        exit_with_msg('more than one device!')


    if not ignore_repo:
        # check git
        # check the main app git repo
        printGreen('start check the git repo')
        r = check_git('.')
        print 'main project git check result : ' + str(r)
        error_tip = '\n\nYou can try \"package.py -ignorerepo\" to ignore git repo check.'
        if r != 0:
            exit_with_msg('please check main project git repo first!' + error_tip)
        # check the plugin git repo
        for plugin_path in plugin_root_list:
            r = check_git(plugin_path)
            print  plugin_path + ' git check result : ' + str(r)
            if r != 0:
                exit_with_msg('please check ' + plugin_path +' git repo first!' + error_tip)
        os.chdir(main_path)

    if isRelease():
        buildCommand = 'transformClassesWithShrinkResFor' + flavorName + buildType + ' --stacktrace'
    else:
        buildCommand = 'assemble' + flavorName + buildType + ' --stacktrace'

    if isWindows():
        printGreen('\n=====================command:gradlew clean ' + buildCommand + ' \n')
        r = system('gradlew clean ' + buildCommand)
    else:
        printGreen('\n=====================command:./gradlew clean ' + buildCommand + ' \n')
        r = system('./gradlew clean ' + buildCommand)
    if r != 0:
        exit_with_msg('build error')

    if isRelease():
        printGreen('\n=====================command:copy file:' + ' \n')
        copyfile('./EReader/build/outputs/mapping/' + flavorName + '/release/mapping.txt', './EReader/libs_mapping/mapping.txt')

    # generate the EReader.jar
    printGreen('start generate the EReader.jar')
    if isWindows():
        r = system('gradlew :EReader:buildEReaderSdkJar' + ' --stacktrace')
    else:
        r = system('./gradlew :EReader:buildEReaderSdkJar' + ' --stacktrace')

    if r != 0:
        exit_with_msg('check EReader jar first!')

    # clear the assets
    printGreen('rm plugins')
    system('rm ./EReader/src/main/assets/plugins/*')
    system('rm ./EReader/src/r608/assets/plugins/*')

    # build plugin
    for plugin_path in plugin_root_list:
        printGreen('start build plugin : ' + plugin_path)
        if plugin_path == '../plugin_audiobook':
            os.chdir(plugin_path)
            r = system('python ' + plugin_path + '/make.py -fr608 -' + buildType)
        else:
            os.chdir(plugin_path)
            r = system('python ' + plugin_path + '/make.py -' + buildType)

        if r != 0:
            exit_with_msg(plugin_path)

    # mv the plugin to assets
    printGreen('start move the plugin to main project')
    os.chdir(main_path)
    for plugin_apk in plugin_apk_list:
        r = system('mv ' + plugin_apk + ' ./EReader/src/r608/assets/plugins/')
        if r != 0:
            exit_with_msg(plugin_apk)

    # build the main apk
    if isRelease():
        printGreen('\nrelease build successful! \n')
    else:
        printGreen('start build the main apk')
        if isWindows():
            printGreen('\n=====================command:gradlew ' + buildCommand + ' \n')
            r = system('gradlew ' + buildCommand)
        else:
            printGreen('\n=====================command:gradlew ' + buildCommand + ' \n')
            r = system('./gradlew ' + buildCommand)
        if r != 0:
            exit_with_msg('main apk assemble failed !')

        printGreen('\npackage successful! \n')


def isRelease():
    if 'release' == buildType.lower():
        return True
    else:
        return False

def copyfile(srcfile,dstfile):
    if not os.path.isfile(srcfile):
        print "%s not exist!"%(srcfile)
    else:
        fpath,fname=os.path.split(dstfile)    #split path and name
        if not os.path.exists(fpath):
            os.makedirs(fpath)                #mkdir
        shutil.copyfile(srcfile,dstfile)      #copy
        print "copy %s -> %s"%( srcfile,dstfile)

def getArgs() :
    param_len = len(sys.argv)

    if param_len == 1:
        printNormal('tips: \n -ignorerepo : ignore the repo check')
        printNormal('-fr608 : r608 is a flavor name; -f means this param is a flavor')
        printNormal('-debug: debug or release')


    global buildType
    global flavorName
    global ignore_repo
    ignore_repo = False
    buildType = ''
    flavorName = ''
    for arg in sys.argv:
        if '-' in arg:
            # check repo param
            if '-ignorerepo' == arg:
                ignore_repo = True
                continue
            # flavor param
            if '-f' in arg:
                flavorName = arg.replace('-f', '')
            # buildType param
            if '-debug' == arg:
                buildType = arg.replace('-', '')
            if '-release' == arg:
                buildType = arg.replace('-', '')

    if '' == flavorName:
        name = raw_input(Green("\n Please input flavor name: \n"))
        flavorName = name

    if '' == buildType:
        type_index = input(Green("\n Please input build type: \n debug or release? \n type 0 for debug, or 1 for release. \n"))
        if type_index == 0:
            buildType = 'Debug'
        if type_index == 1:
            buildType = 'Release'

    printGreen('\n=====================build type:' + buildType + '     flavorName:' + flavorName + ' \n')



if __name__ == '__main__':

    main_path = '../ireader'

    pluginAudioPath = '../plugin_audiobook'
    pluginMediaControlPath = '../plugin_mediacontrol'
    pluginMusicPath = '../plugin_musicplayer'
    plugin_root_list = [pluginAudioPath, pluginMediaControlPath, pluginMusicPath]

    plugin_audio_apk_path = pluginAudioPath + '/app/build/outputs/plugin/r608Release/plugin_audiobook.apk'
    plugin_media_control_apk_path = pluginMediaControlPath + '/app/build/outputs/plugin/release/plugin_mediacontrol.apk'
    plugin_music_apk_path = pluginMusicPath + '/app/build/outputs/plugin/release/plugin_music.apk'
    plugin_apk_list = [plugin_audio_apk_path, plugin_media_control_apk_path, plugin_music_apk_path]

    getArgs()
    package(main_path, plugin_root_list, plugin_apk_list)
