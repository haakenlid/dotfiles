let g:mapleader=' '

" insert mode
inoremap <silent> <C-s> <esc>:call StripTrailingWhitespaces() \| w!<CR>
inoremap <M-s> <ESC>:Snippets<CR>
noremap <M-s> <ESC>:Snippets<CR>

" vim keyboard shortcuts
nmap <silent> ]g :call WrapMove('GitGutterNextHunk')<CR>
nmap <silent> [g :call WrapMove('GitGutterPrevHunk')<CR>

nmap zr :GitGutterUndoHunk<CR>
nmap za :GitGutterAll<CR>
nmap zp :GitGutterPreviewHunk<CR>
nmap zb :Gblame<CR>
nmap zs :Gstatus<CR>

" 'splain highlighting
nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
      \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)), "name")
      \ . ">"<CR>

" 'splain character
nmap g? <Plug>(characterize)

" easy escape
noremap! jj <esc>

" yank to end of line
nnoremap Y y$

" ctrl-enter to add line under?
inoremap <C-CR> <esc>o


" Control-Q to quit
noremap <C-Q> :qa!
noremap! <C-Q> <esc>:qa!

" Control-S to save
map <silent> <C-S> :call StripTrailingWhitespaces() \| w!<CR>

" Clear search
noremap <silent> <leader>/ :let @/=""<CR>

" Random colorscheme ;)
noremap <leader>cr :colorscheme random<CR>

" Delete current buffer
nnoremap <silent> <leader>x :wshada \| bd<CR>


" Write current buffer
nnoremap <silent> <leader>w :w<CR>

" Close other buffers if they are saved (o = 'only')
" mx           create mark 'x'
" :up(date)    save file if modified
" :wshada      write shada file
" :%bd         delete all buffers
" :e#          edit last file in buffer list
" :bd#         delete last buffer
" `x           go to mark x
" :rshada      read shada file
nnoremap <silent> <leader>o mx:up \| wshada \| %bd \| e# \| bd#<CR>`x:rshada<CR>

" Close preview window
nnoremap <silent> <leader>z :pclose!<CR>

" Replace word
nnoremap <leader>r *N:redraw!<CR>:%s/\<<C-r>=expand('<cword>')<CR>\>//g<left><left>

" Open vimrc
nmap <leader>v :call SwitchToWriteableBufferAndExec('e $MYVIMRC')<CR>

" Open tagbar
nmap <leader>t :TagbarOpenAutoClose<CR>

" Strip trailing
nmap <leader>S :call StripTrailingWhitespaces()<CR>

" Easy Align shortcuts
nmap ga <Plug>(LiveEasyAlign)
xmap ga <Plug>(LiveEasyAlign)

noremap <silent> <leader>n :if bufname('%') =~ '/' \| NERDTreeFind \| else \| NERDTreeCWD \| endif<CR>

" Ultisnips expand on <CR>
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrReturn()<CR>" : "\<CR>"
" inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
