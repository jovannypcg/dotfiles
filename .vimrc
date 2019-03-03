execute pathogen#infect()
syntax on
filetype plugin indent on

call plug#begin()
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
call plug#end()

" FZF
set rtp+=~/.fzf

" Appearance
set background=dark
colorscheme allomancer
set colorcolumn=80
set hlsearch 	" Highlight search results by default toggle off with :nohlsearch
set laststatus=2 " Always show status line.
set mouse=a 	" Mouse in all modes
set mousehide 	" Hide mouse after chars typed
set number 	" Line numbers on
set novisualbell " No blinking .
set nowrap 	" Line wrapping off
" set ruler 	" Ruler on, show cursor <line>,<column> in the status
set showmatch 	" Show matching brackets...
set mat=5 	" ...blink the cursor over matching bracket
set guifont=Hack\ Nerd\ Font:h14

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
set foldmethod=syntax
set foldlevel=5

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
