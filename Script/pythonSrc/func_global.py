#!/usr/bin/env python
# coding=utf-8

def func():
    global x
    print 'x is', x
    x = 2
    print 'Changed local x to', x

x = 50
func()
print 'Value of x is', x
