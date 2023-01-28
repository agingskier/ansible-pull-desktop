#!/usr/bin/env bash

# +--------+
# | System |
# +--------+

alias shutdown='sudo shutdown now'
alias restart='sudo reboot now'
alias suspend='sudo pm-suspend'

alias bigf='tree -iahfFQC | egrep -v /$ | sort -k2hr | head --lines=15'
alias nf='find * -type f | wc -l'               # number of files

alias df='df -h -x squashfs -x tmpfs -x devtmpfs'
alias dus='du -aS | sort -n -r | head --lines=15'
alias extip='curl icanhazip.com'

alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'
alias ping='ping -c 3'
alias sf='screenfetch'
alias btop='bpytop'                     # bashtop in python

alias mh='cd /mnt/Data/hardway'
alias dp='cd /mnt/Data/docker-projects'

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# What does it do?
#
#    Every directory visited will populate the stack.
#    When you use the alias d, it will display the directories on the stack prefixed with a number.
#    The line for index ({1..9}) alias "$index"="cd +${index}"; unset index
#    ..- will create aliases from 1 to 9.
#    They will allow you to jump directly in whatever directory on your stack.
#
# For example, if you execute 1 in Zsh, you’ll jump to the directory prefixed with 1 in your stack list.
#
# You can also increase index ({1..9}) to index ({1..100}) for example,
# if you want to be able to jump back to 100 directories.

# +---------+
# | History |
# +---------+

alias h='fc -l'               # last 16 entries in history
alias hs='history | egrep'    # search history for an entry

# +-----+
# | X11 |
# +-----+

alias xp='xprop | grep WM_CLASS' # display xprop class in running window

# +----+
# | ls |
# +----+

alias ls='lsd -F --date '+%a %d %b %Y %X' --color=always'   # see man date for format
alias lr='lsd -lhSFr --date '+%a %d %b %Y %X' --color always'    # sort by size, biggest last
alias la='lsd -lhFA --date '+%a %d %b %Y %X' --color always'     # show .dotfiles, no .. dirs, mark dir & exec
alias lt='lsd -lFA --date '+%a %d %b %Y %X' --color always'

alias lsp='lspci | ccze -A'
alias lsu='lsusb | ccze -A'
alias lsb='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,UUID | ccze -A'
alias lsc='lscpu | ccze -A'
alias lsi='sudo blkid | ccze -A'
alias lsppa='grep -rhE ^deb /etc/apt/sources.list*'
alias loc='plocate -A -i'

# +----+
# | cp |
# +----+

alias cp='cp -iv'
alias mv='mv -iv'
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# +------+
# | logs |
# +------+

alias logb='journalctl --boot --reverse --lines=50 | ccze -A'
alias logk='journalctl --dmesg --reverse --lines=50 | ccze -A'

# +------+
# | grep |
# +------+

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# +-----+
# | bat |
# +-----+

alias batl='bat --paging=never -l log'

# +-----+
# | ssh |
# +-----+

alias ssha='eval $(ssh-agent) && ssh-add'

# +-----+
# | Git |
# +-----+

alias gs='git status'
alias gss='git status -s'
alias ga='git add'
alias gp='git push'
alias gpraise='git blame'
alias gpo='git push origin'
alias gpt='git push --tag'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias grb='git branch -r'                                        # display remote branch
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log --pretty=oneline'
alias gr='git remote'
alias grs='git remote show'
alias glol='git log --graph --abbrev-commit --oneline --decorate'
alias gclean="git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 git branch -d"
# Delete local branch merged with maim
alias gblog="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:red)%(refname:short)%(color:reset) - %(color:yellow)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:blue)%(committerdate:relative)%(color:reset))'"                                                             # git log for each branches
alias gsub="git submodule update --remote"                       # pull submodules
alias gj="git-jump"                      # open in vim quickfix list files of interest (git diff, merged...)
alias dif="git diff --no-index" # Diff two files even if not in git repo! Can add -w (don't diff whitespaces)
