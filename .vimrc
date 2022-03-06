runtime! arch.vim

" Vim jumps to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Vim loads indentation rules and plugins according to the detected filetype.
filetype plugin indent on

" Source a global configuration file if available
syntax enable
set laststatus=2
set noshowmode
set nu rnu
set smartindent
set formatoptions-=o
set termguicolors
set nojoinspaces
set splitbelow splitright
set nostartofline
set hidden nobackup nowritebackup
set cmdheight=2
set updatetime=300
set cursorcolumn
set cursorline

" Vim plugins through vim-plug
call plug#begin('~/.vim/plugged')
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdcommenter'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'mg979/vim-visual-multi'
	Plug 'lervag/vimtex'
	Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
call plug#end()

" whitespace "
highlight ExtraWhiteSpace ctermbg=52
let g:better_whitespace_enabled=1
let g:string_whitespace_on_save=1
let g:string_whitespace_confirm=0
let g:string_whitespace_at_eof=1
let g:better_whitespace_skip_empty_lines=1

" polyglot "
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
"start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
let g:NERDTreeWinSize=20
let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Exit Vim if NERDTree is the only window remaining in the tab
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:lightline = {
	\ 'colorscheme': 'dracula',
	\ 'active': {
	\ 'left': [ [ 'mode', 'paste' ],
	\						[ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\ 	'gitbranch': 'FugitiveHead'
	\ },
	\ }

packadd! dracula
colorscheme dracula

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.locl
endif

" competitive programming "
autocmd FileType cpp nnoremap <leader>rm :!g++ -g --std=c++17 % -o %:r<CR>
autocmd FileType cpp nnoremap <leader>rr :!./%:r<CR>
autocmd FileType cpp nnoremap <leader>rt    :!for f in %:r.*.test; do echo "TEST: $f"; ./%:r < $f; done<CR>

" completion with coc using tab "
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap<expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space> for completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" templates "
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
		autocmd BufNewFile *.java 0r ~/.vim/templates/skeleton.java
		autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html
		autocmd BufNewFile style.css 0r ~/.vim/templates/style.css
		autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
	augroup END
endif
