# Modeline and Notes {
# vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
# }
# Environment {
    # If you come from bash you might have to change your $PATH.
    # export PATH=$HOME/bin:/usr/local/bin:$PATH

    # Path to your oh-my-zsh installation.
    export ZSH=$HOME/.oh-my-zsh
    export PATH=$PATH:E:/0SoftInstall/Git/cmd:E:/0SoftInstall/Git/bin
    #export PATH=E:/0SoftInstall/Git/bin #导致很多命令找不到
#}
#
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="cloud"
#ZSH_THEME="steeef"
#ZSH_THEME="agnoster"
ZSH_THEME="amuse"
#ZSH_THEME="avit"
#ZSH_THEME="random"
#ZSH_THEME="ys"      #slow 很慢

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(autojump autopep8 git gradle python vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

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
        alias asrp='adb shell reboot -p' #关机

        alias foe='fastboot oem edl'

#   }
    #cd alias {
        alias cdpy='cd d:/pythonSrc'
        alias home='cd $HOME'
        alias ui="cd d:/0Work/UI"
        alias cdlog='cd d:/0Work/WorkGet/log'
        alias c='cd'
        alias b='cd ..'
        alias h='cd ~'
        export zHome=Z:
        alias zs='cd $zHome/zs_1.0'
        alias base='cd $zHome/zs_1.0/frameworks/base'
        alias sui='cd $zHome/zs_1.0/frameworks/base/packages/SystemUI'
        alias common='cd $zHome/zs_1.0/device/zeusis/common'
        alias 3app='cd $zHome/zs_1.0/vendor/coolyota/ThridApp'
        alias Y3='cd $zHome/zs_1.0/device/zeusis/Y3'
        alias log='cd $zHome/zs_1.0/vendor/coolyota/app/CY_Log_Reporter'
        alias theme='cd $zHome/zs_1.0/vendor/zeusis/app/ZsThemeManager'
        alias mart='cd $zHome/zs_1.0/vendor/zeusis/prebuilt/coolmart'
        alias priv='cd $zHome/zs_1.0/out/target/product/Y3/system/priv-app'
        alias sett='cd $zHome/zs_1.0/packages/apps/Settings'
    #}
    # aliase {
        alias cls='clear'
        alias ll='ls -l'
        alias la='ls -a'
        alias vi='vim'
        alias javac="javac -J-Dfile.encoding=utf8"
        alias grep="grep --color=auto"
        alias -s html=mate   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
        alias -s rb=mate     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
        alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
        alias -s js=vi
        alias -s c=vi
        alias -s java=vi
        alias -s txt=vi
        alias -s gz='tar -xzvf'
        alias -s tgz='tar -xzvf'
        alias -s zip='unzip'
        alias -s bz2='tar -xjvf'
        alias vzsh="vi ~/.zshrc"
        alias szsh="source ~/.zshrc"
    #}

    # Git alias {
        alias gst='git status'
        alias st='status'
        alias ga='git add .'
        alias gba='git branch -a'
        alias gbv='git branch -vv'
        alias gf='git fetch'
        alias gr='git rebase'
        alias grv='git remote -v'
        alias gp='git push'
        alias gco='git checkout'
        alias gcm='git commit -a -s'
        alias gamend=git commit --amend -C HEAD 
        alias gcl='git config --list'
        alias gl='git log'
        alias gla='git log --oneline --all --graph --decorate  $*'
        alias gl1='git log --oneline --graph --decorate --color=always'
        alias gll='git log --pretty=oneline'
    #}

alias o='explorer .'
#}
