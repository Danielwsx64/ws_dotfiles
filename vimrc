" Leader
let mapleader = " "

set backspace=2       " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile        " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000      " a lot of history
set ruler             " show the cursor position all the time
set hlsearch
set showcmd           " display incomplete commands
set incsearch         " do incremental searching
set laststatus=2      " Always display the status line
set autowrite         " Automatically :write before running commands
set ignorecase        " Ignore case when searching...
set smartcase         " ...unless we type a capital
set showmode          " Show current mode down the bottom
" set visualbell                                                                   " No noise
set nowrap            " Don't wrap lines
set foldmethod=syntax " Turn on folding
set nofoldenable      " Open file with all fold opened

set belloff=all
set hidden            " Allow switch beteewn buffers without save
syntax on


" ================= Config For elixir-ls + COC ============
let g:elixirls = {
      \ 'path': printf('%s', '/home/daniel/.ws_dotfiles/vim/bundle/elixir-ls'),
      \ }

let g:elixirls.lsp = printf(
      \ '%s/%s',
      \ g:elixirls.path,
      \ 'release/language_server.sh')
" ========================= END ===========================


so ~/.vim/plugins.vim

" laod custom settings
so ~/.vim/settings.vim

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
" Use Ag over Grep
" set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" let g:ctrlp_user_command =
"     \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

" Define composer.json as anchor to root path on laravel projects
" set ag to ignore /vendor folder in laravel projects
" set ag to ignore /node_modules folder in react/npm projects
" let g:ctrlp_user_command = {
"       \ 'types': {
"       \   1: ['composer.json', 'ag %s -l --hidden -g "" --ignore ".git" --ignore "vendor/" | egrep -v "\.(git|hg|svn)/|.log$"'],
"       \   2: ['package.json', 'ag %s -l --hidden -g "" --ignore ".git" --ignore "node_modules/" | egrep -v "\.(git|hg|svn)/|.log$"'],
"       \ },
"       \ 'fallback': 'ag %s -l --hidden -g "" --ignore ".git" | egrep -v "\.(git|hg|svn)/|.log$"'
"       \ }

" ag is fast enough that CtrlP doesn't need to cache
" let g:ctrlp_use_caching = 0
" endif
" Default to filename searches
" let g:ctrlp_by_filename = 1

" open same file in other pane
let g:ctrlp_switch_buffer = 'et'
" ignore folders
set wildignore+=*/node_modules/*,*/_build/*,*/deps/*,*/.elixir_ls/*
" dont cache
let g:ctrlp_use_caching = 0

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5
" Make easy to navigate
set relativenumber

" enable list of completion
set wildmode=list:longest,list:full

" skip tmp files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.cache

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_eruby_ruby_quiet_messages =
"       \ {"regex": "possibly useless use of a variable in void context"}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" automatically rebalance windows on vim resize
" autocmd VimResized * :wincmd =

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


let is_tmux = $TMUX
if is_tmux != ""
  autocmd VimEnter * VtrAttachToPane
endif

" set test.vim configurations to run tests
if is_tmux != ""
  let test#strategy = "vtr" " run commands using Vim Tmux Runner
endif

let test#filename_modifier = ":p" " use absolute test path (fix elixir umbrela issue)

let g:solarized_termtrans=1
syntax enable
set background=dark
colorscheme solarized

au BufWrite * :Autoformat
let g:formatters_javascript = ['prettier']
let g:formatters_javascript_jsx = ['prettier']
" let g:autoformat_verbosemode=1

autocmd FileType yaml let b:autoformat_autoindent=0
autocmd FileType conf let b:autoformat_autoindent=0

" Define vim-ident-guides schema color
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black   ctermbg=10
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=gray ctermbg=0

call coc#config('languageserver', {
      \ 'elixir': {
      \   'command': g:elixirls.lsp,
      \   'trace.server': 'verbose',
      \   'filetypes': ['elixir', 'eelixir']
      \ }
      \})

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
