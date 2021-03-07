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
" let g:airline_theme='solarized_flood'
" let g:airline_solarized_bg='dark'

" ======================
" Theme configuration
" ======================
colorscheme night-owl
hi Pmenu ctermbg=236 ctermfg=white
hi PMenuSel ctermbg=26 ctermfg=white

set guifont=FuraCode\ Nerd\ Font\ 12 " for devicons

" ======================
" Tmux Stuff
" ======================

" Re-enable tmux_navigator.vim default bindings, minus <c-\>.
" <c-\> conflicts with NERDTree "current file".
" Don't allow any default key-mappings.
let g:tmux_navigator_no_mappings = 1

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

autocmd FileType yaml let b:autoformat_autoindent=0
autocmd FileType conf let b:autoformat_autoindent=0
autocmd FileType snippets let b:autoformat_autoindent=0

" let g:autoformat_verbosemode=1

" ======================
" COC config
" ======================
let g:coc_global_extensions = [ 'coc-elixir', 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-fzf-preview', 'coc-yank', 'coc-git', 'coc-snippets']

" ======================
" AirLine config
" ======================
let g:airline#extensions#coc#enabled = 1

" ======================
" Fix for endwise + COC
" ======================

" Disable endwise auto mapping
let g:endwise_no_mappings = 1

" ======================
" Fzf Preview Config
" ======================
let g:fzf_preview_lines_command = 'bat --color=always --plain --number' " Installed bat
let g:fzf_preview_command = 'bat --color=always --plain {-1}' " Installed bat
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"' " Installed ripgrep
let g:fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=never'

" ======================
" Vim Visual Mult Cursor Config
" ======================

let g:VM_theme                      = 'iceblue'
let g:VM_maps                       = {}
let g:VM_maps["Add Cursor Down"]    = '<M-j>'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<M-k>'   " new cursor up

" ======================
" Greplace configuration
" ======================

set grepprg=ag

let g:grep_cmd_opts = '--line-numbers --noheading'

" ======================
" Git Gutter
" ======================
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
