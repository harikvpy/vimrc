set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" YouCompleteMe for auto code completion tips (needs compilation!)
Plugin 'Valloric/YouCompleteMe'
" Easity see a list of Most Recently Used files
Plugin 'yegappan/mru'
" NERDTree file explorer
Plugin 'scrooloose/nerdtree'
" Wrapper arround Ack, the better grep (requires ack to be installed in the OS)
Plugin 'mileszs/ack.vim'
" For a better and more informative statusline
Plugin 'vim-scripts/statusline.vim'
" buffer explorer to quickly navigate between various edit buffers
Plugin 'jlanzarotta/bufexplorer'
" contains a function to refresh firefox browser page
Plugin 'harikvpy/refreshbrowser'
" snippets to expand shortcuts into code
Plugin 'SirVer/ultisnips'
" snippents themselves
Plugin 'honza/vim-snippets'
" python/django hotkey reference
Plugin 'xolox/vim-misc.git'
Plugin 'xolox/vim-pyref.git'
" Django plugin for Dmodels, Durls, Dviews
Plugin 'jmcomets/vim-pony.git'
" Grep from inside VIM, but one that supports replace as well
Plugin 'dkprice/vim-easygrep.git'
" Simple tasklist that accumulates all TODO & FIXME comments from source
Plugin 'vim-scripts/TaskList.vim'
" Javascript settings
Plugin 'pangloss/vim-javascript'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme desert          " My preferred colorscheme
set nu                      " show line numbers on left
set columns=85              " column size 
"set lines=51               " lines depends on the display and its display 
                            " resolution. Therefore we defer that to .localvimrc
syntax on                   " turn on syntax highlighting
set nowrap                  " turn off long line wrapping
set ruler                   " show ruler at the bottom of the buffer
set cmdheight=1             " height of command bar, 1 line
set encoding=utf8           " file encoding, UTF-8
set ffs=unix                " fileformat is unix; ie., EOL is \n only
set showmatch               " highlight matching brace
set noerrorbells            " suppress annoying bells
set novisualbell
set lazyredraw              " do not redraw during macro execution
set magic                   " turn on regular expressions
set nobackup                " No need for backups with robust SCMs in place
set nowb                    " modern file systems makes write backup redundant
set noswapfile              " swapfiles are not necessary either
set smarttab                " insert 'shiftwidth' spaces when <tab>ed in front of a line
set shiftwidth=4            " number of spaces to insert at the beginning of a line for <tab>
set tabstop=4               " my preferred tabstop size
set expandtab               " expand all tabs to equivalent spaces
set autoindent              " automatic indentation on pressing Enter
set smartindent             " smart indentation
set ignorecase              " ignore case while searching
set hlsearch                " highlight all search results
set incsearch               " highlight search matches as pattern is being typed
set lbr
set tw=500                  " change default text width of 78 to 79
set colorcolumn=81

let mapleader=","           " remap <leader> key to comma
let g:mapleader=","

" KEYBOARD SHORTCUTS

" quickly save current file 
nmap <leader>s :w!<cr>
" close current buffer
nmap <leader>c :bd<cr>
" close window
nmap <leader>w <C-W>c
" navigate between visible windows using the standard hjkl keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" ignore itermediate files
set wildignore=*.o,*.~,*.pyc

" Enable persistent undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Plugin configurations and customization

" NERDTree
let NERDTreeChDirMode=2
" regexps pf filenames to ignore
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" file/folder sort order
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
" Always show NERDTree bookmarks
let NERDTreeShowBookmarks=1
" always highlight cursor line
let NERDTreeHighlightCursorline=1
" default view size, 35 columns
let NERDTreeWinSize=33
" Don't use extended characters for arrowheads for the tree
let NERDTreeDirArrows=0
" auto close NERDTree upon opening a file
let NERDTreeQuitOnOpen=1
" shortcut for NERDTree
nmap <leader>n :NERDTreeToggle<CR>

" Buffer explorer
let g:bufExplorerSortBy='fullpath'   " sort by the buffer's name
let g:bufExplorerReverseSort=0
" shortcut to see bufexplorer window
nmap <leader>b :BufExplorer<CR>

" MRU
nmap <leader>f :MRU<CR>

" shortcut for Ack macro
nmap <leader>a :Ack!<CR>

" cycle through buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" ultisnips expand trigger
let g:UltiSnipsExpandTrigger="<F4>"
let	g:snips_author='Hari Mahadevan'
let g:snips_email='harikvpy@gmail.com'
let g:snips_github='https://github.com/harikvpy'

" reload statusline plugin whenever colorscheme is changed
autocmd! ColorScheme * source ~/.vim/bundle/statusline.vim/plugin/statusline.vim

" Function to customize the colors for pretty statusline 
function! SetStatuslineColors()
    hi User1 ctermfg=0 ctermbg=1 guifg=#112605 guibg=#aefe7B gui=italic
    hi User2 ctermfg=3 ctermbg=1 guifg=#391100 guibg=#d3905c gui=italic
    hi User3 ctermfg=3 ctermbg=4 guifg=#292b00 guibg=#f4f597 gui=italic
    hi User4 ctermfg=3 ctermbg=4 guifg=#051d00 guibg=#7dcc7d gui=italic
    hi User5 ctermfg=0 ctermbg=1 guifg=#002600 guibg=#67ab6e gui=italic
endfunction

" function to set statusline colors and reload the statusline plugin
function! ReloadStatusline()
    call SetStatuslineColors()
    source ~/.vim/bundle/statusline.vim/plugin/statusline.vim
endfunction

call SetStatuslineColors()

" Restoring session through the above causes the colorful statusline 
" to lose its colors. So we need to reload it using an autocmd.
" Note how we use a function to do this. This seems to work consistently well.
autocmd VimEnter * call ReloadStatusline()

" Function restores previously saved vim session.
" Session is restored only if vim is started without any file arguments.
function! RestoreSession()
    let filespecified = 0
    for arg in argv()
        if len(findfile(arg)) > 0
            let filespecified = 1
            break
        endif
    endfor
    if filespecified == 0
        " if no files were specified in commandline, load previous session
        execute 'source ~/.vimsession'
        " open NERDTree as well
        NERDTree
        " go to last accessed window (equivalent to CTRL-W p)
        wincmd p
    endif
    call ReloadStatusline()
endfunction

" Restore session on startup
autocmd VimEnter * call RestoreSession()

" Function to quit VIM while saving the current session.
" Note that if NERDTree was open closes it first before saving session.
" This will avoid the nasty NERDTree restoration problem when VIM auto
" reloads the previous session during startup.
function! QuitSavingSession()
    NERDTreeClose 
    mksession! ~/.vimsession
    :wqa<CR>
endfunction

" shortcut to quit VIM while saving current session, which will be restored
" if VIM is started without any arguments
nmap <leader>q :call QuitSavingSession()<CR>

" function to insert UUID at the current cursor position
function! InsertUUID()
py << EOF
import uuid
import vim
vim.command("normal i"+str(uuid.uuid4()))
EOF
endfunction
" now map a key to invoke the above function
nmap <leader>g :call InsertUUID()<CR>

" hotkey for pyref context sensitive help
let g:pyref_python = '/usr/share/doc/python2.7/html'
let g:pyref_mapping = 'H'

" Function to highlight current line.
"
" Needs to be a function so that the highlighting preferences are
" properly initialized across session restoration that occurs during
" program load. Without the autocmd at the bottom of the function
" highlighting preferences won't be properly initialized.
function s:HighlightCurrentLine()
    set cursorline
    setlocal cursorline
    hi cursorline cterm=none ctermbg=magenta ctermfg=white
    hi cursorcolumn cterm=none ctermbg=magenta ctermfg=white
endfunction
autocmd VimEnter * call s:HighlightCurrentLine()

" Function to remove trailing blanks from lines. 
" This is especially useful for Python and Ruby
" programs that interpret source code in a positional way.
function! DeleteTrailingBlanks()
    exec "normal mz"
    " search for trailing whitespaces and replace them with none
    %s/\s\+$//ge
    exe "normal `z"
endfunction
" Force the above function to be invoked when python buffers are written
autocmd BufWrite *.py :call DeleteTrailingBlanks()

" Read local settings for any machine specific settings
if filereadable(glob("~/.localvimrc"))
    source  ~/.localvimrc
endif

" set tabstop/shiftwidth space for JS files to 2
autocmd Filetype javascript setlocal ts=2 sw=2

" keyboard shortcut to refresh firefox page
nmap <leader>r :call RefreshBrowser()<CR>
