" ================================
" Vim configuration
" ================================

" ================================
" Compatibility & basic setup
" ================================
set nocompatible

" ================================
" Plugin management (pathogen)
" ================================
execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" ================================
" Leader key
" ================================
let mapleader = " "

" ================================
" Syntax highlighting & colors
" ================================
syntax enable
set termguicolors
silent! colorscheme codedark

" ================================
" User interface
" ================================
set mouse=a
set number
set laststatus=2
set updatetime=100
set showmode
set clipboard=unnamedplus

" ================================
" Statusline helpers
" ================================
function! PasteIndicator()
    return &paste ? ' [PASTE]' : ''
endfunction

set statusline+=%{PasteIndicator()}

" ================================
" Whitespace visualization
" ================================
highlight RedundantSpc term=standout ctermbg=blue guibg=blue
match RedundantSpc /\s\+$\| \+\ze\t/
set list
set listchars=tab:»·,trail:·,nbsp:·

" ================================
" Search behavior
" ================================
set hlsearch
set ignorecase

" ================================
" Indentation
" ================================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Makefiles require real TABs
autocmd FileType make setlocal noexpandtab

" ================================
" Clipboard integration
" ================================
if has('clipboard')
    " Sync yank, delete and change with system clipboard
    set clipboard=unnamedplus

    " Toggle paste mode to avoid auto-indentation issues
    set pastetoggle=<F2>
endif

" Paste from system clipboard in insert mode
inoremap <C-v> <C-r>+

" ================================
" Paste mode toggle (leader)
" ================================
nnoremap <leader>p :set paste!<CR>

" ================================
" Plugin configuration
" ================================

" Emmet
let g:user_emmet_leader_key = ','

" GitGutter
set signcolumn=yes
let g:gitgutter_enabled = 1

" ================================
" Function key mappings
" ================================
nnoremap <F2> :set number!<CR>
nnoremap <F4> :set colorcolumn=80<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F9> :make<CR>

" ================================
" Disable acustic bells
" ================================
set belloff=all
set visualbell
set t_vb=

