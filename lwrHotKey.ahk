;win --> #
;ctrl --> ^
;shift --> +
;alt --> !

#a::
;Run, D:\Android\Android Studio\bin\studio64.exe
Run, E:\0SoftInstall\AS_2.3.3\bin\studio64.exe
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
;everEdit=E:\Program Files\everedit_4226&�ƽ��ļ�\everedit_win32_4226_portable\EverEdit.exe
;Run,%everEdit%
;return

#f::
Run, E:\0SoftInstall\QQBrowser\QQBrowser.exe fanyi.baidu.com
return
;#f::
;sogouExplorer=E:\Program Files\SogouExplorer\SogouExplorer.exe
;fanyi=fanyi.baidu.com
;Run, %sogouExplorer% "%fanyi%"
;return

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

;��putty,�������ַ,�˻�����
#p::
putty=D:\putty\putty.exe
Run, %putty%
WinWait, PuTTY ����
Sleep, 100
;Send, 10.1.20.35
Send, 172.16.7.56
ControlClick, ��, PuTTY ����
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

#s::
;!s::
SecureCRTPortable=E:\0Soft\1705\securcrt.pc141.com\SecureCRSecureFXPortable64\SecureCRTPortable.exe
Run, %SecureCRTPortable%
;clipboard = ����
;Send, ^v
;Send, jyl19558+5
;Send, {+5}
;send, {shift}5
;MsgBox ����Win+s��ʾ����Ϣ
return

;win+v ��vim��_vimrc�ļ�
#v::
;vim=E:\0SoftInstall\msys2_64\usr\share\vim\vim80\gvim.exe -p --remote-tab-silent
vim=%HOME%\.vim\gvim.exe -p --remote-tab-silent
;HOME=C:\Users\liuwenrong.CCDOMAIN
;MsgBox %HOME%
vimrc=%HOME%\_vimrc
Run, %vim% %vimrc%
return

;Ctrl+Shift ��ʾ������Ϣ
^+w::
MsgBox ������ʾ��Ϣ
return

#z::
Run, https://www.zhihu.com
return

^+h::SendInput !{Left}
^+l::SendInput !{Right}

;��Сд��Esc����
SetCapsLockState , AlwaysOff
;CapsLock & h::SendInput {Left}
CapsLock & h::
;if GetKeyState("control") = 0
if GetKeyState("alt") = 0
{
    Send, {Left}
} else {
    Send, ^{Left}
}
return
CapsLock & k::
if GetKeyState("alt") = 0
{
    Send, {Up}
} else {
    Send, {Home}
}
return

SendInput {Up}
CapsLock & j::
if GetKeyState("alt") = 0
{
    Send, {Down}
} else {
    Send, {End}
}
return

CapsLock & l::
if GetKeyState("alt") = 0
{
    Send, {Right}
} else {
    Send, ^{Right}
}
return
CapsLock & a::SendInput {Home}
CapsLock & 0::SendInput {Home}
CapsLock & e::SendInput {End}
CapsLock & 4::SendInput {End}
CapsLock & d::SendInput {Delete}
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

;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
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
;CapsLock & .:: Send, ^{Del}                                          ;|
;CapsLock & n:: Send, ^{BS}
