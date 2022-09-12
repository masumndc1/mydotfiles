# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# "curl: (35) error:06FFF089:digital envelope routines:CRYPTO_internal:bad key length"
export CURL_SSL_BACKEND="secure-transport"

# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"
export git_location="~/Documents/github"
#ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/.zplug/init.zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
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
# Install plugins if not installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Add wisely, as too many plugins slow down shell startup.
plugins=( git
    github
    fasd
    fzf
    z
    colorize
    colored-man-pages
    )

source $ZSH/oh-my-zsh.sh

# export LANG=en_US.UTF-8
# need to disable in order for exa ls alias to work
# DISABLE_LS_COLORS="true"

# FZF settings
export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --color=dark'

# map exa commands to normal ls commands
#alias ll="exa -l -g --icons"
#alias ls="exa --icons -I -d"
#alias lt="exa --tree --icons -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"

# old mac does not have exa, so install lsd
alias ll="lsd -l"
alias ls="lsd"
alias lt="lsd --tree -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"
# show file previews for fzf using bat
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias gig="git log --all --decorate --oneline --graph"
alias sshmine="ssh -F ssh.config"
alias sshno="ssh -F ssh.config -o StrictHostKeyChecking=no"
alias zim="cd $git_location/zim"
alias management="cd $git_location/management"
alias testcoding="cd $git_location/test-coding"
alias mydotfiles="cd $git_location/mydotfiles"
alias vim="/usr/local/bin/nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
