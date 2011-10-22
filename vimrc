" KCH vimrc 2011

" assumes Vim 7.0 or greater
" current list of Vim extensions I'm using
" 	gitvim:  git integration 
" 	Pathogen: easy modular management of plugins
" 	Tagbar: Taglist++, source code browsing (requires exuberant-ctags pkg
" 			>=v5.5
" 	SuperTab: Insert-mode tab completion
" 	Surround: easy mappings for parens, brackets, quotes, etc
" 	NERDTree: better file explorer, i.e. replaces :Ex and :Vex
" 	NERDCommenter: easy mappings for commenting (',cc' etc in cmd mode to use)
" 	CloseTag: auto-tag closing for HTML/XML
" 	DlimitMate: autocomplete for quotes, parens, brackets, etc.
" 	Fugitive: git integration
"
" Use :help <plugin-name> to find out more

" set up pathogen for easy plugin installation
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax enable
set number
" tab settings
set tabstop=4
set shiftwidth=4

" tell Ctags to recurse up directories 
" for the tags file
set tags=tags;/
set background=dark

" i think default is '\', replace this
let mapleader=","

" not all terms are 256 :(
if &t_Co == 256
    colorscheme solarized
endif

" set up code folding
set nofoldenable     "don't fold by default
set foldmethod=indent   " fold on indentations
set foldnestmax=10   "only fold up to 10 levels
set foldlevel=1     " only show me first fold level

filetype plugin on

"for CloseTag extension
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mko source ~/.vim/bundle/closetag/plugin/closetag.vim

" tell SuperTab to use vim's built-in OmniComplete
let g:SuperTabDefaultCompletionType = "context"

"make TagBar a little easier: press ',1' in command mode to bring it up
let g:tagbar_usearrows = 1
nnoremap <leader>1 :TagbarToggle<CR>


" Uncomment this line to open Tagbar on startup
" autocmd VimEnter * nested TagbarOpen
" TODO: make the above only happen in ctagged dirs
"

