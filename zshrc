# If you come from bash you might have to change your $PATH.
if [[ -d /snap/bin ]]; then
  export PATH=$HOME/bin:/usr/local/bin:/snap/bin:$PATH
else
  export PATH=$HOME/bin:/usr/local/bin:$PATH
fi
# "curl: (35) error:06FFF089:digital envelope routines:CRYPTO_internal:bad key length"
export CURL_SSL_BACKEND="secure-transport"

if [[ -f $HOME/.zplug/init.zsh ]]; then
  source $HOME/.zplug/init.zsh
  zplug "romkatv/powerlevel10k", as:theme, depth:1
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "supercrabtree/k"
  zplug "belak/zsh-utils"
  zplug "agkozak/zsh-z"
  zplug "zplug/zplug"

  if ! zplug check --verbose ; then
    printf "Install? [y/N]: "
      if read -q; then
         echo; zplug install
      fi
  fi
  zplug load
else
  curl -sL --proto-redir -all,https \
    https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Add wisely, as too many plugins slow down shell startup.
if [[ `uname` == "Darwin" && `uname -p` == 'arm' ]]; then
  if [[ ! -f /opt/local/bin/zoxide ]]; then
    sudo port install zoxide
  else
    eval "$(zoxide init zsh)"
  fi
  if [[ -f /opt/local/bin/luarocks ]]; then
    eval "$(luarocks path)"
  fi

  if [[ -f /opt/local/bin/lsd ]]; then
    alias ll="lsd -l"
    alias ls="lsd"
    alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
  else
    sudo port install lsd
  fi

  if [[ -f /opt/local/bin/nvim ]]; then
    alias vim="/opt/local/bin/nvim"
  else
    sudo port install neovim
  fi

  if [[ -f /opt/local/bin/fzf ]]; then
    source /opt/local/share/fzf/shell/key-bindings.zsh
    source /opt/local/share/fzf/shell/completion.zsh
  else
    sudo port install fzf ripgrep bat fd
  fi

else
  if [[ `uname` == "Linux" ]]; then
    if [[ -f /usr/bin/luarocks ]]; then
      eval "$(luarocks path)"
    fi

    if [[ -f /usr/bin/yum ]]; then
      if [[ ! -f /bin/bat ]]; then
        sudo yum install -y bat ripgrep
      fi
      if [[ ! -f /bin/fzf ]]; then
        sudo yum install -y fzf
      fi

    elif [[ -f /usr/bin/zypper ]]; then
      if [[ ! -f /bin/bat ]]; then
        sudo zypper install -y bat
      fi
      if [[ ! -f /bin/fzf ]]; then
        sudo zypper install -y fzf fzf-zsh-integration
      else
        source /etc/zsh_completion.d/fzf-key-bindings
      fi
      if [[ ! -f /usr/bin/lsd ]]; then
        sudo zypper install -y lsd
      else
        alias ll="lsd -l"
        alias ls="lsd"
        alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
      fi

    elif [[ -f /usr/bin/apt ]]; then
      if [[ ! -f /usr/bin/lsd ]]; then
        sudo apt install -y lsd
      else
        alias ll="lsd -l"
        alias ls="lsd"
        alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
      fi
      if [[ ! -f /usr/bin/batcat ]]; then
        sudo apt install -y bat
      fi
      if [[ ! -f /usr/bin/fzf ]]; then
        sudo apt install -y fzf ripgrep
      else
        source /usr/share/doc/fzf/examples/key-bindings.zsh
        source /usr/share/doc/fzf/examples/completion.zsh
      fi
      if [[ -f /sbin/bin/nvim ]]; then
        alias vim="/sbin/bin/nvim"
      elif [[ -f /usr/bin/nvim ]]; then
        alias vim="/usr/bin/nvim"
      fi
    fi
  fi
  echo "Uncovered OS"
fi

if [[ `uname -o` == 'Darwin' ]]; then
  alias sshno="ssh -F ssh.config -o StrictHostKeyChecking=no"
  alias load_key="ssh-add -s /usr/local/lib/opensc-pkcs11.so"
  alias unload_key="ssh-add -e /usr/local/lib/opensc-pkcs11.so"
  alias sshmine="ssh -I /usr/local/lib/opensc-pkcs11.so -F ssh.config"
  alias get_pubkey="ssh-keygen -D /usr/local/lib/opensc-pkcs11.so -e"
  alias sshno="ssh -I /usr/local/lib/opensc-pkcs11.so -o StrictHostKeyChecking=no -F ssh.config"
  alias pyenv="source $HOME/Documents/venv/pyenv/bin/activate"
  alias myansible="source $HOME/Documents/venv/myansible/bin/activate"
  alias myprac="source $HOME/Documents/venv/myprac/bin/activate"
  alias ipython3="source $HOME/Documents/venv/ipython3/bin/activate"

  if [[ -f /opt/homebrew/bin/nvim ]]; then
    alias vim="/opt/homebrew/bin/nvim"
  elif [[ -f /opt/local/bin/nvim ]]; then
    alias vim="/opt/local/bin/nvim"
  fi
else
  alias myenv="source $HOME/Documents/venv/ansible/bin/activate"
  alias ipython3="source $HOME/Documents/venv/ipython3/bin/activate"
  alias testenv="source $HOME/Documents/venv/testenv/bin/activate"
fi

export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias gig="git log --all --decorate --oneline --graph"
alias cdiff="diff --suppress-common-lines --side-by-side --color=always"
# history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups      # don’t record duplicate commands
setopt hist_ignore_space     # don’t record commands starting with space
setopt share_history         # share history across sessions
setopt append_history        # append instead of overwrite
#autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
