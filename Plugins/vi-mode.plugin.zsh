# Updates editor information when the keymap changes.
function zle-keymap-select() {
  #zle reset-prompt
  #zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  #zle &&  zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line


# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey "^D" delete-char-or-list #del删除一个字符
bindkey "^[^D" delete-char
bindkey "^[[3~" delete-char #Key Delete
bindkey '^w' backward-kill-word
bindkey '^_' backward-kill-word #Ctrl+Backspace
bindkey '^[d' kill-word
bindkey "^[[3;5~" kill-word #Key Ctrl-Delete
bindkey "^[^H" backward-kill-word
bindkey "^U" kill-whole-line
bindkey "^K" kill-line  #kill after cursor

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
# allow ctrl-r to perform backward search in history
#bindkey '^r' history-incremental-search-backward
#bindkey '^f' history-incremental-pattern-search-forward
bindkey "^[OA" up-line-or-beginning-search # 向上搜索历史并从 输入的begin搜索
bindkey "^[OB" down-line-or-beginning-search
#bindkey '^P' up-history
#bindkey '^N' down-history
#Mode vim command up down history
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

#copy yank undo
bindkey "^Y" yank
bindkey "^z" undo
bindkey "^r" redo

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^[OH' beginning-of-line #Key Home"
bindkey '^[OF' end-of-line #Key End"
#bindkey '^a' beginning-of-line
#bindkey '^e' end-of-line

# move char or word
#bindkey "^[[C" forward-char
#bindkey "^[[D" backward-char
bindkey "^[[1;5C" forward-word  #Key Ctrl-Right
bindkey "^[[1;5D" backward-word

export KEYTIMEOUT=1 # default 0.4 second delay after you hit <Esc> key --> 0.1s

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  #MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
  #MODE_INDICATOR="%{$fg_bold[yellow]%}--Normal%{$fg[red]%}<<%{$reset_color%}"
  MODE_INDICATOR="%{$fg_bold[green]%}--Normal%{$fg[red]%}<<%{$reset_color%}"
  MODE_INSERT="%{$fg_bold[blue]%}--Insert%{$fg[red]%}--%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  #echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
  #echo "${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$MODE_INSERT}"

}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi
