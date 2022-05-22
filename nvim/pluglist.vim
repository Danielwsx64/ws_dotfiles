call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')


" Godot stuff
Plug 'clktmr/vim-gdscript3'

" TMux stuff
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" NerdTree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Auto insert () {}
Plug 'jiangmiao/auto-pairs'

" Color for #rgb
Plug 'lilydjwg/colorizer'

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

" Snippets
Plug 'honza/vim-snippets' " a package of snippets to varius languages like (ruby, elixir)

" Replace files
Plug 'Danielwsx64/greplace'

" Git diffs
Plug 'airblade/vim-gitgutter'

" Show ident guides by <leader> ig
Plug 'nathanaelkane/vim-indent-guides'

" Multiple cursors
Plug 'mg979/vim-visual-multi'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " just to get branch at status bar

" Color theme
Plug 'haishanh/night-owl.vim'

" Support Elixir
Plug 'elixir-editors/vim-elixir'

" TypeScript sintax
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" For tests
Plug 'vim-test/vim-test'

" Formatting
Plug 'chiel92/vim-autoformat'

" Terraform
Plug 'hashivim/vim-terraform'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Completation plugin
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()  } } " Code completation

Plug 'gcmt/taboo.vim'
Plug 'jreybert/vimagit'

call plug#end()
