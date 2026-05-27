source $VIMRUNTIME/defaults.vim

set regexpengine=0
syntax on

set ttimeoutlen=10

set termguicolors

set nowrap
set splitbelow

set nu rnu
set cursorline
set cursorcolumn
set colorcolumn=80

set scrolloff=7

set pumheight=7

set laststatus=2

set hlsearch
set incsearch

set statusline=%<%h%m%r%{FugitiveStatusline()}\ %f%=%-14.(%l,%c%V%)\ %P

set shortmess-=S

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

"non-recursive map
nnoremap J mzJ`z

"TODO: how to make this assert fzf.vim is installed
map <c-P> :GFiles<CR>

"cpp
map <leader>rm <cmd>!rustc % -o %:r<CR>
map <leader>rr <cmd>!./%:r<CR>
map <leader>rt <cmd>!for f in %:r.*.test; do echo 'TEST: $f'; ./%:r < $f; done<CR>

colo seoul256

packadd! matchit
packadd comment
packadd nohlsearch
