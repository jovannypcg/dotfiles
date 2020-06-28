execute pathogen#infect()
syntax on
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" To install the plugins, run `:PlugInstall`
call plug#begin()
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  " Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'scrooloose/nerdtree'
  Plug 'guns/vim-clojure-static'
  Plug 'tpope/vim-fireplace'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/paredit.vim'
  Plug 'luochen1990/rainbow'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

" let g:airline_theme='luna'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" FZF
set rtp+=~/.fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Appearance
colorscheme darcula

set background=dark
set t_Co=256
set colorcolumn=0
set hlsearch 	" Highlight search results by default toggle off with :nohlsearch
set laststatus=2 " Always show status line.
set mouse=a 	" Mouse in all modes
set mousehide 	" Hide mouse after chars typed
set novisualbell " No blinking .
set nowrap 	" Line wrapping off
" set ruler 	" Ruler on, show cursor <line>,<column> in the status
set showmatch 	" Show matching brackets...
set mat=5 	" ...blink the cursor over matching bracket
set guifont=Hack\ Nerd\ Font:h16
" Line number
set nu! " Line numbers on
set rnu!
" highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Whitespace adjustments
set autoindent  " auto-indent on entering insert mode
set backspace=2 " Backspace over everything in insert mode
set expandtab 	" expand tabs into spaces based on softtabstop
set list  " Show ↵  at end of line and trailing space as ~, and tabs as |→→→
          " - format is controlled by listchars or lcs setting
set listchars=tab:\|→,eol:↵,trail:~,extends:>,precedes:…
set shiftwidth=2  " Tabs under smart indent
set smarttab      " Make Tab insert spaces based on 'shiftwidth'. 'tabstop' or 'softtabstop'
set softtabstop=2 " Tabs are 2 spaces
set tabstop=2 " Tabs are 2 spaces

" Development
syntax enable
set nofoldenable    " disable folding
set foldmethod=syntax
set foldlevel=5
set autoread

" Abbreviations


" - Ruby
inoreabbr doe do<CR>end<ESC>O<BS>
inoreabbr doa do \|args\|<CR>end<ESC>?args<CR>
inoreabbr defi def instance_method<CR>end<ESC>?instance_method<CR>vec
inoreabbr defc def self.class_method<CR>end<ESC>?class_method<CR>vec
inoreabbr attra attr_accessor :<ESC>a
" " - RSpec
" inoreabbr descc describe ClassName do<CR>end<ESC>?ClassName<CR>h
inoreabbr descm describe 'method' do<CR>end<ESC>?method<CR>h
inoreabbr cont context 'description' do<CR>end<ESC>?description<CR>h
inoreabbr it' it 'meets some expectation' do<cr>end<esc>o
" inoreabbr exp expect(actual).to eq(expected)<ESC>^/\(actual\\|expected\))<CR>b

" NERDTree
let NERDTreeShowHidden=1

" Mappings
nnoremap <C-b> :Buffers<CR>
noremap <Up> :Files<CR>
inoremap <Up> <NOP>
noremap <Down> <NOP>
inoremap <Down> <NOP>
noremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Right> <NOP>
nnoremap <C-e> :Eval<CR>
nnoremap E :%Eval<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
nnoremap j jzz
nnoremap k kzz
nnoremap G Gzz
