#!/usr/bin/env zsh

# +--------+
# | System |
# +--------+

alias reload='source ~/config/zsh/.zshrc'

alias extip='curl -4 ifconfig.co'
alias ping='ping -c 3'

alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias dist='cat /etc/os-release'
alias glx='glxinfo | egrep OpenGL'

# +-----+
# | X11 |
# +-----+

alias xp='xprop | egrep WM_CLASS' # display xprop class in running window
alias xs='xsel'                   # display clipboard
alias xsc='xsel -c'               # clear clipboard

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


# +----+
# | cd |
# +----+

alias cd..='cd ..'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'

alias cdp='cd /mnt/Data/docker-projects'
alias cds='cd /mnt/Data/src'
alias cdc='cd /mnt/Data/clone'
alias cdcn='cd /mnt/Data/clone/nvim'
alias cda='cd /mnt/Data/ansible-test'
alias cdd='cd ~/deploy/ansible-pull-desktop'

# +----+
# | cp |
# +----+

alias cp='cp -iv'
alias mv='mv -iv'
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -v -I --preserve-root'

# +-------------------------------------------------------+
# |The 'ls' family (this assumes you use a recent GNU ls) |
# +-------------------------------------------------------+

alias ls='lsd -F --date "+%a %d %b %Y %X" --color=always'      # see man date for format
alias lr='lsd -lhSFr --date "+%a %d %b %Y %X" --color always'  # sort by size, biggest last
alias la='lsd -lhFA --date "+%a %d %b %Y %X" --color always'   # show .dotfiles, no .. dirs, mark dir & exec
alias lt='lsd -lFA --date "+%a %d %b %Y %X" --color always'

alias lsp='lspci | ccze -A'
alias lsu='lsusb | ccze -A'
alias lsb='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,UUID | ccze -A'
alias lsc='lscpu | ccze -A'
alias lsi='sudo blkid | ccze -A'
alias loc='plocate -A -i'
alias lsppa='egrep -rh ^deb /etc/apt/sources.list /etc/apt/sources.list*'
alias lsmnt='findmnt --tree --types btrfs,ext4,nfs,vfat'
 
alias lsop='lsof -P -iTCP -sTCP:LISTEN'         # display all open ports
alias lserr='journalctl -b -p err'
alias lsupg='apt list --upgradable'

# +--------------------------------+
# | Some alias to make life easier |
# +--------------------------------+

alias pp='plank --preferences'
alias tree='tree --dirsfirst -F'
alias less='less -N -M'

alias cls='tput clear'

alias which='type -a'
alias fonts='fc-cache -f -v'

alias x='nemo .'            # open nemo in current directory
alias h='fc -l'            # last 16 entries in history
alias hs='history | egrep'    # search history for an entry
alias j='jobs -l'
alias nf='find * -type f | wc -l'		# number of files

# display 15 biggest files in chosen directory
alias bigf='tree -iasfFQ | egrep -v /$ | sort -k2nr | head --lines=15'

alias sf='bash <(curl -sL nf.hydev.org)'

# limit cpu for very demaning clamscan to 30% - clamscan must be running
alias clamlim='cpulimit -e clamscan -l 30'

alias cputemp='sensors | egrep Core'
alias pscpu='echo "USER       PID %CPU %MEM  SZ    RSS   TTY      STAT STIME   TIME COMMAND"; ps auxw | tail | sort -k 1.15,1.19nr | head'
alias psmem='echo "USER       PID %CPU %MEM  SZ    RSS   TTY      STAT STIME   TIME COMMAND"; ps auxw | tail | sort -k 1.21,1.25nr | head'

# +------+
# | logs |
# +------+

alias logb='journalctl --boot --reverse --lines=150 | ccze -A'
alias logk='journalctl --dmesg --reverse --lines=150 | ccze -A'

# +------+
# | grep |
# +------+

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
alias glol='git log --graph --abbrev-commit --oneline --decorate'
alias dif="git diff --no-index" # Diff two files even if not in git repo! Can add -w (don't diff whitespaces)

# +-----+
# | ssh |
# +-----+

alias ssha='eval $(ssh-agent) && ssh-add'

# +------+
# | nvim |
# +------+
alias txvim="tilix --session=~/.config/tilix/nvim-split.json"
alias txlog="tilix --session=~/.config/tilix/wide.json -x 'journalctl -b0 -r'"
alias txtop="tilix --session=~/.config/tilix/wide.json -x 'bpytop'"

#------------------------------------------------------------- 
# End Aliases
#-------------------------------------------------------------
