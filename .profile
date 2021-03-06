# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# 解决git log中文乱码的问题
export LESSCHARSET=utf-8
 #set PATH so it includes user's private bin directories
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export JRE_HOME=$JAVA_HOME/jre
#export LIBS="$HOME/lib"
#export LD_LIBRARY_PATH="$HOME/lib/:$HOME"
#export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
#export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
#echo "ANDROID_JACK_VM_ARGS=$ANDROID_JACK_VM_ARGS"
export PATH="$gitPath:$PATH"
#PATH="$gitPaht:$JRE_HOME/bin:$HOME/bin:$HOME/usr/bin:$HOME/.local/bin:$PATH"
# flutter代理
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
