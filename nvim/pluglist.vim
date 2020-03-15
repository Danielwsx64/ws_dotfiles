call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')


" TMux navigation
Plug 'christoomey/vim-tmux-navigator'

" NerdTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


call plug#end()
