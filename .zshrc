# Modeline and Notes {
# vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
# }
# Environment {
    # If you come from bash you might have to change your $PATH.
    # export PATH=$HOME/bin:/usr/local/bin:$PATH

export _T=${_T//\\//}   # replace backslash to fowardslash  
export _T="/${_T/:/}"
echo "cd $_T exec .zshrc"
if [[ $_T == "" ]] || [[ $_T == "/" ]] || [[ $_T == "//" ]]; then    
    #export _T="/c/"    
    echo "no _T Roger liuwenrong"
else
    cd "$_T"
fi     

    # Path to your oh-my-zsh installation.
    export ZSH=$HOME/.oh-my-zsh
	#export ZSH=$babunHOME/.oh-my-zsh
    if [[ $HOME == /home/users/liuwenrong ]] {
        export zHome=$HOME
    } else {
        export zHome=Z:
    }
    export srcPath=$zHome/0YT
    export target=YT
#export GIT=/e/0SoftInstall/Git/bin
    #export ADB=$ADB
    export java=/c/0Android/Java/bin
    export gradle=/c/0Android/0SoftInstall/AS3/gradle/gradle-2.14.1/bin
    export pySrc=$HOME/.Config4Roger/Script/py2Src
    export ASSDK=/c/0Android/AS_SDK/platform-tools
    export Windows=/d/Windows
    export System32=/d/Windows/System32
    export gitPath=/D/0SoftInstall/Git/bin
    export Py2=/d/0SoftInstall/Python27
    #export autojumpPath=$HOME/AppData/Local/autojump/ # 不可用 无效
    #export PATH=$HOME:$System32:$gradle:$java:$ASSDK:$pySrc:$GIT:$ADB:$PATH
    #export PATH=$HOME:$gradle:$java:$ASSDK:$pySrc:$GIT:$ADB:$PATH
    export PATH=$HOME:$Py2:$Windows:$System32:$gradle:$java:$ASSDK:$pySrc:$gitPath:$ADB:$PATH
    #export PATH=E:/0SoftInstall/Git/bin #导致很多命令找不到
#}
# Theme {
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="cloud"
#ZSH_THEME="steeef"
#ZSH_THEME="agnoster" #oneLine
#ZSH_THEME="amuse"   #doubleLine
#ZSH_THEME="0Roger"
ZSH_THEME="0RogerEasy"
#ZSH_THEME="0RogerNoGit"
#ZSH_THEME="avit"
#ZSH_THEME="random"
#ZSH_THEME="ys"      #slow 很慢
#}

# Others {
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# }

# Plugins {
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(autojump autopep8 git gradle python vi-mode)
#plugins=(vi-mode)
#plugins=(z) #not find ~/.z/
#plugins=(zsh-syntax-highlighting)
plugins=(autojump zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh #猜测会清空之前加载的插件

#cat -v Enter Press Key --> Enter --> get Escape code 字符序列

#   z 进入会卡1~2s git 项目会卡1~2s{
        #source $ZSH/plugins/z/z.plugin.zsh
#   }

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vim {
    #set -o vi
    EDITOR=vim 
    export EDITOR
    export Plugins=$HOME/.Config4Roger/Plugins
    source $Plugins/vi-mode.plugin.zsh
    ##bindkey -v #vi
    # 自定义Vi-mode {
        #allow v to edit the command line (standard behaviour)
        #autoload -Uz edit-command-line
        #bindkey -M vicmd 'v' edit-command-line

        #allow ctrl-p, ctrl-n for navigate history (standard behaviour)
        #bindkey '^P' up-history
        #bindkey '^N' down-history

        #allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
        #bindkey '^?' backward-delete-char
        #bindkey '^h' backward-delete-char
        #bindkey '^w' backward-kill-word

        #allow ctrl-r to perform backward search in history
        #bindkey '^r' history-incremental-search-backward

        #allow ctrl-a and ctrl-e to move to beginning/end of line
        #bindkey '^a' beginning-of-line
        #bindkey '^e' end-of-line

        bindkey -s '\eo'   'cd ..\n'    # 按下ALT+O 就执行 cd .. 命令
        bindkey -s '\e;'   'ls -l\n'    # 按下 ALT+; 就执行 ls -l 命令
        bindkey '\e[1;3D' backward-word       # ALT+左键：向后跳一个单词
        bindkey '\e[1;3C' forward-word        # ALT+右键：前跳一个单词
        bindkey '\e[1;3A' beginning-of-line   # ALT+上键：跳到行首
        bindkey '\e[1;3B' end-of-line         # ALT+下键：调到行尾
        bindkey '^Q' cdlast                 # 按Ctrl+Q，跳回上一次所在的目录


        #VIMODE='-- INSERT --'
        #function zle-line-init zle-keymap-select {
        #VIMODE="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
        #zle reset-prompt
        #}
        #zle -N zle-line-init 
        #zle -N zle-keymap-select
        #RPROMPT='%{$fg[green]%}${VIMODE}%{$reset_color%}'
    # }
# }

# }

# User configuration SSH {

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#}

# aliases {
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases 
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Customize to your needs...
#
#   adb & fastboot alias {
        alias ad='adb devices'
        alias ai='adb install -r $1'
        alias aks='adb kill-server'
        alias ar='adb root & adb remount'
        alias arb='adb reboot'
        alias are='adb reboot edl'
        alias as='adb shell'
        alias asasl='adb shell am stack list'
        alias asdatop='adb shell dumpsys activity | grep top-activity'
        alias asafs='adb shell am force-stop com.android.jv.ink.launcherink'
        alias asik='adb shell input keyevent'
        alias asrp='adb shell reboot -p' #关机
        alias ass='adb start-server'

        alias foe='fastboot oem edl'

#   }
#
    #cd alias {
        alias cdbl='cd d:/Android/0workSpacesAS/coolyotaY3/APP_BLauncher_170627/LauncherInk'
        alias cdlr='cd d:/Android/0workSpacesAS/coolyotaY3/logreport'
        alias cdpy='cd d:/pythonSrc'
        alias home='cd $HOME'
        alias cdgc='cd d:/GitClone'
        alias cdgcui='cd d:/GitClone'
        alias ui="cd d:/0Work/UI"
        alias apk="cd d:/0Work/apk"
        alias cdlog='cd d:/0Work/WorkGet/log'
        alias jiralog='cd e:/0yota_log/jira_log'
        alias yotalog='cd e:/0yota_log'
        alias c='cd'
        alias b='cd ..'
        alias h='cd ~'
        alias config='cd ~/.Config4Roger'
        alias zconfig='cd $zHome/.Config4Roger'
        #alias zs='cd $zHome/zs_1.0'
        #alias zs='export srcPath=$zHome/zs_1.0'
        #alias y4='export srcPath=$zHome/Y4'
        alias sp='cd $srcPath'
        alias base='cd $srcPath/frameworks/base'
        alias bl='cd $srcPath/vendor/coolyota/app/CY_BLauncher'
        alias data='cd $srcPath/vendor/coolyota/frameworks/DataStatistics'
        alias du='cd $srcPath/packages/apps/DocumentsUI'
        alias ft='cd $srcPath/vendor/zeusis/packages/apps/FactoryTest'
        alias sui='cd $srcPath/frameworks/base/packages/SystemUI'
        alias common='cd $srcPath/device/zeusis/common'
        alias 3app='cd $srcPath/vendor/coolyota/ThridApp'
        alias log='cd $srcPath/vendor/coolyota/app/CY_Log_Reporter'
        alias ci='cd $srcPath/vendor/zeusis/app/Cloneit'
        alias cm='cd $srcPath/vendor/zeusis/app/ZsCamera'
        alias dl='cd $srcPath/vendor/zeusis/app/Dialer'
        alias ds='cd $srcPath/vendor/zeusis/app/ZsDualSettings'
        alias dz='cd $srcPath/device/zeusis'
        alias sett='cd $srcPath/packages/apps/Settings'
        alias sw='cd $srcPath/vendor/zeusis/app/ZsSetupWizard'
        alias sc='cd $srcPath/packages/apps/SnapdragonCamera'
        alias sg='cd $srcPath/packages/apps/SnapdragonGallery'
        alias ts='cd $srcPath/vendor/zeusis/app/TeleService'
        alias tc='cd $srcPath/vendor/zeusis/app/Telecomm'
        alias pp='cd $srcPath/vendor/zeusis/app/PNInfoProvider'
        alias mart='cd $srcPath/vendor/zeusis/prebuilt/coolmart'
        alias out='cd $srcPath/out/target/product'
        alias priv='cd $srcPath/out/target/product/$target/system/priv-app'
        alias theme='cd $srcPath/vendor/zeusis/app/ZsThemeManager'
    #}
    #
    # aliase {
        alias cls='clear'
        alias ll='ls -l'
        alias la='ls -a'
        alias vi='vim'
        alias gv='$HOME/.vim/gvim.exe -p --remote-tab-silent'
        alias javac="javac -J-Dfile.encoding=utf8"
        alias man='superman'
        alias grep="grep --color=auto"
        alias -s html=mate   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
        alias -s rb=mate     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
        #alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
        #alias -s py=python2       # 在命令行直接输入 python 文件，会用 python2 中打开，以下类似
        alias -s js=vi
        alias -s c=vi
        alias -s java=vi
        alias -s txt=vi
        alias -s xz="xz -d"
        alias -s gz='tar -xzvf'
        alias -s tgz='tar -xzvf'
        alias -s zip='unzip'
        alias -s bz2='tar -xjvf'
        alias vzsh="vi ~/.zshrc"
        alias szsh="source ~/.zshrc"
    #}

    #Git alias {
    if [[ $TERM == cygwin ]] {
        echo cygwin -- terminal
    } else {
        alias git='LANG=en_GB git'  #能将提示的中文改成英文 #但会导致AS的Terminal执行git log中文乱码
    }
        alias gst='git status'
        alias st='status'
        alias gs='git show'
        alias ga='git add .'
        alias gamend='git commit --amend -C HEAD'
        alias gba='git branch -a'
        alias gbv='git branch -vv'
        alias gco='git checkout'
        alias gcm='git commit -asm'
        alias gcl='git config --list'
        alias gd='git diff'
        alias gf='git fetch'
        alias grb='git rebase'
        alias gr='git remote'
        alias grv='git remote -v'
        alias gp='git push'
        alias gl='git log'
        alias gla='git log --oneline --all --graph --decorate  $*'
        alias gl1='git log --oneline --graph --decorate --color=always'
        alias gll='git log --pretty=oneline'
        alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all"
    #}
    #
    # Script {
        alias pyLog='python2 $pySrc/moveLogApk.py'
        alias ins='python2 $pySrc/ins.py'
        export bl=/d/Android/0workSpacesAS/coolyotaY3/APP_BLauncher_170627/LauncherInk
        alias insdebug='cd $bl'
        #alias insreleasel='cd $bl & ins CY_BLauncher YotaDeviceRelease'
        alias insreleasel='cd $bl ; ins CY_BLauncher YotaDeviceRelease'
    # }

alias o='explorer .'
#}
#
#function {
# 
#man --help | less {
#
function superman (){
    "$1" --help | less
}
function zs (){
     export srcPath=$zHome/zs_1.0 && cd $srcPath
     export target=Y3
}
function t6 (){
     export srcPath=$zHome/0T6 && cd $srcPath
}
function y3o () {
    export srcPath=$zHome/0Y3o && cd $srcPath
}
function yt () {
    export srcPath=$zHome/0YT && cd $srcPath
    export target=YT
}
#
#}
#
#}
