#!/usr/bin/python2
# vim: set fileencoding=utf-8 :
    # -*- coding: utf-8 -*-
    # coding=utf-8
import sys, bd

#tuple 元组
age = 25
name = 'Roger'
print 'hello Roger'
print '%s is %d years old' % (name, age)
print 'Why is %s playing with that python?' %name

zoo = ('wolf', 'elephant', 'penguin')
print 'Number of animals in the zoo is', len(zoo)

new_zoo = ('monkey', 'dolphin', zoo)
print 'Number of animals in the new zoo is', len(new_zoo)
print 'All animals in new zoo are', new_zoo
print 'Animals brought from old zoo are', new_zoo[2]
print 'Last animal brought from old zoo is', new_zoo[2][2]

# This is my shopping list 列表
shoplist = ['apple', 'mango', 'carrot', 'banana']

print 'I have', len(shoplist), 'items to purchase.'

print 'These items are:', # Notice the comma at end of the line
for item in shoplist:
    print item,

print '\nI also have to buy rice.'
shoplist.append('rice')
print 'My shopping list is now', shoplist

print 'I will sort my list now'
shoplist.sort()
print 'Sorted shopping list is', shoplist

print 'The first item I will buy is', shoplist[0]
olditem = shoplist[0]
del shoplist[0]
print 'I bought the', olditem
print 'My shopping list is now', shoplist

#dir(sys)

print 'The command line arguments are:'
for i in sys.argv:
    print i

print '\n\nThe PYTHONPATH is', sys.path, '\n'

sys.__name__
bd.printGreen("hello")


def pMax(x,y):
    '''Prints the maximum of two mum ers.

    The two values must be integers.'''
    x = int(x) # convert to integers, if possible
    y = int(y)

    if x > y:
        print x, 'is maximum'


#print 'hello'
#print 'world'
#pMax(9,5)
#print pMax.__doc__

def maximum(x, y):
    if x>y:
        return x
    else:
        return y

print maximum(2,3)


number = 23
guess = int(raw_input('Enter an integer : '))
if guess == number:
    print u'等于'
elif guess < number:
    print u'小于'
else:
    print u'大于'
    print 'Done'
    # 测试if语句和输入
    if True:
        print 'h'
    else:
        print 'number'
        print sys.path
        print 'number'
