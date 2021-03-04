" Leader
let mapleader = " "

" Copy Keys
" nnoremap <c-y> "+y<CR>
" vnoremap <c-y> "+y<CR>

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

" Remapping CtrlP
" let g:ctrlp_map = ' t'
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader>p :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" Snippets keys
let g:UltiSnipsExpandTrigger="sn"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"grep the current word using ag
nnoremap <silent> <Leader>ag :Ack!<Space>
vnoremap <silent> <Leader>ag y:Ack! <C-R>"<CR>

" multiple cursor mapping
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-m>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-m>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-b>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" run tests
nmap <Leader>rs :TestFile<CR>
nmap <Leader>rn :TestNearest<CR>
nmap <Leader>rl :TestLast<CR>
nmap <Leader>ra :TestSuite<CR>
nmap <Leader>rv :TestVisit<CR>

" Close buffer
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>x :qa<CR>

" Open Magit
nnoremap <Leader>git :Magit<CR>

" COC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Disable endwise auto mapping
let g:endwise_no_mappings = 1

" map enter to confirm autocompleat or apply endwise
imap <expr> <cr> (pumvisible() ? "\<C-y>" : "\<cr>\<Plug>DiscretionaryEnd")

" Scroll popup
nnoremap <nowait><expr> <M-l> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-l>"
nnoremap <nowait><expr> <M-h> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-h>"
