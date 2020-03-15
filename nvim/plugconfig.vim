"nerdtree configuration

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

set guifont=FuraCode\ Nerd\ Font\ 12

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'
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
