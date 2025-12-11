source $VIMRUNTIME/defaults.vim

set nowrap
set splitbelow

set nu
set cursorline
set cursorcolumn

set scrolloff=7

set pumheight=7

set laststatus=2

vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

map J mzJ`z

"TODO: how to make this assert fzf.vim is installed
map <c-P> :Files<CR>

"cpp
map <leader>rm <cmd>!rustc % -o %:r<CR>
map <leader>rr <cmd>!./%:r<CR>
map <leader>rt <cmd>!for f in %:r.*.test; do echo 'TEST: $f'; ./%:r < $f; done<CR>

colo seoul256

packadd! matchit
packadd comment
packadd nohlsearch
