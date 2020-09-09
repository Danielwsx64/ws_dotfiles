call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" TMux stuff
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-runner'

" NerdTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Auto insert () {}
Plug 'jiangmiao/auto-pairs'

" Color for #rgb
Plug 'lilydjwg/colorizer'

" Snippets
Plug 'SirVer/ultisnips' " snippets engine
Plug 'honza/vim-snippets' " a package of snippets to varius languages like (ruby, elixir)

" Syntax check
Plug 'vim-syntastic/syntastic'

" Surround text with () {} [] or html tags
Plug 'tpope/vim-surround'

" Repeat plugins commands with .
Plug 'tpope/vim-repeat'

" End block structs with 'end' (elxir/ruby/etc)
Plug 'tpope/vim-endwise'

" Comments
Plug 'tomtom/tcomment_vim'

" Common vim configs
" Plug 'tpope/vim-sensible'

" Use ag in vim
Plug 'rking/ag.vim'

" Git diffs
Plug 'airblade/vim-gitgutter'

" Show ident guides by <leader> ig
Plug 'nathanaelkane/vim-indent-guides'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " just to get branch at status bar

" Color theme
Plug 'altercation/vim-colors-solarized'

" Support Elixir
Plug 'elixir-editors/vim-elixir'

" TypeScript sintax
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" For tests
Plug 'janko-m/vim-test'

" Formatting
Plug 'chiel92/vim-autoformat'

" Completation plugin
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()  } } " Code completation

Plug 'gcmt/taboo.vim'
Plug 'jreybert/vimagit'

call plug#end()
