if &compatible
  set nocompatible
end

call plug#begin('~/.vim/bundle')

" To read about and get more plugins https://vimawesome.com/

" Define bundles via Github repos
" geral
Plug 'SirVer/ultisnips' " snippets engine
Plug 'honza/vim-snippets' " a package of snippets to varius languages like (ruby, elixir)
Plug 'scrooloose/nerdtree' " file explorer
Plug 'scrooloose/syntastic' " syntax checking
Plug 'tpope/vim-surround' " add or change surround items like () to {}
Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plug 'skwp/vim-colors-solarized' " color schema
Plug 'tpope/vim-repeat' " Allow . to repeat plugins commands
Plug 'tpope/vim-endwise' " Automatic end structures like def end
Plug 'vim-scripts/tComment' " A easy way to comment
Plug 'rking/ag.vim' " Use ag on vim
Plug 'airblade/vim-gitgutter' " Show diffs on files
Plug 'nathanaelkane/vim-indent-guides' " Show ident guides
Plug 'terryma/vim-multiple-cursors' " You can create and use multiple cursors like sublime
Plug 'itchyny/lightline.vim' " pretty status bar
Plug 'jby/tmux.vim' " tmux syntax
Plug 'pbrisbin/vim-mkdir' " create folder if it doesn't exist
Plug 'elixir-lang/vim-elixir' " sintax for elixir
Plug 'keith/rspec.vim' " sintax for rspec
Plug 'janko-m/vim-test' " run tests on vim, (elixir, ruby, others)
Plug 'chiel92/vim-autoformat'
Plug 'iamcco/markdown-preview.vim' " an markdown preview

"javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx' " JSX syntax to react apps

"elixir
Plug 'slashmili/alchemist.vim' " alchemist for elixir (goto definition and complete)

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-git'
Plug 'chrisbra/color_highlight'
Plug 'christoomey/vim-tmux-runner'
Plug 'jiangmiao/auto-pairs'

if filereadable(expand("~/.plugins.vim.local"))
  source ~/.plugins.vim.local
endif

call plug#end()

" Desactivated
" Plug 'andrewradev/splitjoin.vim' " Split structures
" Plug 'mhinz/vim-mix-format' " Run mix formater to elixir code
" Plug 'godlygeek/tabular' " use this to tabular things
" Plug 'tpope/vim-fugitive' " A wrapper for git commands
" Plug 'thoughtbot/vim-rspec' run rspec tests (im using janko-m/vim-test now)
" Plug 'mattn/emmet-vim' " Expand abreviations and use snippets /needs config
" Plug 'jwalton512/vim-blade'
" Plug 'tpope/vim-rails'
" Plug 'vim-ruby/vim-ruby'
