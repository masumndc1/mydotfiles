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
    zplug "zsh-users/zaw"
    zplug "supercrabtree/k"
    zplug "jhawthorn/fzy"
    zplug "agkozak/zsh-z"
    zplug "belak/zsh-utils"
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/github", from:oh-my-zsh
    zplug "plugins/fsad", from:oh-my-zsh
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

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    export ZSH="$HOME/.oh-my-zsh"
    source $ZSH/oh-my-zsh.sh
    # export LANG=en_US.UTF-8
else
    sh -c "$(curl -fsSL \
        https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ -d "$HOME/.fzf-tab" ]]; then
    autoload -U compinit && compinit
    source $HOME/.fzf-tab/fzf-tab.plugin.zsh
    enable-fzf-tab
    bindkey '$' autosuggest-accept
else
    git clone https://github.com/Aloxaf/fzf-tab $HOME/.fzf-tab
fi

# Add wisely, as too many plugins slow down shell startup.
if [[ `uname` == "Darwin" ]]; then
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
        export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
        export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
        export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'
        alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
    else
        sudo port install fzf ripgrep bat
    fi
else
    if [[ `uname` == "Linux" ]]; then
        if [[ -f /usr/bin/zypper ]]; then
            source /etc/zsh_completion.d/fzf-key-bindings
            export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
            export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
            export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'
            alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
            if [[ -f /usr/bin/exa ]]; then
              alias ll="exa --icons -l"
              alias ls="exa --icons"
              alias lt="exa --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
            else
              alias ll="lsd -l"
              alias ls="lsd"
              alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
            fi
        fi

        if [[ -f /usr/bin/apt ]]; then
            if [[ ! -z `uname -v | grep -i debian` ]]; then
                if [[ ! -f /usr/bin/exa ]]; then
                    sudo apt-get install exa
                fi
                alias ll="exa --icons -l"
                alias ls="exa --icons"
                alias lt="exa --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
            elif [[ ! -z `cat /etc/os-release | grep -i debian` ]]; then
                if [[ ! -f /usr/bin/lsd ]]; then
                    sudo apt-get install lsd
                fi
                alias ls="lsd --icon always"
                alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
            elif [[ ! -z `uname -v | grep -i ubuntu` ]]; then
                if [[ ! -f /usr/bin/lsd ]]; then
                    sudo snap install lsd
                fi
                alias ll="lsd -l"
                alias ls="lsd"
                alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
            else
                echo "Unknown OS"
            fi

            if [[ ! -f /usr/bin/batcat ]]; then
                sudo apt install -y bat
            fi

            if [[ ! -f /usr/bin/fzf ]]; then
                sudo apt install -y fzf ripgrep
            else
                source /usr/share/doc/fzf/examples/key-bindings.zsh
                source /usr/share/doc/fzf/examples/completion.zsh
                export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
                export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
                export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'
                alias fp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
            fi
        fi
    fi
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

alias gig="git log --all --decorate --oneline --graph"
alias cdiff="diff --suppress-common-lines --side-by-side --color=always"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
