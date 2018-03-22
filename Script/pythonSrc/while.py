#!/usr/bin/python
#coding=utf-8
# Filename: while.py
number = 23
running = True

while running:
 guess = int(raw_input("Enter an integer :"))
 if guess == number:
  print 'Cogratulations, you guessed it.'
  running = False
 elif guess < number:
  print 'No. lower than'
 else:
  print 'No, higher than'
else:
 print 'The while lopp is over.'
print 'Done'
