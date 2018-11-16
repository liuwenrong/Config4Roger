@Rem @ 命令 表示不显示@后面的命令
@set picName=%1%
 
@if "%picName%"=="" (
	echo please input picName,eg: screenCap.bat homePage
	@exit
)
::传入普通参数
echo picture name = %picName%, Is it open folder = %2% ,defualt Yes,if you not open folder, use N  
adb shell system/bin/screencap -p sdcard/%picName%.png
pause
adb pull sdcard/%picName%.png .
@set IsOpenFolder=%2%
if "%IsOpenFolder%"=="N" ( 
	::括号前面至少要有一个空格
	@echo not open folder
)else(
:: else要和if前面的结束括号)和自身的括号(在同一行
	::exploer .
	@start .
)
::传入文件路径
::copy %input%,%input2%