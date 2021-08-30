call plug#begin('~/.config/nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'othree/csscomplete.vim'
  Plug 'Shougo/neco-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'whatyouhide/vim-gotham'
  Plug 'ryanoasis/vim-devicons' " install your font first https://github.com/ryanoasis/nerd-fonts
  Plug 'pangloss/vim-javascript'
  Plug 'sheerun/vim-polyglot'
  Plug 'jwalton512/vim-blade'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mileszs/ack.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'digitaltoad/vim-pug'
  Plug 'ap/vim-css-color'
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'machakann/vim-highlightedyank'
  Plug 'airblade/vim-gitgutter'
  Plug 'python/black'
  Plug 'sophacles/vim-processing'
  Plug 'tikhomirov/vim-glsl'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sbdchd/neoformat'
  Plug 'prettier/vim-prettier', { 'branch': 'issue/232-adding-support-for-prettier-2.x', 'do': 'npm install'}
  Plug 'milch/vim-fastlane'
  Plug 'bobylito/dank-neon_vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
call plug#end()

"" Useful for using crazy characters in the UI
set encoding=utf8

"" Mouse support
set mouse=a

"" theme
colors "dank-neon"
let g:airline_theme='violet'
set fillchars=stl:^,stlnc:\ ,vert:\|,fold:-,diff:-
hi VertSplit ctermfg=Black ctermbg=DarkGray
hi StatusLine ctermfg=Black ctermbg=DarkGray
hi StatusLineNC ctermfg=Black ctermbg=DarkGray


" jk fells more efficient for quitting the insert mode
inoremap jk <Esc>

"" Map the leader key to SPACE
let mapleader="\<SPACE>"

set number              " Show the line numbers on the left side.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
" set cursorline          " Highlight the current line

"" Tell Vim which characters to show for expanded TABs,
"" trailing whitespace, and end-of-lines. VERY useful!
" if &listchars ==# 'eol:$'
"   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" endif
" set list                " Show problematic characters.

"" Also highlight all tabs and trailing whitespace characters.
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+$\|\t/

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.

"" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

"" Disable Ex mode
map Q <nop>

"" Share clipboard with system
set clipboard=unnamedplus

"" nerdtree specific config
autocmd vimenter * if !argc() | NERDTree | endif " Opens NERDTree only there is no file selected (for git commits)
"" If nerdtree is the last buffer, kill it
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeFind<CR>     " Open the current file in the tree
autocmd FileType nerdtree setlocal nolist " Prevent glitch 'small plus' display when using devicons

"" Ignore git files in CTRL-P
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"" javascript specific config
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

"" Cleanup js by pressing F4
inoremap <silent> <F10> <Esc>:call JavascriptBeautify()<CR><CR>
nnoremap <silent> <F10> :call JavascriptBeautify()<CR><CR>
function! JavascriptBeautify() 
  let l:initialLine = line('.')
  execute '%!eslint_d --stdin --fix-to-stdout'
  execute 'normal '.initialLine.'gg'
  SyntasticCheck()
endfunction

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers=[ 'eslint' ]
" function! StrTrim(txt)
"   return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" endfunction
let g:syntastic_javascript_eslint_exec = 'eslint_d'

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

"" Search for the word underneath the cursor
if executable('ag') " Swith to ag if available
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap K :Ack! -w "<C-R><C-W>"<CR>:cw<CR>

let g:airline_inactive_collapse=0

"" Editorconfig config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"" Highlighted yank config
let g:highlightedyank_highlight_duration = 300

"" Autoformat python files with black, on save
autocmd BufWritePre *.py execute ':Black'

" let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.mdx,*.vue,*.yaml,*.html,*.php,*.yml PrettierAsync
autocmd BufWritePre *.frag,*.vert Neoformat

source ~/.config/nvim/plugins-config/coc.vim

" Limelight colors
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

" Goyo / limelight integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

