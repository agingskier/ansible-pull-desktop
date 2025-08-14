#!/bin/env zsh

# Symbols

SEGMENT_SEPARATOR="\ue0b0"   # 
PLUSMINUS="\u00b1"           # ±
BRANCH="\ue725"              # 
DETACHED="\uf6cf"            # 
CROSS="\u2718"               # ✘
LIGHTNING="\u26a1"           # ⚡
GEAR="\ue615"                # 
RETURN_OK="\uf42e"           # 
HOME_SYMBOL="🏠"             #   \uf015
FOLDER="\uf07c"               # 
UBUNTU_SYMBOL="\ue73a"       # 
LINUX_SYMBOL="\uf17c"        # 
ROOT_ALARM="⚠️‼️"
CLOCK="🕙"
NORMAL_USER="⛷️ "

LEFT_DOWN_ANGLE="\u250c\u2500"           # ┌─
LEFT_UP_ANGLE_ARROW="\u2514\u2500\u25b6" # └─▶ 
RIGHT_DOWN_ANGLE="\u2500\u2510"           #  ─┐
RIGHT_UP_ANGLE_ARROW="\u25c0\u2500\u2518" # ◀─┘

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[cyan]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[cyan]%})%{$reset_color%}"

# zstyle ':vcs_info:git:*' formats "%{$fg[cyan]%}(%{$fg[blue]%}%s%{$fg[cyan]%})(%{$fg[green]%} %b %u%c%{$fg[cyan]%})"

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols
  symbols=()
  
  symbols+="%B%{$fg[yellow]%}$LINUX_SYMBOL"
  
  if [[ $RETVAL -eq 0 ]]; then
    symbols+="%{$fg[green]%}$RETURN_OK"
  else 
    symbols+="%{$fg[yellow]%}%?$CROSS"
  fi

  if [[ $UID -eq 0 ]]; then
    symbols+="%{$fg[red]%}$ROOT_ALARM"
  else
    symbols+="%{$fg[green]%}$NORMAL_USER"
  fi
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{$fg{cyan}%}$GEAR"

  echo -n "%B%{$fg[magenta]%}[$symbols%{$fg[magenta]%}]"
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo -n "%B%{$fg[magenta]%}[%{$fg[green]%}%n%{$fg[red]%}@%{$fg[green]%}%m%{$fg[magenta]%}]"
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n "%B%{$fg[magenta]%}[%{$fg[yellow]%}$FOLDER  %~%{$fg[magenta]%}]"
}

# Display Clock
prompt_clock() {
  echo -n "%{$bg[white]%}%B%{$fg[magenta]%}[%{$fg[blue]%}%w - %T $CLOCK%{$fg[magenta]%}]"
}

# Left beginning of prompt
prompt_left() {
  echo -n "%B%{$fg[magenta]%}$LEFT_DOWN_ANGLE"
}

prompt_left_arrow() {
  echo -n "%B%{$fg[magenta]%}$LEFT_UP_ANGLE_ARROW"
}

PROMPT=$(prompt_left)                                # Beginning of prompt
PROMPT+=$(prompt_status)                             # Status segment with separators
PROMPT+=$(prompt_context)                            # context user@hostname
PROMPT+=$(prompt_dir)                                # working directory

PROMPT+=$'\n'                                        # new line
PROMPT+=$(prompt_left_arrow)                         # end of prompt
PROMPT+="\$vcs_info_msg_0_ "
#PROMPT+='${vcs_info_msg_0_} > '

RPROMPT+=$(prompt_clock) 
RPROMPT+="%k%f"                                      # end background, forground

