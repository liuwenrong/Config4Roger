#!/usr/bin/env python
# Filename:plgAudio.py

import subprocess, os, sys
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


def green(string):
    return ('\033[1;32;40m ' + str(string))


def printRed(str):
    print ('\033[1;31;40m ' + str)
    printNormal('')


def printNormal(str):
    print ('\033[1;37;40m ' + str)

def check_git(path):
    os.chdir(path)
    output = os.popen('git pull --rebase').read()
    if 'up to date' in output:
        return 0
    return 1


def exit_with_msg(msg):
    printRed('\nPackage failed : ' + msg + '\n')
    exit(1)


def pull(main_path, plugin_root_list, plugin_apk_list):

    # check git
    # check the main app git repo
    printGreen('start check the git repo')
    r = check_git('.')
    print 'main project git check result : ' + str(r)
    if r != 0:
        printRed('main project git repo is not clear!')
    # check the plugin git repo
    for plugin_path in plugin_root_list:
        r = check_git(plugin_path)
        print  plugin_path + ' git check result : ' + str(r)
        if r != 0:
            printRed('' + plugin_path +' git repo is not clear!')


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

    pull(main_path, plugin_root_list, plugin_apk_list)
