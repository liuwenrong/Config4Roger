#!/usr/bin/python2
# coding=utf-8

def func(a, b = 5, c =0):
    print 'a is', a, 'and b is', b, 'and c is', c

func(3, 7)
func(25, c=24)
func(c=50, a=100)

def printMax(a, b):
    if a>b:
        print a, 'is max'
    else:
        print b, 'is max'

printMax(3, 4)

x = 5
y = 7
printMax(x,y)

