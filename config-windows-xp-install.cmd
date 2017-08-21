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

REM @if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
REM @if not exist "%HOME%" @set HOME=%USERPROFILE%

REM @set APP_PATH=%HOME%\.spf13-vim-3

REM @if not exist "%APP_PATH%" (
    REM echo backing up existing vim config
    REM @set today=%DATE%
    REM @if exist "%HOME%\.vim" call xcopy /s/e/h/y/r/q/i "%HOME%\.vim" "%HOME%\.vim.%today%"
    REM @if exist "%HOME%\.vimrc" call copy "%HOME%\.vimrc" "%HOME%\.vimrc.%today%"
    REM @if exist "%HOME%\_vimrc" call copy "%HOME%\_vimrc" "%HOME%\_vimrc.%today%"
    REM @if exist "%HOME%\.gvimrc" call copy "%HOME%\.gvimrc" "%HOME%\.gvimrc.%today%"
REM )

REM @if exist "%APP_PATH%" (
    REM @set ORIGINAL_DIR=%CD%
    REM echo updating spf13-vim
    REM chdir /d "%APP_PATH%" && git pull
    REM chdir /d "%ORIGINAL_DIR%"
REM ) else (
    REM echo cloning spf13-vim
    REM call git clone -b 3.0 git://github.com/spf13/spf13-vim.git "%APP_PATH%"
REM )

REM @if not exist  "%APP_PATH%\.vim\bundle" call mkdir "%APP_PATH%\.vim\bundle"
REM call xcopy /s/e/h/y/r/q/i "%APP_PATH%\.vim" "%HOME%\.vim"
REM call copy "%APP_PATH%\.vimrc" "%HOME%\.vimrc"
REM call copy "%APP_PATH%\.vimrc" "%HOME%\_vimrc"
REM call copy "%APP_PATH%\.vimrc.fork" "%HOME%\.vimrc.fork"
REM call copy "%APP_PATH%\.vimrc.bundles" "%HOME%\.vimrc.bundles"
REM call copy "%APP_PATH%\.vimrc.bundles.fork" "%HOME%\.vimrc.bundles.fork"
REM call copy "%APP_PATH%\.vimrc.before" "%HOME%\.vimrc.before"
REM call copy "%APP_PATH%\.vimrc.before.fork" "%HOME%\.vimrc.before.fork"

REM @if not exist "%HOME%/.vim/bundle/vundle" call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
REM call vim -u "%APP_PATH%/.vimrc.bundles" - +BundleInstall! +BundleClean +qall
