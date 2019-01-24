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
QQBrowser=D:\0Work\0SoftInstall\QQBrowser\QQBrowser.exe
Run, %QQBrowser% https://www.baidu.com
return

#c::
;cmder=E:\0Soft\1611\cmder\cmder.exe
;cmder=E:\Program Files\cmder\cmder.exe
cmder=E:\0SoftInstall\cmder\cmder.exe
Run,%cmder%
return

;#d::
;everEdit=E:\Program Files\everedit_4226&ÆÆ½âÎÄ¼þ\everedit_win32_4226_portable\EverEdit.exe
;Run,%everEdit%
;return

#f::
; ·­Òë {
Run, D:\0Work\0SoftInstall\QQBrowser\QQBrowser.exe fanyi.baidu.com
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
;´ò¿ªputty,²¢ÊäÈëµØÖ·,ÕË»§ÃÜÂë {
putty=D:\putty\putty.exe
Run, %putty%
WinWait, PuTTY ÅäÖÃ
Sleep, 100
;Send, 10.1.20.35
Send, 172.16.7.56
ControlClick, ´ò¿ª, PuTTY ÅäÖÃ
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
; ËÑ¹·ËÑË÷ {
Run, E:\0SoftInstall\QQBrowser\QQBrowser.exe https://www.sogou.com
return

;#s::
;SecureCRTPortable=E:\0Soft\1705\securcrt.pc141.com\SecureCRSecureFXPortable64\SecureCRTPortable.exe
;Run, %SecureCRTPortable%
;return

#v::
;win+v ÓÃvim´ò¿ª_vimrcÎÄ¼þ {
;vim=E:\0SoftInstall\msys2_64\usr\share\vim\vim80\gvim.exe -p --remote-tab-silent
;HOME=C:\Users\liuwenrong.CCDOMAIN
;MsgBox %HOME%
vimrc=%HOME%\.Config4Roger\.vimrc
Run, %vim% %vimrc%
return
;}

;Ctrl+Shift ÏÔÊ¾²âÊÔÏûÏ¢
^+w::
MsgBox ²âÊÔÏÔÊ¾ÏûÏ¢
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

;Right Alt+/ = Ctrl+t ToggleCommenter ¿ª¹Ø×¢ÊÍ AS¼ÓÉÏShift ¾ÍÊÇ¶àÐÐ×¢ÊÍ
;ÐèÒª ÆäËû¼Ó×¢ÊÍµÄÈí¼þ°Ñ×¢ÊÍ¿ì½Ý¼ü¸Ä³ÉCtrl+t ºÍCtrl+Shift+t
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

;Ace Jump & EasyMotion Ctrl+w ²é×Ö·û Ctrl+b ²éµ¥´Ê °´ÐÐ ´óÐ¡Ð´¼ü+;Ó³Éä
;>!;::Send, ^b
;+>!;::Send, ^w
CapsLock & `;::
if GetKeyState("alt") = 0
{
    Send, ^w
} else {
    Send, ^b
}
return

;CapsLock-Esc»¥»» & Move {
SetCapsLockState , AlwaysOff
;CapsLock & h::SendInput {Left}
;Ctrl+Shift+h = Alt <--×ó¼ýÍ·
^+h::SendInput !{Left}
^+l::SendInput !{Right}

;CapsLock & s::
CapsLock & h::
if GetKeyState("alt") = 0
{
if GetKeyState("ctrl") = 0 {
  Send, {Left}
} else {
    Send, ^{Left}
}
} else {
    Send, !{Left}
}
return

!w::Send, {Up}

CapsLock & k::
if GetKeyState("alt") = 0
{
    Send, {Up}
} else {
    Send, {PgUp}
}
return

;SendInput {Up}

!s::Send, {Down}

CapsLock & j::
if GetKeyState("alt") = 0
{
    Send, {Down}
} else {
    Send, {PgDn}
}
return

;CapsLock & f::
CapsLock & l::
if GetKeyState("alt") = 0
{
if GetKeyState("ctrl") = 0 {
    Send, {Right} ;Cap+l -> 右移一个字母
} else {
    Send, ^{Right} ;Cap+Ctrl+l -> Ctrl+右：右移一个word
}
} else {
if GetKeyState("ctrl") = 0 {
    Send, !{Right} ;Alt+右 CamelHumps Mode
} else {
    Send, ^!{Right} ;Ctrl+Alt+右 CamelHumps Mode
}
}
return

;MouseMove, X, Y [, Speed, R] speed 0(×î¿ì)~100  
;Êó±êÓÒÒÆ,Alt+f»á¸úAS¿ì½Ý¼ü³åÍ»
;!f::
;if GetKeyState("W") = 0
;{
;   MouseMove, 50, 0, 1, r
;} else {
;    MouseMove, 10, 0, 1, r
;}
;return

;!s::MouseMove, -50, 0, 1, r
;return

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

;!a::Send {LButton}
!a::Send {enter}

; Êó±êÊÖÊÆ  
rbutton::      
  minGap  = 30 ; Éè¶¨µÄÊ¶±ðãÐÖµ£¬´óÓÚ´ËãÐÖµ£¬ËµÃ÷ÔÚÄ³·½ÏòÉÏÓÐÒÆ¶¯  
  mousegetpos xpos1,ypos1  
  Keywait, RButton, U  
  mousegetpos xpos2, ypos2  
  if (abs(xpos1-xpos2) < minGap and abs(ypos1-ypos2)<minGap) ; nothing Ã»ÓÐÔË¶¯£¬Ö±½ÓÊä³örbutton   
  send, {rbutton}  
  ;else if (xpos1-xpos2 > minGap and abs(ypos1-ypos2)<minGap) ; left  delete(¶ÔÓÚÎÄ¼þ»òÑ¡¶¨µÄ×Ö·ûÓÐÐ§)  
   ;send, {delete}  
  ;else if (xpos2-xpos1 > minGap and abs(ypos1-ypos2)<minGap) ; right ctrl+z »Ö¸´    
   ;send, ^z  
  else if (abs(xpos1-xpos2)< minGap and (ypos1-ypos2)>minGap) ; up ×î´ó»¯´°¿Ú£¬ win+up  
    send, #{up}  
  else if (abs(xpos1-xpos2)< minGap and (ypos2-ypos1)>minGap) ; down ÏÔÊ¾×ÀÃæ£¬ win+d  
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
;大小写和Esc对换
CapsLock::SendInput {Esc}
Esc::CapsLock
+CapsLock::SendInput +{Esc}
;}

;Delete & BackSpace{
;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + m  |  BackSpace                     ;|
;                     Caps +Ctrl+m  |  Ctrl+ BackSpace               ;|
;                     Caps +Alt+ m  |  Alt + BackSpace(CamelHumps BS);|
;                     CapsLock + ,  |  Delete (Delete a Word)        ;|
;                     Caps+Alt + ,  |  Alt  + Delete (Delete a Word) ;|
;-----------------------------------o---------------------------------o
CapsLock & m::
if GetKeyState("alt") = 0
{
if GetKeyState("ctrl") = 0 {
    Send, {BS}
} else{
    Send, ^{BS}
}
} else {
    Send, !{BS}   ;驼峰式删除 CamelHumps Mode
}
return
CapsLock & ,::
if GetKeyState("alt") = 0
{
  if GetKeyState("ctrl") = 0 {
    Send, {Del}
  } else {
    Send, ^{Del}
  }
} else {
    Send, !{Del}
}
return
;}
