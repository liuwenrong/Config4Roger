#!/usr/bin/env python
# coding=utf-8

def say(msg, times = 1):
    print msg * times

say('Hello')
say('World ', 5)

def func(x):
    print 'x is', x
    x = 2
    print 'Changed local x to', x

x = 50
func(x)
print 'x is still', x
