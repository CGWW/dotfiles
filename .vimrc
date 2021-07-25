set noerrorbells
set relativenumber
set nu
set smartindent
set shiftwidth=4
set expandtab
set incsearch
set noswapfile
set nohlsearch
set termguicolors
set scrolloff=8
set mouse=a
set noshowmode " vim-airline has this
set clipboard+=unnamed
nnoremap <SPACE> <Nop>

let mapleader = " "

" filetype plugin on
" syntax on
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'dense-analysis/ale'
Plug 'tomtom/tcomment_vim'
"" Plug 'kassio/neoterm'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

call plug#end()

" grubbox settings
let g:gruvbox_invert_selection = 0
colorscheme gruvbox
colorscheme codedark
set background=dark

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" highlight yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END

" Press F9 to run python script
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>


" " ALE settings
" let g:ale_linters_explicit = 1
" let g:ale_linters = {
"     \ 'python': ['flake8', 'pylint'],
"     \}
" let g:ale_fixers = {
"     \   'python': [ 'black' ],
"     \}
" let g:ale_fix_on_save = 1

" COC
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" open new split panes to right and below
set splitright
set splitbelow

" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" jump to buffer right after ls
nnoremap <leader>ls :ls<cr>:b

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" use ctrl+hjkl to move between split/vsplit panels
tnoremap <c-h><C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l
nnoremap <c-h> <C-w>h
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-l> <C-w>l


" Begin of airline settings
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " get rid of showing utf-8[unix]
let g:airline_theme = 'codedark'

let g:airline_section_z = '%3p%% %3l/%L:%3v'                 " shorten and simplify the z section i.e. line status
let g:airline#extensions#tabline#fnamemod = ':t'             " dont show full path



" Treesitter modules
" Higlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF


lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
    indent = {
        enable = true
    }
 }
