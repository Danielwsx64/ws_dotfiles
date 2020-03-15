" Leader
let mapleader = " "

" Copy Keys
nnoremap <c-y> "+y<CR>
vnoremap <c-y> "+y<CR>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
" By skwp
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Re-enable tmux_navigator.vim default bindings, minus <c-\>.
" <c-\> conflicts with NERDTree "current file".
" Don't allow any default key-mappings.
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" Tabs
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <S-Tab> gt
nnoremap L gt
nnoremap H gT

" zoom a vim pane, <C-w>= to re-balance
nnoremap <Leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <Leader>= :wincmd =<cr>

" nerdtree
nmap <silent> <leader>n :call ToggleNerdTree()<cr>
"find the current file in nerdtree without needing to reload the drawer
nmap <silent> <leader>y :NERDTreeFind<cr>
