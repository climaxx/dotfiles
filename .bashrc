[ -n "$PS1" ] && source ~/.bash_profile
# history stuff
HISTCONTROL=ignoreboth
HISTFILESIZE=100000
HISTSIZE=100000
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it
# Save multi-line commands as one command
shopt -s cmdhist

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# ^ the only downside with this is [up] on the readline will go over all history not just this bash session.



# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

EDITOR=vi
if [ -n "$(command -v vim)" ]; then
    EDITOR=vim
fi
export EDITOR
# Use less pager, fall back to more
PAGER=more
MANPAGER="$PAGER"
if [ -n "$(command -v less)" ]; then
    PAGER="less -FXiRSw"
    MANPAGER="less -FXiRsw"
fi
export PAGER MANPAGER
LS_COMMON="-hBG --color=auto"

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
# vim: ts=4 sts=4 shiftwidth=4 expandtab

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null
