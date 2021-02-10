" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

let mapleader = " "

call plug#begin('~/.vim/plugged')

" Lightline status-bar
Plug 'itchyny/lightline.vim'
" Autocomplete brackets, quotes, tags
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" Color Themes
" Plug 'tomasr/molokai'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Nerdtree - file explorer
Plug 'scrooloose/nerdtree'
" Syntax checking
Plug 'scrooloose/syntastic'
" Commenting
Plug 'scrooloose/nerdcommenter'
" Auto-code completion
Plug 'valloric/youcompleteme'
" Highlight yanks
Plug 'machakann/vim-highlightedyank' 
"Highlight corresponding blocks
Plug 'andymass/vim-matchup' 
" Git integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Full path fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'

call plug#end()

" Turn on syntax highlighting.
syntax on

" Visual setting
syntax enable
set background=dark
colorscheme gruvbox
set cursorline

" Highlight cursorline, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" NERDTree Config
" This section covers all NERDTree configurations

" Open NERDTree on starting vim with no commandline arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Shortcut to open NERDTree
nnoremap <Leader>f :NERDTreeToggle<CR>

" Search files using NERDTree
"nnoremap <silent> <Leader>v:NERDTreeFind<CR> 

" Close vim if only window open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Aumatically reload files
set autoread

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" End NERDTree Config

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" ===================================================================================
" CUSTOM FUNCTIONS
" ===================================================================================

" toggle between line number and relative line number
function! ToggleLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

command! LineNumberToggle call ToggleLineNumber()

function! ToggleColorColumn()
    if &colorcolumn == ""
        set colorcolumn=88
    else
        set colorcolumn=
    endif
endfunc

command! ColorColumnToggle call ToggleColorColumn()

" =================================================================================

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" Setting tabs to 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" No wrapping of lines
set nowrap

" Removing swap files and backups
set noswapfile
set nobackup

" ====================================================================================
" Fuzzy file search configurations
" ====================================================================================

let g:ctrl_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'


" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" use system clipboard
"set clipboard=unnamed

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" ====================================================================================
" Custom Shortcuts
" ====================================================================================

nnoremap <Leader>ol :ColorColumnToggle<CR>
nnoremap <Leader>on :LineNumberToggle<CR>

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

