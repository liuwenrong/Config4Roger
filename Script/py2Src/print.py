#!/bin/python2
#coding=utf-8
# Filename: print.py
import sys
print sys.stdout.encoding ##stdout的默认编码方式
print sys.getdefaultencoding()
a='测试'
b=u'u测试'
c=r'r测试'
print a
print b
print c
print u'u测试'
#print 'encode编码utf-8'.encode('utf-8')#不可用ascii不能decode byte xx
print 'decode解码utf-8'.decode('utf-8')
d=a.decode('utf-8')
print('to utf-8 %s' %d)
