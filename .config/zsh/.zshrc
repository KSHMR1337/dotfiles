# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
precmd_functions=""
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt prompt_subst        # Allow substitutions and expansions in the prompt
force_color_prompt=yes

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# source required files
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/nvm/init-nvm.sh
source <(fzf --zsh)

# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

# sudo not required for some system commands
for command in mount umount pacman su shutdown poweroff reboot ; do
	alias $command="sudo $command"
done; unset command

# Aliases set up

alias \
    ls="ls -hN --group-directories-first" \
    ll='ls -l' \
    la='ls -A' \
    l='ls -CF' \
    vol3='vol' \
    vol2='vol.py' \
    rmdir='rm -rf' \
    mkd='mkdir -pv' \
    cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	bc="bc -ql" \
    wireshark="QT_STYLE_OVERRIDE="kvantum-dark" wireshark"

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|st-256color)
        TERM_TITLE=$'\e]0;%n@$(hostname): $(pwd)\a'
        ;;
    *)
        ;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Add current conda environtment to the prompt

function conda_env()
{
    if [[ -n $CONDA_PREFIX ]]
            then
              if [[ $(basename $CONDA_PREFIX) == "miniforge3" ]]; then
                # Without this, it would display conda version
                echo "base"
              else
                # For all environments that aren't (base)
                echo $(basename $CONDA_PREFIX)
              fi
          # When no conda environment is active, don't show anything
    else
    fi
}    

# Add name of the current git branch to the prompt

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
      echo ""
  else
      echo $branch
  fi
}

# Configure colors

if [ "$color_prompt" = yes ]; then

    zstyle ':completion:*:default' list-colors 'di=38;5;198:ex=38;5;212:fi=38;5;255:ow=38;5;207:ln=38;5;213:so=38;5;197:pi=38;5;125:bd=38;5;162:cd=38;5;206:su=38;5;205:sg=38;5;199'
    zstyle ':completion:*:*:*:*:descriptions' format '%F{#ff5ee4}Completing %d%f'

    # Prompt color variable initializations
    color_commands="%F{#e1bee7}"
    color_lines="%F{#ab47bc}"
    color_error="%F{#d81b60}"
    color_username="%F{#e1bee7}"
    color_warning="%F{#f06292}"
    color_separator="%F{#ab47bc}"
    color_brackets="%F{#7b1fa2}"
    color_prompt_sign="%F{#e91e63}"


    

    # Syntax-highlighting color variable initializations
    color_unknown="#cccccc"
    color_alias="#5d284f"
    color_highlight="#5a475f"
    color_underline="#9b0860"
    color_command_separator="#ab47bc"
    color_comment="#a64d8c"
    color_arg0="#bbbbbb"
    color_bracket_error="#5d284f"
    color_bracket_level_1="#9b59b6"
    color_bracket_level_2="#5a475f"
    color_bracket_level_3="#a64d8c"
    color_bracket_level_4="#9b0860"
    color_bracket_level_5="#a225e0"
    color_reserved="#9b59b6"
    color_prompt_root="#5d284f"
    color_warning="#a64d8c"
    color_reset="%f"



    username=$(whoami | tr "[:lower:]" "[:upper:]")
    
    # This is backup prompt without the conditionals for brackets arount $conda_env and $branch
    # PROMPT=$'${color_lines}┌──%B${color_brackets}(${color_commands}$(conda_env)${color_brackets})%b${color_lines}─%B${color_brackets}(${color_username}K5HMЯ${color_separator}@${color_username}%m${color_brackets})%b${color_lines}─%B${color_brackets}(${color_commands}$(git_branch_name)${color_brackets})%b${color_lines}─%B${color_brackets}[${color_commands}%(6~.%-1~/…/%4~.%5~)${color_brackets}]%b${color_lines}\n└──%B%(#.${color_error}#.%F{red}$)%b${color_lines} '
    PROMPT=$'${color_lines}┌──%B${color_brackets}$( [[ -n "$(conda_env)" ]] && echo "(${color_commands}$(conda_env)${color_brackets})" )%b${color_lines}─%B${color_brackets}(${color_username}%m${color_separator}@${color_username}%m${color_brackets})%b${color_lines}─%B${color_brackets}$( [[ -n "$(git_branch_name)" ]] && echo "(${color_commands}$(git_branch_name)${color_brackets})" )%b${color_lines}─%B${color_brackets}[$( [[ -n "%(6~.%-1~/…/%4~.%5~)" ]] && echo "${color_commands}%(6~.%-1~/…/%4~.%5~)" )${color_brackets}]%b${color_lines}\n└──%B%(#.${color_error}#.$color_prompt_sign$)%b${color_lines}'
    RPROMPT=$'%(?.. %? ${color_error}%B⨯%b${color_reset})%(1j. %j ${color_warning}%B⚙%b${color_reset}.)'
    
    # Initialize ZSH highlighting settings
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=$color_reset
    ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${color_unknown},bold"
    ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${color_reserved},bold"
    ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${color_prompt_root},underline"
    ZSH_HIGHLIGHT_STYLES[global-alias]="fg=${color_alias}"
    ZSH_HIGHLIGHT_STYLES[precommand]="fg=${color_underline},underline"
    ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=${color_command_separator},bold"
    ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=${color_prompt_root},underline"
    ZSH_HIGHLIGHT_STYLES[path]=underline
    ZSH_HIGHLIGHT_STYLES[globbing]="fg=${color_prompt_root},bold"
    ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=${color_prompt_root},bold"
    ZSH_HIGHLIGHT_STYLES[command-substitution]=$color_reset
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[process-substitution]=$color_reset
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=$color_reset
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=${color_prompt_root},bold"
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=${color_warning}"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=${color_warning}"
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=${color_warning}"
    ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=${color_highlight}"
    ZSH_HIGHLIGHT_STYLES[assign]=$color_reset
    ZSH_HIGHLIGHT_STYLES[redirection]="fg=${color_prompt_root},bold"
    ZSH_HIGHLIGHT_STYLES[comment]="fg=${color_comment},bold"
    ZSH_HIGHLIGHT_STYLES[named-fd]=$color_reset
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=$color_reset
    ZSH_HIGHLIGHT_STYLES[arg0]="fg=${color_arg0}"
    ZSH_HIGHLIGHT_STYLES[bracket-error]="fg=${color_bracket_error},bold"
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]="fg=${color_bracket_level_1},bold"
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]="fg=${color_bracket_level_2},bold"
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]="fg=${color_bracket_level_3},bold"
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]="fg=${color_bracket_level_4},bold"
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]="fg=${color_bracket_level_5},bold"
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

else
    PROMPT=$'┌──$(conda_env)─(%n@%m)─$(git_branch_name)─[(6~.%-1~/…/%4~.%5~)]\n└──%B%(#.)'
fi

unset color_prompt force_color_prompt


new_line_before_prompt=yes

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$new_line_before_prompt" = yes ]; then
	if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
	    _NEW_LINE_BEFORE_PROMPT=1
	else
	    print ""
	fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls -hN --color=auto --group-directories-first" 
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

#enable auto-suggestions based on the history
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
   . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
   ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#f7b0f6'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zare/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zare/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/zare/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zare/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/zare/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/zare/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
