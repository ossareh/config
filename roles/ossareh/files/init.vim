" Plugins will be downloaded under the specified directory.
call plug#begin()

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'pearofducks/ansible-vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'

" theme plugins
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'

" development plugins
Plug 'psf/black'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_transparent_background = 1
let g:tokyonight_enable_italic = 0
let g:airline_theme = 'tokyonight'

colorscheme tokyonight

" interface setup
set number relativenumber
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 1

" split setup
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

set splitbelow
set splitright
