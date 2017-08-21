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
;everEdit=E:\Program Files\everedit_4226&破解文件\everedit_win32_4226_portable\EverEdit.exe
;Run,%everEdit%
;return

#f::
sogouExplorer=E:\Program Files\SogouExplorer\SogouExplorer.exe
fanyi=fanyi.baidu.com
Run, %sogouExplorer% "%fanyi%"
return

#g::
Run, www.gogle.com
return

#n::
npp=E:\Program Files\Notepad++\notepad++.exe
Run, %npp%
return

;打开putty,并输入地址,账户密码
#p::
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

#s::
;!s::
SecureCRTPortable=E:\0Soft\1705\securcrt.pc141.com\SecureCRSecureFXPortable64\SecureCRTPortable.exe
Run, %SecureCRTPortable%
;clipboard = 试试
;Send, ^v
;Send, jyl19558+5
;Send, {+5}
;send, {shift}5
;MsgBox 按下Win+s显示此消息
return

#v::
vim=E:\Program Files\Vim\vim80\gvim.exe
Run, %vim%
return

^+w::
return

#z::
Run, https://www.zhihu.com
return

;大小写键Esc互换
SetCapsLockState , AlwaysOff
CapsLock & h::SendInput {Left}
CapsLock & j::SendInput {Down}
CapsLock & k::SendInput {Up}
CapsLock & l::SendInput {Right}
CapsLock & a::SendInput {Home}
CapsLock & e::SendInput {End}
CapsLock & d::SendInput {Delete}
Shift & CapsLock::SendInput, {Shift Down}{Blind}{Esc}{Shift Up}
CapsLock::SendInput {Esc}
Esc::CapsLock

