"set guifont=PT\ Mono\ 11
set guifont=DejaVu\ Sans\ Mono\ 10
"set guifont=Ubuntu\ Mono\ 11
set lsp=8
" Remove menu bar
set guioptions-=m
set t_Co=256
set tw=80
set colorcolumn=80

"au BufRead,BufNewFile *.py setlocal textwidth=80
"au BufRead,BufNewFile *.py setlocal colorcolumn=80

" Remove toolbar
set guioptions-=T

execute pathogen#infect()
syntax on
filetype plugin indent on

com W :w
map <C-n> :tabnew<CR>
map <F5> :execute RotateTabs()<CR>
map <F4> :TlistToggle<CR>
map <F12> :Explore<CR>
map <M-m> :ShowMarksToggle<CR>
map '; :ShowMarksClearMark<CR>
map <A-q> {v}!par -jw80<CR>

let b:tabset=0
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set updatecount=0
set nofsync
set autochdir
let g:showmarks_enable=0

colorscheme distinguished
"let g:solarized_termcolors = 256
"colorscheme solarized

function! RotateTabs()
	if b:tabset == 0
		set expandtab
		let b:tabset=1
	else
		set noexpandtab
		let b:tabset=0
	endif
endfunction

autocmd BufRead,BufNewFile *.zcml :set ft=xml 

function! GuiTabLabel()
    " add the tab number
    let label = '['.tabpagenr()
 
    " modified since the last save?
    let buflist = tabpagebuflist(v:lnum)
    for bufnr in buflist
        if getbufvar(bufnr, '&modified')
            let label .= '*'
            break
        endif
    endfor
 
    " count number of open windows in the tab
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= ', '.wincount
    endif
    let label .= '] '
 
    " add the file name without path information
    let n = bufname(buflist[tabpagewinnr(v:lnum) - 1])
    let label .= fnamemodify(n, ':t')
 
    return label
endfunction
 
set guitablabel=%{GuiTabLabel()}
set hlsearch
set cursorline
set autochdir
set mouse=a

" Commenting latex
au BufRead,BufNewFile *.tex map ]% :s/^/%/<CR>
au BufRead,BufNewFile *.tex map ]u :s/^%//<CR>
au BufRead,BufNewFile *.tex set spell wrap linebreak nolist
" au BufRead,BufNewFile *.py set foldmethod=indent

" Markdown
au BufRead,BufNewFile *.md set syntax=markdown

":autocmd BufReadPost * :DetectIndent

:set list listchars=tab:├─,trail:·
set clipboard=unnamed,exclude:cons\\\|linux

filetype plugin on
filetype indent on
let g:tex_flavor='latex'

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

map <leader>N :NERDTreeToggle<CR>
map <leader>c :TagbarToggle<CR>

set foldlevel=20
set foldlevelstart=20

set nu

autocmd BufWritePost *.py call Flake8()

let g:flake8_quickfix_height=4


" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let which_python = a:path
    python3 << EOF
import vim
from os.path import dirname, join, exists
activate_this = join(dirname(vim.eval('l:which_python')), 'activate_this.py')
if exists(activate_this):
    with open(activate_this) as f:
        exec(f.read(), dict(__file__=activate_this))
EOF
endfunction

let pythonenv = system('which python')

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python3")
    call LoadVirtualEnv(pythonenv)
endif

" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1

" should the browser window pop-up upon previewing
let g:livedown_open = 1

" the port on which Livedown server will run
let g:livedown_port = 1337

" the browser to use
let g:livedown_browser = "vivaldi"
