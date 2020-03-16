" ==========================
" Config For elixir-ls + COC
" ==========================

let g:elixirls = {'path': printf('%s', '~/.config/nvim/plugged/elixir-ls')}
let g:elixirls.lsp = printf('%s/%s', g:elixirls.path, 'release/language_server.sh')

function! g:elixirls.compile(...)
  let l:commands = join([
        \ 'mix local.hex --force',
        \ 'mix local.rebar --force',
        \ 'mix deps.get',
        \ 'mix compile',
        \ 'mix elixir_ls.release'
        \ ], '&&')

  echom '>>> Compiling elixirls'
  silent call system(l:commands)
  echom '>>> elixirls compiled'
endfunction

" ==========================
" Default Configs
" ==========================
set encoding=utf-8
set fillchars=vert:\|
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE
set colorcolumn=80

" Numbers
set number
set numberwidth=5
set relativenumber

" open splits
set splitbelow
set splitright

command W w
command Wa wa
command Q q
command Qa qa

" Load other configs
so ~/.config/nvim/pluglist.vim
so ~/.config/nvim/plugconfig.vim
so ~/.config/nvim/keymapping.vim
