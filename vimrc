" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
syntax on
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

call plug#begin('~/.vim/plugged')
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'sainnhe/edge'
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

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeWinSize=20

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:edge_style = 'aura'
colorscheme edge

let g:lightline = {
	\'colorscheme': 'edge',
	\ }

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" competitive programming "
autocmd FileType cpp nnoremap <leader>rm :!g++ -g --std=c++17 % -o %:r<CR>
autocmd FileType cpp nnoremap <leader>rr :!./%:r<CR>
autocmd FileType cpp nnoremap <leader>rt    :!for f in %:r.*.test; do echo "TEST: $f"; ./%:r < $f; done<CR>

" completion with coc "
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap<expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" templates "
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
		autocmd BufNewFile *.java 0r ~/.vim/templates/skeleton.java
		autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html
		autocmd BufNewFile style.css 0r ~/.vim/templates/style.css
	augroup END
endif
