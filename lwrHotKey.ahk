;win --> #
;ctrl --> ^
;shift --> +
;alt --> !

vim=%HOME%\.vim\gvim.exe -p --remote-tab-silent
; Win a-z{
#a::
;Run, D:\Android\Android Studio\bin\studio64.exe
lwrAHK=%HOME%\.Config4Roger\lwrHotKey.ahk
Run, %vim% %lwrAHK%
;Run, E:\0SoftInstall\AS_2.3.3\bin\studio64.exe
return

#b::
Run, https://www.baidu.com
return

#c::
;cmder=E:\0Soft\1611\cmder\cmder.exe
;cmder=E:\Program Files\cmder\cmder.exe
cmder=E:\0SoftInstall\cmder\cmder.exe
Run,%cmder%
return

;#d::
;everEdit=E:\Program Files\everedit_4226&破解文件\everedit_win32_4226_portable\EverEdit.exe
;Run,%everEdit%
;return

#f::
; 翻译 {
Run, E:\0SoftInstall\QQBrowser\QQBrowser.exe fanyi.baidu.com
return
;#f::
;sogouExplorer=E:\Program Files\SogouExplorer\SogouExplorer.exe
;fanyi=fanyi.baidu.com
;Run, %sogouExplorer% "%fanyi%"
;return
;}

#g::
Run, www.gogle.com
return

#m::
msys=E:\0SoftInstall\msys2_64\msys2_shell.cmd
Run, %msys%
return

#n::
npp=E:\Program Files\Notepad++\notepad++.exe
Run, %npp%
return

#p::
;打开putty,并输入地址,账户密码 {
putty=D:\putty\putty.exe
Run, %putty%
WinWait, PuTTY 配置
Sleep, 100
;Send, 10.1.20.35
Send, 172.16.7.56
ControlClick, 打开, PuTTY 配置
;Send, {enter}
Sleep, 1000
Send, liuwenrong 
Send, {enter}
Sleep, 500
;Send, Lwr12345
Send, 1q2w3e4r5t&
Send, {enter}
return
Sleep, 2000
Send, cd{space}android+-n
Send, {enter}
Sleep, 500
Send, source{space}build/envsetup.sh
return
;}

#s::
; 搜狗搜索 {
Run, E:\0SoftInstall\QQBrowser\QQBrowser.exe https://www.sogou.com
return

;#s::
;SecureCRTPortable=E:\0Soft\1705\securcrt.pc141.com\SecureCRSecureFXPortable64\SecureCRTPortable.exe
;Run, %SecureCRTPortable%
;return

#v::
;win+v 用vim打开_vimrc文件 {
;vim=E:\0SoftInstall\msys2_64\usr\share\vim\vim80\gvim.exe -p --remote-tab-silent
;HOME=C:\Users\liuwenrong.CCDOMAIN
;MsgBox %HOME%
vimrc=%HOME%\.Config4Roger\.vimrc
Run, %vim% %vimrc%
return
;}

;Ctrl+Shift 显示测试消息
^+w::
MsgBox 测试显示消息
return

#z::
Run, https://www.zhihu.com
return
;}

;Right Win a-z {

>#r::
ReadMe=%HOME%\.Config4Roger\README.md
Run, %vim% %ReadMe%
return

;}

;Right Alt+/ = Ctrl+t ToggleCommenter 开关注释 AS加上Shift 就是多行注释
;需要 其他加注释的软件把注释快捷键改成Ctrl+t 和Ctrl+Shift+t
>!/::Send, ^t
+>!/::Send, ^+t
CapsLock & /::
if GetKeyState("alt") = 0
{
    Send, ^t
} else {
    Send, ^+t
}
return

;Ace Jump & EasyMotion Ctrl+b 查字符 Ctrl+w 查单词 按行
>!;::Send, ^b
+>!;::Send, ^w
CapsLock & `;::
if GetKeyState("alt") = 0
{
    Send, ^b
} else {
    Send, ^w
}
return

;CapsLock-Esc互换 & Move {
SetCapsLockState , AlwaysOff
;CapsLock & h::SendInput {Left}
;Ctrl+Shift+h = Alt <--左箭头
^+h::SendInput !{Left}
^+l::SendInput !{Right}

CapsLock & h::
;if GetKeyState("control") = 0
CapsLock & s::
if GetKeyState("alt") = 0
{
    Send, {Left}
} else {
    Send, ^{Left}
}
return

!e::Send, {Up}

CapsLock & k::
if GetKeyState("alt") = 0
{
    Send, {Up}
} else {
    Send, {Home}
}
return

;SendInput {Up}

!d::Send, {Down}

CapsLock & j::
if GetKeyState("alt") = 0
{
    Send, {Down}
} else {
    Send, {End}
}
return

CapsLock & l::
CapsLock & f::
if GetKeyState("alt") = 0
{
    Send, {Right}
} else {
    Send, ^{Right}
}
return

;MouseMove, X, Y [, Speed, R] speed 0(最快)~100  
;鼠标右移
!f::
if GetKeyState("W") = 0
{
    MouseMove, 50, 0, 1, r
} else {
    MouseMove, 10, 0, 1, r
}
return

!s::MouseMove, -50, 0, 1, r
return

CapsLock & e::
if GetKeyState("W") = 0
{
    MouseMove, 0, -50, 1, r
} else {
    MouseMove, 0, -10, 1, r
}
return

CapsLock & d::MouseMove, 0, 50, 1, r
return

!a::Send {LButton}

; 鼠标手势  
rbutton::      
  minGap  = 30 ; 设定的识别阈值，大于此阈值，说明在某方向上有移动  
  mousegetpos xpos1,ypos1  
  Keywait, RButton, U  
  mousegetpos xpos2, ypos2  
  if (abs(xpos1-xpos2) < minGap and abs(ypos1-ypos2)<minGap) ; nothing 没有运动，直接输出rbutton   
  send, {rbutton}  
  ;else if (xpos1-xpos2 > minGap and abs(ypos1-ypos2)<minGap) ; left  delete(对于文件或选定的字符有效)  
   ;send, {delete}  
  ;else if (xpos2-xpos1 > minGap and abs(ypos1-ypos2)<minGap) ; right ctrl+z 恢复    
   ;send, ^z  
  else if (abs(xpos1-xpos2)< minGap and (ypos1-ypos2)>minGap) ; up 最大化窗口， win+up  
    send, #{up}  
  else if (abs(xpos1-xpos2)< minGap and (ypos2-ypos1)>minGap) ; down 显示桌面， win+d  
    send, #d  
  ;else if (ypos2-ypos1 > minGap and (xpos1-xpos2) > minGap) ; down and left , ctrl+shift+T  
    ;send, ^+t  
  ;else if (ypos2-ypos1 > minGap and (xpos2-xpos1) > minGap) ; down and right, ctrl+w  
    ;send, ^w  
  ;else if (ypos1-ypos2 > minGap and (xpos2-xpos1) > minGap) ; up and right alt+f4  
   ;send, !{F4}  
  ;else if (ypos1-ypos2 > minGap and (xpos1-xpos2) > minGap) ; up and left nothing  
   ;send, {rbutton}  
  else    
    send, {rbutton}  
  return  

CapsLock & a::SendInput {Home}
CapsLock & 0::SendInput {Home}
;CapsLock & e::SendInput {End}
CapsLock & 4::SendInput {End}
;CapsLock & d::SendInput {Delete}
CapsLock & u::SendInput {PgUp}
CapsLock & p::SendInput {PgDn}
;Shift & CapsLock::SendInput, {Shift Down}{Blind}{Esc}{Shift Up}
CapsLock & g::
if  GetKeyState("shift") = 0
{
    Send, {Home}
} else {
    Send, {End}
}
return
CapsLock::SendInput {Esc}
Esc::CapsLock
;}

;Delete & BackSpace{
;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + m  |  Delete                        ;|
;                     Caps +Alt+ m  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     Caps+Alt + ,  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & m::
if GetKeyState("alt") = 0
{
    Send, {BS}
} else {
    Send, ^{BS}
}
return
CapsLock & ,::
if GetKeyState("alt") = 0
{
    Send, {Del}
} else {
    Send, ^{Del}
}
return
;}
