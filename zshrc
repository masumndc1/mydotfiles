# If you come from bash you might have to change your $PATH.
#
export PATH=$HOME/bin:/usr/local/bin:$PATH
# "curl: (35) error:06FFF089:digital envelope routines:CRYPTO_internal:bad key length"
export CURL_SSL_BACKEND="secure-transport"

if [[ -f ~/.zplug/init.zsh ]]; then
    source ~/.zplug/init.zsh
    zplug "romkatv/powerlevel10k", as:theme, depth:1
    zplug "zsh-users/zsh-history-substring-search"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zaw"
    zplug "supercrabtree/k"
    zplug "skywind3000/z.lua"
    zplug "jhawthorn/fzy"
    zplug "agkozak/zsh-z"
    zplug "belak/zsh-utils"
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/github", from:oh-my-zsh
    zplug "plugins/fsad", from:oh-my-zsh
    zplug "MichaelAquilina/zsh-you-should-use"
    zplug "zplug/zplug"

    if ! zplug check --verbose ; then
        printf "Install? [y/N]: "
            if read -q; then
                echo; zplug install
            fi
    fi
    zplug load

    plugins=( git
        github
        fasd
        z
        colorize
        colored-man-pages
    )
else
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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
            alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
            alias ll="exa --icons -l"
            alias ls="exa --icons"
            alias lt="exa --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
        fi

        if [[ -f /usr/bin/apt ]]; then
            if [[ ! -f /snap/bin/lsd ]]; then
                sudo snap install lsd
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
                export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
                export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
                export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'
                alias fp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
            fi
        fi
    fi
fi

if [[ `hostname` == "macs-MBP-2.lan" ]]; then
    export git_location="$HOME/Documents/github"
elif [[ `hostname` == "masum-K42JZ" ]]; then
    export git_location="$HOME/Documents/github"
elif [[ `hostname` == "apro13-HKHV2F" ]]; then
    export git_location="$HOME/Documents/bektigoto"
fi

alias management="cd $git_location/management"
alias testcoding="cd $git_location/test-coding"
alias mydotfiles="cd $git_location/mydotfiles"
alias gig="git log --all --decorate --oneline --graph"
alias sshmine="ssh -F ssh.config"
alias sshno="ssh -F ssh.config -o StrictHostKeyChecking=no"
alias zim="cd $git_location/zim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
