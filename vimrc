" KCH vimrc 2011

" I'm using Vim 7.3, I did notice problems with 7.0
" Note: As far as I know, this will only work on Unix
" current list of Vim extensions I'm using:
"
" 	Pathogen: easy modular management of plugins
" 	Tagbar: Taglist++, source code browsing (requires exuberant-ctags pkg
	" 	>=v5.5) (currently mapped to <leader>1)
" 	SuperTab: Insert-mode tab completion
" 	Surround: easy mappings for parens, brackets, quotes, etc (e.g. cs'" to
	" 	change single quotes to double quotes
" 	NERDTree: better file explorer, i.e. replaces :Ex and :Vex (mapped to
	"	<leader>2)
" 	NERDCommenter: easy mappings for inserting comments ('<leader>cc' etc in cmd mode to use)
" 	CloseTag: auto-tag closing for HTML/XML
" 	DlimitMate: autocomplete for quotes, parens, brackets, etc.
" 	Fugitive: git integration (e.g. :Gstatus)
" 	Argtextobj: allows function arguments to be edited as vim text objects
" 	Indenttextobj: allows text at same indent level to be edited as vim text
	" 	objects (particularly useful for, e.g., Python)
" 	Grepvim: grep integration (use :Grep, among other things)
" 	Bufexplorer: easy buffer navigation (just use <leader>be)
" 	FuzzyFinder: search files, buffers, tags etc. (e.g. <leader>ff)
	"	-> L9lib: required for FuF
"   Avim: quickly change between source and header files (:A, :AS, :AV) doesn't
	"   seem to be able to find h files in different dirs though
"   VimLaTeX: rich set of tools for editing LaTex
"   AutoloadCscope: forces Cscope to recurse up parent dirs to find the
	"   database (build db with cscope -R -b, add -q to build inverted index for
	"   quicker lookups, add -k when doing kernel/lib hacking to tell cscope to
	"   ignore /usr/include)
"
"
" Use :help <plugin-name> to find out more

" set up pathogen for easy plugin installation and mgmt
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ================
" GENERAL SETTINGS
" ================

" enable syntax highlighting
syntax enable

" show line numbers
set number

" do we really need vi compatibility?
set nocompatible

" better filename completion in vim command line
set wildmode=list:longest,full
set wildmenu

" give me crosshairs
set cursorline
"set cursorcolumn

" tell me when i'm in insert or visual mode
set showmode

" show me the command being typed currently
set showcmd

" don't ding at me
set visualbell

" could save some headaches
" creates .un~ files when you edit and close
set undofile

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab

set encoding=utf-8

" tell Ctags to recurse up directories 
" for the tags file
set tags=tags;/
" use cscope in addition to ctags
source ~/.vim/cscope_maps.vim

" aesthetics
set background=dark

" not all terms are 256 :(
if &t_Co == 256
    colorscheme molokai
endif

" show status line at bottom 0=never, 1=when > 1 window open
" 2=always
set laststatus=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current 
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in 
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

" change <leader> key. defaults is '\', hard to reach
let mapleader=","

" more perl-like regexes in search
"nnoremap / /\v
"vnoremap / /\v

" with these, if you include capitals in a search it'll do
" the right thing, if you just use lowercase,
" it'll be case insensitive
set ignorecase
set smartcase

" %s/p/r -> %s/p/r/g
set gdefault

" highlight search results as I type
set incsearch
set showmatch
" but allow me to get rid of the highlighting afterwards
nnoremap <leader><space> :noh<cr>

" use Tab instead of '%' to match bracket pairs
" nnoremap <tab> %
" vnoremap <tab> %

" line wrapping
set wrap
set textwidth=79
set formatoptions=qrtn1
" tell me when i'm running on too long
"set colorcolumn=85

" always do the expected thing when moving by line
nnoremap j gj
nnoremap k gk

" quick window split with ,w[vh] (vertical, horizontal)
nnoremap <leader>wv <C-w>v<C-w>l
nnoremap <leader>wh <C-w>s<C-w>j

" move around splits faster
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"set up code folding
set nofoldenable     "don't fold by default
set foldmethod=indent   " fold on indentations
set foldnestmax=10   "only fold up to 10 levels
set foldlevel=1     " only show me first fold level

filetype plugin on

" save buffers when we move away from vim
"au FocusLost * :wa

" make backspace smarter
set backspace=indent,eol,start

" key mappings for spell checker (apparently this will do the right thing in
" source files. Use zg to whitelist a word
nnoremap <leader>sp :setlocal spell spellang=en_us<CR>
nnoremap <leader>nsp :setlocal nospell<CR>


" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" do the restore
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	au BufWinEnter * call ResCur()
augroup END

" let me edit my vimrc quickly with ,ev
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" quicker than reaching for escape
inoremap jj <ESC>

" =======================
" PLUGIN-SPECIFIC OPTIONS
" =======================

" === CloseTag ===
" only open closetag for these files
au FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
au FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mko source ~/.vim/bundle/closetag/plugin/closetag.vim

"=== SuperTab ===
" tell SuperTab to use vim's built-in OmniComplete
let g:SuperTabDefaultCompletionType = "context"

"=== Tagbar ===
"make TagBar a little easier: press ',1' in command mode to bring it up
let g:tagbar_usearrows = 1
nnoremap <leader>1 :TagbarToggle<CR>
" Uncomment this line to open Tagbar on startup for code files
" au BufRead *.[ch],*.cpp,*.java,*.js,*.py,*.pl TagbarOpen

"=== NERDTree ===
nnoremap <leader>2 :NERDTreeToggle<CR>

"=== FuzzyFinder ===
nnoremap <leader>ff :FufFile<CR>   " search files
nnoremap <leader>fb :FufBuffer<CR> " search buffers
nnoremap <leader>fd :FufDir<CR>    " search directories

