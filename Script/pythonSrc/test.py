#!/usr/bin/env python
# Filename:test1.py 
import os
def test1() :
	r = os.system(r'rm app\build\outputs\apk\*')
	print r

if __name__ == '__main__':
	test1()
	
