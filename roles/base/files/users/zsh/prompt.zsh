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
LINUX_SYMBOL="\ue73a"        # 
ROOT_ALARM="⚠️‼️"
CLOCK="🕙"
NORMAL_USER="⛷️ "

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols
  symbols=()
  
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
    echo -n "%B%{$fg[magenta]%}[%{$fg[green]%}%n%{$fg[red]%} on %{$fg[green]%}%m%{$fg[magenta]%}]"
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n "%B%{$fg[magenta]%}[%{$fg[yellow]%}$HOME_SYMBOL %~%{$fg[magenta]%}]"
}

# Display Clock
prompt_clock() {
  echo -n "%{$bg[white]%}%B%{$fg[magenta]%}[%{$fg[blue]%}%D{%H:%M} $CLOCK%{$fg[magenta]%}]"
}

PROMPT="%B%{$fg[magenta]%}┌─"                        # Beginning of prompt
PROMPT+=$(prompt_status)                             # Status segment with separators
PROMPT+=$(prompt_context)                            # context user@hostname
PROMPT+=$(prompt_dir)                                # working directory

PROMPT+=$'\n'                                        # new line
PROMPT+="%B%{$fg[magenta]%}└─ %b"                   # end of prompt

# Collect git information if in a repository
# check if inside a git repository
inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

if [ "$inside_git_repo" ]; then
  autoload -Uz add-zsh-hook vcs_info
  setopt prompt_subst
  
  # enable only git 
  zstyle ':vcs_info:*' enable git 
   
  # Run vcs_info just before a prompt is displayed (precmd)
  add-zsh-hook precmd vcs_info
  # Enable checking for (un)staged changes, enabling use of %u and %c
  zstyle ':vcs_info:*' check-for-changes true
  # Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
  zstyle ':vcs_info:*' unstagedstr '%F{yellow}*%f'
  zstyle ':vcs_info:*' stagedstr '%F{green}+%f'

  # add a function to check for untracked files in the directory.
  # from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
  zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
  # 
  +vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='%F{red}!%f' # signify new files with a bang
    fi
  }

  # Set the format of the Git information for vcs_info
  #  zstyle ':vcs_info:git:*' formats       '(%s)(%b%u%c)'
  zstyle ':vcs_info:git:*' formats "%{$fg[cyan]%}(%{$fg[blue]%}%s%{$fg[cyan]%})(%{$fg[green]%} %b %u%c%{$fg[cyan]%})"
  #  zstyle ':vcs_info:git:*' actionformats '(%s)(%b|%a%u%c)'

  # add ${vcs_info_msg_0} to the prompt
  # e.g. here we add the Git information in red
  # echo -n '%B%{$fg[magenta]%}[${vcs_info_msg_0_}%B%{$fg[magenta]%}]'       # git information
  RPROMPT='%B%{$fg[magenta]%}[${vcs_info_msg_0_}%B%{$fg[magenta]%}]'       # git information
fi

RPROMPT+=$(prompt_clock)                             # get clock
RPROMPT+="%k%f"                                      # end background, forground


