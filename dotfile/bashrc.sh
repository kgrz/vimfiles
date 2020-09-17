#!/usr/bin/env bash

# Init, Variables
  # If not running interactively, don't do anything
  [[ -z "$PS1" ]] && return

  # Goto home, not /
  if [[ "$PWD" == / ]] ; then cd "$HOME" || : ; fi

  # Set USER
  [[ -z "$USER" ]] && command -v whoami > /dev/null && USER=$(whoami) && export USER

# Do I need to load .bash_profile
  # shellcheck disable=SC2154  # os is referenced but not assigned
  if [[ -z "$os" && -z "$v" && -f "$HOME/.bash_profile" ]]; then
    echo Sourcing Profile
  	source "$HOME/.bash_profile"
  fi

# Execute tmux
  if command -v tmux &> /dev/null \
      && [[ -z "$TMUX" \
      &&  ! "$TERM" =~ screen  && ! "$TERM" =~ "screen-256color" \
      &&  ! "$TERM" =~ tmux  &&  ! "$TERM" =~ "tmux-256color" ]] \
      ; then
    # for ALMA but some glinch in scroll vim
    # exec env TERM=xterm-256color tmux
    # For bold and italic
    exec env TERM=tmux-256color tmux
  fi

# Head
  # clear
  # Nowrap
  printf '\e[?7l'
  cat << '  EOF'
                             \  |  /
                              \_|_/
                  /|\     ____/   \____
                 / | \        \___/
                /  |  \       / | \
               /___|___\     /  |  \
              _____|_____
              \_________/
   ~~^^~~^~^~~^^~^^^^~~~~^~^~^~^^^^^^^

        |\   \\\\__     o
        | \_/    o_\    o
        >  _  (( <_  oo
        | / \__+___/
        |/     |/

  EOF
  # Reset wrap
  printf '\e[?7h'

# Fast
  # Add "substitute" mnemonic, which the info file left out.
  export PATH="/home/tourneboeuf/Program/GitFuzzy/bin:$PATH"

# PS1
  # Title: Host: CD
  PS1='\[\e]0;\]`parse_title`\007'
  # CD (green)
  PS1+='\[\e[32m\]\w'
  # Git Branch (yellow)
  PS1+='\[\e[33m\]'
  PS1+='`parse_git_branch`'
  PS1+='\[\e[00m\]'
  # New line
  PS1+='\n$ '
  export PS1


# Include, Source, Extension (Alias and Completion)
  ############
  # Completion
  #bcan_complete=0
  #if [[ -f "/etc/bash_completion" ]]; then
  #  source "/etc/bash_completion" && bcan_complete=1;
  #elif [[ -f "$HOME/.local/usr/share/bash-completion/bash_completion" ]]; then
  #  # shellcheck disable=SC1090
  #  source "$HOME/.local/usr/share/bash-completion/bash_completion" && bcan_complete=1;
  #fi
  # Alias
  if [[ -f "$HOME/.bash_aliases.sh" ]]; then
    source "$HOME/.bash_aliases.sh"
  fi

  # ShellArsenal Complete
  if [[ -f "$v/bin/_tin_complete.sh" ]]; then
    source "$v/bin/_tin_complete.sh"
  fi

  # Tmux completion
  if command -v _get_comp_words_by_ref &> /dev/null && [[ -f "$v/bin/_tinrc-tmux-completion.sh" ]]; then
    source "$v/bin/_tinrc-tmux-completion.sh"
  fi

  # Fzf bindings
  if [[ -f "$HOME/.fzf.bash" ]]; then
    # shellcheck source=/home/tourneboeuf/.bash_aliases.sh
    source "$HOME/.fzf.bash"
  fi

  # Alacrity Completion
  if [[ -f "$v/scripts/completion/alacritty" ]]; then
    source "$v/scripts/completion/alacritty"
  fi

  # Pip bash completion start
  _pip_completion()
  {
      mapfile -t COMPREPLY < <( \
        COMP_WORDS="${COMP_WORDS[*]}" \
        COMP_CWORD=$COMP_CWORD \
        PIP_AUTO_COMPLETE=1 $1 2>/dev/null )
  }
  complete -o default -F _pip_completion pip
  # pip bash completion end

# Bind
  # Enable Readline not waiting for additional input when a key is pressed.
  set keyseq-timeout 10
  bind -x '"\ee":fzf_open'
  bind -x '"\er":fzf_dir ~/wiki/rosetta/Lang'


# vim:sw=2:ts=2:foldignore=:
