#!/usr/bin/env python
#copy file and rename 
#move file to tar_folder
 
import os,sys,shutil  
  
source_folder=r'D:\Android\0workSpacesAS\coolyotaY3\logreport\app\build\outputs\apk'  
tar_folder=r'Z:\zs_1.0\vendor\coolyota\app\CY_Log_Reporter'
  
file_list=os.listdir(source_folder)  
for file_obj in file_list:  
	srcFilePath=os.path.join(source_folder,file_obj)  
	file_name,file_extend=os.path.splitext(file_obj)  
	new_name=file_name+''+file_extend
	if 'user' in new_name:
		print 'is release'
		newNameNoUser = new_name.replace('_user', '')
		print ("srcFilePath is %s"%srcFilePath)
		print ("newNameNoUser is %s"%newNameNoUser)
		#print newNameNoUser
		#sys.stdout.write(str("success") + '\n')
		print "11"
		tarFileNoUserPath=os.path.join(tar_folder, newNameNoUser)   
		shutil.copyfile(srcFilePath, tarFileNoUserPath)  
		print ("tarFileNoUserPath is %s"%tarFileNoUserPath)
