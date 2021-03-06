REM    Copyright 2014 Steve Francia
REM 
REM    Licensed under the Apache License, Version 2.0 (the "License");
REM    you may not use this file except in compliance with the License.
REM    You may obtain a copy of the License at
REM 
REM        http://www.apache.org/licenses/LICENSE-2.0
REM 
REM    Unless required by applicable law or agreed to in writing, software
REM    distributed under the License is distributed on an "AS IS" BASIS,
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM    See the License for the specific language governing permissions and
REM    limitations under the License.


@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\.Config4Roger
@set sublimePath=%HOME%\AppData\Roaming\Sublim~1\Packages\User\
@set sublimePath64=D:\0SoftInstall\sublimetext3\Sublime64\Data\Packages\User\
@set toPowerShellPath=%HOME%\Documents\WindowsPowerShell\
@set toPowerShellSystemPath=C:\Windows\System32\WindowsPowerShell\v1.0\
@set toHistoryAutojumpFile=%HOME%\AppData\Roaming\autojump\autojump.txt
@set srcHistoryPath=%APP_PATH%\0History
@set ZSH=%HOME%\.oh-my-zsh
IF NOT EXIST "%APP_PATH%" (
    call git clone -b 3.0 https://github.com/liuwenrong/Config4Roger.git "%APP_PATH%"
REM ) ELSE (
    REM @set ORIGINAL_DIR=%CD%
    REM echo updating Config4Roger
    REM chdir /d "%APP_PATH%"
    REM call git pull
    REM chdir /d "%ORIGINAL_DIR%"
    REM call cd "%APP_PATH%"
)

call mklink "%ZSH%\themes\0Roger.zsh-theme" "%APP_PATH%\Themes\0Roger.zsh-theme"
call mklink "%ZSH%\themes\0RogerEasy.zsh-theme" "%APP_PATH%\Themes\0RogerEasy.zsh-theme"
call mklink "%ZSH%\themes\0RogerNoGit.zsh-theme" "%APP_PATH%\Themes\0RogerNoGit.zsh-theme"
call mklink "%HOME%\Desktop\lwrHotKey.ahk" "%APP_PATH%\lwrHotKey.ahk"
call mklink "%HOME%\.minttyrc" "%APP_PATH%\.minttyrc"
call mklink "%HOME%\.zshrc" "%APP_PATH%\.zshrc"
call mklink "%HOME%\.gitconfig" "%APP_PATH%\.gitconfig"
call mklink "%HOME%\.bash_aliases" "%APP_PATH%\.bash_aliases"
call mklink "%HOME%\.bashrc" "%APP_PATH%\.bashrc"
call mklink "%HOME%\.profile" "%APP_PATH%\.profile"
REM call mklink "%HOME%\.vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\.ideavimrc" "%APP_PATH%\.ideavimrc"
::call mklink "%HOME%\_vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\.vimrc.fork" "%APP_PATH%\.vimrc.fork"
call mklink "%HOME%\.vimrc.bundles" "%APP_PATH%\.vimrc.bundles"
call mklink "%HOME%\.vimrc.bundles.fork" "%APP_PATH%\.vimrc.bundles.fork"
call mklink "%HOME%\.vimrc.before" "%APP_PATH%\.vimrc.before"
call mklink "%HOME%\.vimrc.before.fork" "%APP_PATH%\.vimrc.before.fork"
REM call mklink /J "%HOME%\.vim" "%APP_PATH%\.vim"
call mklink "%sublimePath64%Preferences.sublime-settings" "%APP_PATH%\Settings\SubLime\Preferences.sublime-settings"
call mklink "%sublimePath64%Default (Windows).sublime-keymap" "%APP_PATH%\Settings\SubLime\Default (Windows).sublime-keymap"
::call mklink "%toPowerShellSystemPath%profile.ps1" "%APP_PATH%\Settings\PowerShell\profile.ps1"
call mklink "%toPowerShellPath%profile.ps1" "%APP_PATH%\Settings\PowerShell\profile.ps1"
call mklink "%toPowerShellPath%Microsoft.PowerShell_profile.ps1" "%APP_PATH%\Settings\PowerShell\Microsoft.PowerShell_profile.ps1"
call mklink "%toHistoryAutojumpFile%" "%srcHistoryPath%\autojump\autojump.txt"
call mklink "%toHistoryAutojumpFile%.bak" "%srcHistoryPath%\autojump\autojump.txt.bak"
::call mklink "%sublimePath%Preferences.sublime-settings" "%APP_PATH%\Settings\SubLime\Preferences.sublime-settings"

REM IF NOT EXIST "%APP_PATH%\.vim\bundle" (
    REM call mkdir "%APP_PATH%\.vim\bundle"
REM )

REM IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
    REM call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
REM ) ELSE (
  REM call cd "%HOME%/.vim/bundle/vundle"
  REM call git pull
  REM call cd %HOME%
REM )

REM call vim -u "%APP_PATH%/.vimrc.bundles" +BundleInstall! +BundleClean +qall
