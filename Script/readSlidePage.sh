#!/bin/zsh
while : ;do
    #ls -la
    adb shell input swipe 500 500 50 500
    echo "adb 滑动"
    x=$(($RANDOM%30))
    y=5
    echo $x
    #if[$x < $y]
        #x=11
    if (($x < $y)) {
        x=11
    }
    echo $x
 sleep 15
done
