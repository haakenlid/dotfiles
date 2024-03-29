source ~/.vim/vimrc/basic_options.vim
source ~/.vim/vimrc/vim_functions.vim
source ~/.vim/vimrc/keyboard_shortcuts.vim

call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-vinegar'

Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'
Plug 'rhysd/conflict-marker.vim'
Plug 'Valloric/ListToggle'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'guns/xterm-color-table.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'reedes/vim-lexical'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'sjl/strftimedammit.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tweekmonster/braceless.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" AUTOCOMPLETE
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

call plug#end()

luafile ~/.vim/vimrc/nvim-cmp.lua
luafile ~/.vim/vimrc/lsp.lua

" reset autocommands
aug rcgroup
  au!
aug END

" vimrc stuff
command! Sourcevimrc so $MYVIMRC | echo 'sourced '.$MYVIMRC
" open vimrc with leader V
autocmd rcgroup BufRead $MYVIMRC :map <buffer> <leader>v :bp<CR>:so $MYVIMRC<CR>

" Neoformat when saving
autocmd rcgroup BufWritePre * Neoformat

augroup tmux_pane_title
  autocmd!
  autocmd VimEnter * silent exec "![[ -n $TMUX ]] && tmux select-pane -T 'vim'"
  autocmd VimLeave * silent exec "![[ -n $TMUX ]] && tmux select-pane -T 'shell'"
  if exists('##VimSuspend')
    autocmd VimResume * silent exec "![[ -n $TMUX ]] && tmux select-pane -T 'vim'"
    autocmd VimSuspend * silent exec "![[ -n $TMUX ]] && tmux select-pane -T 'shell'"
  endif
augroup END

nnoremap <leader>f :Neoformat<CR>

let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_typescript = ['prettierd']
let g:neoformat_enabled_python = ['isort', 'yapf']
" let g:neoformat_enabled_python = ['black']
let g:neoformat_try_formatprg = 1
let g:neoformat_run_all_formatters = 1
" let g:neoformat_run_all_formatters = 0

" Enable trimmming of trailing whitespace globally
let g:neoformat_basic_format_trim = 1
" Enable tab to spaces conversion globally
let g:neoformat_basic_format_retab = 0
" Enable alignment globally
let g:neoformat_basic_format_align = 0

" FZF keyboard shortcuts
nmap <silent> <leader><leader>b :Buffers<cr>
nmap <silent> <leader><leader>A :Rg <cr>
nmap <silent> <leader><leader>a :Rg<cr>
nmap <silent> <leader><leader>f :Files<cr>
nmap <silent> <leader><leader>h :Helptags<cr>
nmap <silent> <leader><leader>c :Commands<cr>
nmap <silent> <leader><leader>m :History<cr>
nmap <silent> <leader><leader>s :Snippets<cr>
nmap <silent> <leader><leader>t :Tags<cr>
nmap <silent> <leader><leader>l :Lines<cr>
nmap <silent> <leader><leader>g :BCommits!<cr>
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'right': '15%'})
" inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
" inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

" Ag with preview
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --glob "!.git" --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" Buffergator config
let g:buffergator_autoupdate=1
let g:buffergator_sort_regime='mru'
let g:buffergator_display_regime='basename'
let g:buffergator_suppress_keymaps=1
nnoremap <leader>b :BuffergatorToggle<cr>

" Autopairs config
let g:AutoPairsFlyMode = 0  " fly mode closes brackets
let g:AutoPairsMultilineClose = 0  " fly mode closes brackets
let g:AutoPairsShortcutFastWrap = '<M-w>'  " wrap following
autocmd rcgroup Filetype vim let b:AutoPairs = {'{':'}', '(':')', '<':'>', '''':''''}
" https://github.com/jiangmiao/auto-pairs/issues/187
" autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

" Disable python2, perl, node and ruby support
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0

" Python
let g:autopep8_disable_show_diff = 1
let g:autopep8_max_line_length = 79
let g:python_host_prog = ''

if !empty(glob("/home/haakenlid/.pyenv/versions/3.8.1/bin/python3"))
  let g:python3_host_prog = '/home/haakenlid/.pyenv/versions/3.8.1/bin/python3'
else
  let g:python3_host_prog = trim(system('which python3'))
endif

autocmd rcgroup FileType python BracelessEnable +indent +highlight

fun! UseBlack()
  " use the black python formatter on this project
  let g:neoformat_enabled_python = ['black']

  let g:neoformat_python_black = { 'args': ['-l 120 --fast'] }
  set tw=120
endfun

" let g:lt_height = 5
autocmd rcgroup FileType qf nmap <silent> <buffer> <CR> <CR>:lcl<CR>
autocmd rcgroup FileType qf nmap <silent> <buffer> <ESC> :q<CR>
autocmd rcgroup BufNewFile,BufReadPost *.md set filetype=markdown
autocmd rcgroup BufNewFile,BufReadPost *.sh set filetype=bash
autocmd rcgroup BufNewFile,BufReadPost *.js.snap set filetype=javascript.jsx
autocmd rcgroup BufNewFile,BufReadPost */ebhr/backend/** call UseBlack()


" Dynamic quickfix height
autocmd rcgroup FileType qf call AdjustWindowHeight(3, 10)

" Elm stuff
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0
augroup elmkeys
  autocmd!
  autocmd FileType elm nmap <buffer> <leader>e :ElmErrorDetail<CR>
  autocmd FileType elm nmap <buffer> <leader>d :ElmShowDocs<CR>
  autocmd FileType elm nmap <buffer> <leader>b :ElmBrowseDocs<CR>
augroup END

" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

let g:jsx_ext_required = 0

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#languageclient#enabled = 0

" Tagbar settings
autocmd rcgroup FileType tagbar nmap <silent> <buffer> <ESC> :q<CR>

let g:previewheight=5

augroup prewrite
  autocmd!
  " change class to className in jsx
  autocmd BufWritePre *.js,*.jsx sil! %s/\<class=/className=/
augroup END

augroup insertmode
  " Adjust timeouts for 'jj' insert mode command
  autocmd!
  autocmd InsertEnter * set timeoutlen=300
  autocmd InsertLeave * set timeoutlen=800
augroup END

" NERDTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenVSplit = '<c-v>'
let g:NERDTreeMapPreviewVSplit = 'gv'

let g:NERDTreeIgnore=[
      \'\.[^.]*cache$',
      \'\.git$', '\.pyc$', '__pyc__', '__pycache__', '__snapshots__']
augroup NerdTree
  autocmd!
  autocmd FileType nerdtree,'' noremap <buffer> <silent> <leader>n :NERDTreeToggle<CR>
  autocmd FileType nerdtree,'' noremap <buffer> <silent> <leader>o :NERDTreeToggle<CR>
  autocmd FileType nerdtree silent! unmap <buffer> <c-j>
  autocmd FileType nerdtree silent! unmap <buffer> <c-k>
augroup END

""" Emmet config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_next_key='<M-j>'
let g:user_emmet_prev_key='<M-k>'
let g:user_emmet_settings = {'html':{'empty_element_suffix': ' />'}}

""" Ultisnips config
let g:UltiSnipsExpandTrigger='<nop>'
" let g:UltiSnipsListSnippets='<M-s>'
" let g:UltiSnipsExpandTrigger='<M-e>'
let g:UltiSnipsUsePythonVersion=3

" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" let g:UltiSnipsSnippetDirectories=[]
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" let g:ulti_expand_or_jump_res = 0

" vim-sneak
" let g:sneak#label = 1
let g:sneak#absolute_dir = 1
let g:sneak#prompt = 'vim-sneak >'

" 1 : Case sensitivity is determined by 'ignorecase' and 'smartcase'.
let g:sneak#use_ic_scs = 1
" nmap s <Plug>SneakLabel_s
" nmap S <Plug>SneakLabel_S

" use system clipboard
set clipboard=unnamedplus
