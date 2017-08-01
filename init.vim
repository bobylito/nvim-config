call plug#begin('~/.config/nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'othree/csscomplete.vim'
  Plug 'roxma/nvim-completion-manager'
  Plug 'Shougo/neco-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'whatyouhide/vim-gotham'
  Plug 'ryanoasis/vim-devicons' " install your font first https://github.com/ryanoasis/nerd-fonts
  Plug 'pangloss/vim-javascript'
  Plug 'mileszs/ack.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'digitaltoad/vim-pug'
  Plug 'ap/vim-css-color'
  Plug 'tpope/vim-fugitive'
call plug#end()

" Useful for using crazy characters in the UI
set encoding=utf8

" Mouse support
set mouse=a

" theme
colors gotham
let g:airline_theme='gotham'

" jk fells more efficient for quitting the insert mode
inoremap jk <Esc>

" Map the leader key to SPACE
let mapleader="\<SPACE>"

set number              " Show the line numbers on the left side.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Share clipboard with system
set clipboard=unnamedplus

" nerdtree specific config
autocmd vimenter * if !argc() | NERDTree | endif " Opens NERDTree only there is no file selected (for git commits)
" If nerdtree is the last buffer, kill it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeFind<CR>     " Open the current file in the tree
autocmd FileType nerdtree setlocal nolist " Prevent glitch 'small plus' display when using devicons

" Ignore git files in CTRL-P
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" javascript specific config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=[ 'eslint' ]
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction
let g:syntastic_javascript_eslint_exec = StrTrim(system('npm-which eslint'))

"" Fix ctrlP from opening in nerdtree https://vi.stackexchange.com/a/11300
function! CtrlPCommand()
  let c = 0
  let wincount = winnr('$')
  " Don't open it here if current buffer is not writable (e.g. NERDTree)
  while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
    exec 'wincmd w'
    let c = c + 1
  endwhile
  exec 'CtrlP'
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'

" Search for the word underneath the cursor
if executable('ag') " Swith to ag if available
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap K :Ack! -w "<C-R><C-W>"<CR>:cw<CR>

let g:airline_inactive_collapse=0
