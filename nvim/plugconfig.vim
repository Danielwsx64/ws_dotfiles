" ======================
" Nerdtree configuration
" ======================

let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
let NERDTreeNodeDelimiter = "\u263a" " smiley face"

augroup nerdtree
  autocmd!
  autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
  autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
augroup END

function! ToggleNerdTree()
  if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
    :NERDTreeFind
  else
    :NERDTreeToggle
  endif
endfunction


let NERDTreeShowHidden=1
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged" : "═",
      \ "Deleted" : "✖",
      \ "Dirty" : "✗",
      \ "Clean" : "✔︎",
      \ 'Ignored' : '☒',
      \ "Unknown" : "?"
      \ }

" ======================
" Solarized configuration
" ======================

syntax enable
set background=dark
colorscheme solarized


" ======================
" Syntastic configuration
" ======================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" ======================
" AirLine configuration
" ======================

let g:airline_powerline_fonts=1
let g:airline_theme='solarized_flood'
let g:airline_solarized_bg='dark'

" ======================
" Theme configuration
" ======================

let g:solarized_termtrans=1
set background=dark
colorscheme solarized
set guifont=FuraCode\ Nerd\ Font\ 12 " for devicons

" ======================
" CtrlP configuration
" ======================

let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_use_caching = 0
set wildignore+=*/node_modules/*,*/_build/*,*/deps/*,*/.elixir_ls/*

" ======================
" Tmux Stuff
" ======================

let is_tmux = $TMUX

if is_tmux != ""
  autocmd VimEnter * VtrAttachToPane
endif

if is_tmux != ""
  let test#strategy = "vtr" " run commands using Vim Tmux Runner
endif

" ======================
" Test Stuff
" ======================

let test#filename_modifier = ":p" " use absolute test path (fix elixir umbrela issue)

" ======================
" AutoFormat Stuff
" ======================
let g:python3_host_prog="/usr/bin/python3"

au BufWrite * :Autoformat

" fix broken ts formatter
let g:formatdef_my_custom_ts = '"prettier --stdin-filepath ".expand("%:p").(&textwidth ? " --print-width ".&textwidth : "")." --tab-width=".shiftwidth()'
let g:formatters_typescript = ['my_custom_ts']
" let g:autoformat_verbosemode=1

autocmd FileType yaml let b:autoformat_autoindent=0
autocmd FileType conf let b:autoformat_autoindent=0


" ======================
" COC config
" ======================
let g:coc_global_extensions = [ 'coc-elixir', 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']

" ======================
" Fix for endwise + COC
" ======================
let g:endwise_no_mappings = 1
