" Leader
let mapleader = " "

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

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" Tabs
nnoremap <silent> <Leader>tn :tabnew<CR>
nmap <silent> <Leader>tl gt
nmap <silent> <Leader>th gT
nmap <S-Tab> gt

" zoom a vim pane, <C-w>= to re-balance
nnoremap <Leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <Leader>= :wincmd =<cr>

" Windows navigate
nnoremap <silent> <Leader>wh :wincmd h<cr>
nnoremap <silent> <Leader>wj :wincmd j<cr>
nnoremap <silent> <Leader>wk :wincmd k<cr>
nnoremap <silent> <Leader>wl :wincmd l<cr>
nnoremap <silent> <Leader>ws :new<cr>
nnoremap <silent> <Leader>wv :vnew<cr>

" nerdtree
nnoremap <silent> <leader>n :call ToggleNerdTree()<cr>
nnoremap <silent> <leader>y :NERDTreeFind<cr>

" run tests
nnoremap <Leader>rs :TestFile<CR>
nnoremap <Leader>rn :TestNearest<CR>
nnoremap <Leader>rl :TestLast<CR>
nnoremap <Leader>ra :TestSuite<CR>
nnoremap <Leader>rv :TestVisit<CR>

" Close buffer
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

nnoremap <Leader>aw :wa<CR>

nnoremap <Leader>ka :qa<CR>
nnoremap <Leader>kf :q!<CR>
nnoremap <Leader>kk :qa!<CR>

" COC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" map enter to confirm autocompleat or apply endwise
imap <expr> <cr> (pumvisible() ? "\<C-y>" : "\<cr>\<Plug>DiscretionaryEnd")

" Scroll popup
nnoremap <nowait><expr> <M-l> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-l>"
nnoremap <nowait><expr> <M-h> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-h>"


" COC Fzf
nmap <Leader>f [fzf-leader]
xmap <Leader>f [fzf-leader]
let g:fzf_preview_preview_key_bindings = 'alt-j:preview-page-down,alt-k:preview-page-up,?:toggle-preview'

nnoremap <silent> <Leader>l     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru project_mrw<CR>
nnoremap <silent> <Leader>p     :<C-u>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent> <Leader>b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> <Leader>B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> <Leader>j :<C-u>CocCommand fzf-preview.Jumps<CR>

nnoremap <silent> [fzf-leader]h    :<C-u>CocCommand fzf-preview.CommandPalette<CR>
nnoremap <silent> [fzf-leader]gc    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-leader]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-leader]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> [fzf-leader]n     :<C-u>CocCommand fzf-preview.BufferLines<CR>

function! AddHunkToFixAndOpen()
  silent! GitGutterQuickFix
  silent! CocCommand fzf-preview.QuickFix
endfunction

" nnoremap <silent> [fzf-leader]f     :call AddHunkToFixAndOpen()<CR>
nnoremap <silent> [fzf-leader]f :call CocAction('format')<CR>

nnoremap [fzf-leader]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap [fzf-leader]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

" COC Yank
nnoremap <silent> <Leader>y  :<C-u>CocList -A --normal yank<cr>

" GIT map
nmap <Leader>g [git-leader]
xmap <Leader>g [git-leader]

function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

" navigate chunks of current buffer
nnoremap <silent> [git-leader]n :call GitGutterNextHunkCycle()<CR>
nmap <silent> [git-leader]p <Plug>(GitGutterPrevHunk)

function! ToggleGitGutterHighlights()
  silent! GitGutterLineNrHighlightsToggle
  silent! GitGutterLineHighlightsToggle
endfunction

nnoremap <silent> [git-leader]h :call ToggleGitGutterHighlights()<CR>

" navigate conflicts of current buffer
nmap <silent> [git-leader]c <Plug>(coc-git-nextconflict)
" nmap <silent> [git-leader]cp <Plug>(coc-git-prevconflict)

function! PreviewHunkWindow()
  silent! GitGutterPreviewHunk
  wincmd P
endfunction

" show chunk diff at current position
nmap <silent> [git-leader]i <Plug>(coc-git-chunkinfo)
nmap <silent> [git-leader]I :call PreviewHunkWindow()<CR>

" show commit contains current position
nmap <silent> [git-leader]b <Plug>(coc-git-commit)

nnoremap <silent> [git-leader]g  :<C-u>CocCommand git.browserOpen<cr>

nmap <silent> [git-leader]a <Plug>(GitGutterStageHunk)
nmap <silent> [git-leader]r <Plug>(GitGutterUndoHunk)

nnoremap <silent> [git-p]f  :<C-u>CocCommand git.foldUnchanged<cr>

" Fzf git
nnoremap <silent> [git-p]s  :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [git-p]o  :<C-u>CocCommand fzf-preview.GitActions<CR>

" Open Magit
nnoremap <silent> [git-p]it :Magit<CR>
