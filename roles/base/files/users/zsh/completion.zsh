  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

#
# All of these completion rules need to be loaded and prepared.
# zsh’s completion system creates a cache in the file ~/.zcompdump
# when changes are made to the completion rules the cache needs to be removed and rebuilt
# rm -f $XDG_CACHE_HOME/zsh/.zcompcache
# compinit
#

# +---------+
# | SETOPTs |
# +---------+

# use "man zshoptions" and search for “Completion”
# setopt glob_complete      # Show autocompletion menu with globs
setopt menu_complete        # Automatically highlight first element of completion menu
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt complete_in_word     # Complete from both ends of a word.

# +------------------+
# | complist modules |
# | bindkeys         |
# +------------------+
# see "man zshmodules" and search for “THE ZSH/COMPLIST MODULE”

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers used
zstyle ':completion:*' completer _extensions _complete _ignored _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

# Allows you to select in a completion menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
# Sort matching files alphabetically with dummyvalue
zstyle ':completion:*' file-sort dummyvalue

# Use menu, also llows you to use arrow keys
zstyle ':completion:*' menu select=2 _complete _ignored _approximate

# Formatting the display with colors and decoration
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %B%d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Group the different type of matches under their descriptions,
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Colorful completion list for files and directories - use LS_COLORS
# see "man zshmodules" and search “Colored completion listings”
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Completion matching control - uppercase from lowercase
# see "man zshcompwid" and search for “COMPLETION MATCHING CONTROL"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
