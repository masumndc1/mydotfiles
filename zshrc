# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
#export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3.8
#export VIRTUALENVWRAPPER_VIRTUALENV=~/Library/Python/3.8/bin/virtualenv
# "curl: (35) error:06FFF089:digital envelope routines:CRYPTO_internal:bad key length"
export CURL_SSL_BACKEND="secure-transport"

# Path to your oh-my-zsh installation.
export ZSH="/Users/khuddin/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/.zplug/init.zsh
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
zplug "junegunn/fzf", from:gh-r, as:command
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
    zsh-syntax-highlighting
    zsh-autosuggestions
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
alias ll="exa -l -g --icons"
alias ls="exa --icons -I -d"
alias lt="exa --tree --icons -a -I '.git|__pycache__|.mypy_cache|.ipynb_checkpoints'"

# show file previews for fzf using bat
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias load_key="ssh-add -s /usr/local/lib/opensc-pkcs11.so"
alias unload_key="ssh-add -e /usr/local/lib/opensc-pkcs11.so"
alias dev="cd ~/Documents/csc_dev/"
alias project="cd ~/Documents/tasks/project/"
alias acb="cd ~/Documents/csc_dev/ansible-cloud-bootstrap/"
alias aka="cd ~/Documents/csc_dev/ansible-kaj-admin/"
alias gig="git log --all --decorate --oneline --graph"
alias sshmine="ssh -F ssh.config"
alias sshno="ssh -F ssh.config -o StrictHostKeyChecking=no"
alias zim="cd ~/Documents/bektigoto/zim"
alias management="cd ~/Documents/bektigoto/management"
alias testcoding="cd ~/Documents/bektigoto/test-coding"
alias vim="/usr/local/bin/nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
