set ai
set si
set background=dark
set shiftwidth=4
set wrapmargin=0
set wrap
set linebreak
set number
set tabstop=4
set expandtab
set laststatus=2
set display=lastline
set formatoptions=l
set textwidth=80
set nolist                                  " list disables linebreak
set scrolloff=3                             " keep 3 lines when scrolling
set showcmd                                 " display incomplete commands
set hlsearch                                " highlight searches
set incsearch                               " do incremental searching
set ruler                                   " show the cursor position all the time
set ignorecase                              " ignore case when searching
set title                                   " show title in console title bar
set modeline                                " last lines in document sets vim mode
set modelines=3                             " number lines checked for modelines
set shortmess=atI                           " Abbreviate messages
set nostartofline                           " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]               " move freely between files
set viminfo='20,<50,s10,h
set clipboard+=unnamed                      " yank and copy to X clipboard
set backspace=2                             " full backspacing capabilities
set completeopt=noinsert,menuone,noselect   " nvim completion manager
set shortmess+=c                            " suppress annoying msg of ncm2"
set splitbelow
set splitright
set autoindent
set nocompatible
syntax enable
filetype plugin indent on                   " set this for indent freaking out

" use plug installer and use single quote
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'voldikss/vim-floaterm'
Plug 'joom/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'maxboisvert/vim-simple-complete'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'majutsushi/tagbar'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'
Plug 'sbdchd/neoformat'
Plug 'flazz/vim-colorschemes'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tomtom/tlib_vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'rodjek/vim-puppet'
Plug 'saltstack/salt-vim'
Plug 'nvie/vim-flake8'
Plug 'hashivim/vim-terraform'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ingydotnet/yaml-vim'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'wellle/tmux-complete.vim'
Plug 'scrooloose/nerdtree'
Plug 'pearofducks/ansible-vim'
Plug 'chase/vim-ansible-yaml'
Plug 'Yggdroot/indentline'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'tbastos/vim-lua'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
Plug 'andrewradev/splitjoin.vim'
Plug 'junegunn/gv.vim'
Plug 'numirias/semshi'
Plug 'Shougo/deoplete.nvim',
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
call plug#end()

" mapping
map <C-n> :NERDTree<CR>
map <C-f> :NERDTreeFocus<CR>
map <C-x> :NERDTreeClose<CR>
map <C-t> :NERDTreeToggle<CR>
map <C-g> :TagbarToggle<CR>
map <C-s> :set list!<CR>

let g:python3_host_prog = '/usr/local/bin/python3'
let g:gruvbox_contrast_dark = 'hard'
let g:semshi#filetypes = ['python']
let g:deoplete#enable_at_startup = 1
let g:floaterm_keymap_toggle = '<C-w>'
let g:floaterm_borderchars = ''
let g:floaterm_title = ''
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:ale_linters = {
            \ 'python': ['flake8', 'pylint'],
            \ 'lua': ['luac'],
            \ }
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ }
let g:ale_fix_on_save = 1
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:ansible_unindent_after_newline = 1
let g:ansible_extra_syntaxes = "sh.vim ruby.vim"
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:indentLine_enabled = 1
let g:indentLine_setConceal = 1
let g:indentLine_faster = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:rainbow_active = 1
let g:ncm2#popup_delay = 5
let g:ncm2#matcher = 'substrfuzzy'
let g:ncm2#complete_length = [[1, 1]]
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeMinimalMenu = 1
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 40

" make hightlighted/selected text white comments to darkgreen
hi Visual term=reverse cterm=reverse guibg=Grey
hi Pmenu ctermbg=black guibg=black
hi comment guifg=#008700

" use 256bit terminal colors
if exists('+termguicolors')
    set termguicolors
endif

" set following if there is no nvim
if !has("nvim")
    set ttyfast                                 " smoother changes
    set term=xterm-256color
endif

colorscheme gruvbox
