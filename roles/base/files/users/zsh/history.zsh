  #_    _ _____ _____ _____  ___  ____  __    __ 
# | |  | |_   _|  ___|_   _|/ _ \|  _  \\ \  / /
# | |__| | | | |____ | | | | | | | |_) | \ \/ /
# | |  | |_| |_ ___| | | | | |_| |  _  /  |  |
# |_|  |_|_____|_____| |_|  \___/|_| \_\  |__|
 #

# +---------+
# | SETOPTs |
# +---------+

setopt extended_history          # Write the history file in the ':start:elapsed;command' format.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire a duplicate event first, when trimming history.
setopt hist_ignore_dups          # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups      # Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_space         # Do not record an event starting with a space.
setopt hist_reduce_blanks        # Remove extra blanks from each command line being added to history.
setopt hist_save_no_dups         # Do not write a duplicate event to the history file.
setopt hist_verify               # Do not execute immediately upon history expansion.

# Enable history search with up and down arrows
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search
