source ~/.vim/vimrc/basic_options.vim
source ~/.vim/vimrc/plugin_options.vim
source ~/.vim/vimrc/vim_functions.vim
source ~/.vim/vimrc/keyboard_shortcuts.vim
" source ~/.vim/vimrc/easymotion.vim

aug rcgroup
  au!
aug END

" FZF keyboard shortcuts
nmap <silent> <leader><leader>b :Buffers<cr>
nmap <silent> <leader><leader>f :Files<cr>
nmap <silent> <leader><leader>h :Helptags<cr>
nmap <silent> <leader><leader>m :History<cr>
nmap <silent> <leader><leader>s :Snippets<cr>
nmap <silent> <leader><leader>t :Tags<cr>
nmap <silent> <leader><leader>l :Lines<cr>
nmap <silent> <leader><leader>g :GGrep<cr>
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

" Autopairs config
let g:AutoPairsFlyMode = 0  " fly mode closes brackets
let g:AutoPairsMultiLineClose = 0  " fly mode closes brackets
let g:AutoPairsShortcutFastWrap = '<M-w>'  " wrap following
autocmd rcgroup Filetype vim let b:AutoPairs = {'{':'}', '(':')', '<':'>', '''':''''}
" https://github.com/jiangmiao/auto-pairs/issues/187
" autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">


let g:neomake_python_mypy_maker = {
      \ 'exe': 'mypy',
      \ 'args': ['--ignore-missing-imports'],
      \ 'errorformat': '%f:%l:%m'
      \ }

let g:neomake_python_enabled_makers = ['mypy', 'flake8']
let g:neomake_sh_enabled_makers = []
let g:neomake_open_list = 1 " open location list

command! Nolint call DisableLint()

" vimrc stuff

command! Sourcevimrc so $MYVIMRC | echo 'sourced '.$MYVIMRC


" Python
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd rcgroup FileType python BracelessEnable +indent +highlight


" let g:lt_height = 5
autocmd rcgroup FileType qf nmap <silent> <buffer> <CR> <CR>:lcl<CR>
autocmd rcgroup FileType qf nmap <silent> <buffer> <ESC> :q<CR>
autocmd rcgroup BufNewFile,BufReadPost *.md set filetype=markdown

" Dynamic quickfix height
autocmd rcgroup FileType qf call AdjustWindowHeight(3, 10)

" let g:airline_section_x = 'pencil: %{PencilMode()}'
"
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd,text
"         \ | call pencil#init()
"         \ | call lexical#init()
" augroup END


" Elm stuff
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0
augroup elmkeys
  autocmd!
  autocmd FileType elm nmap <buffer> <leader>e :ElmErrorDetail<CR>
  autocmd FileType elm nmap <buffer> <leader>d :ElmShowDocs<CR>
  autocmd FileType elm nmap <buffer> <leader>b :ElmBrowseDocs<CR>
augroup END


" open vimrc with leader V
autocmd rcgroup BufRead $MYVIMRC :map <buffer> <leader>v :bp<CR>:so $MYVIMRC<CR>

" Neoformat
augroup neoformat
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_python = ['yapf']
let g:neoformat_try_formatprg = 1

" python autoformat with yapf

autocmd rcgroup FileType javascript,javascript.jsx setlocal formatprg=prettier\ --stdin
      \\ --semi\ false\ --single-quote\ --trailing-comma\ es5
let g:jsx_ext_required = 0

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

" Tagbar settings
autocmd rcgroup FileType tagbar nmap <silent> <buffer> <ESC> :q<CR>

let g:previewheight=5

augroup prewrite
  autocmd!
  " change class to className in jsx
  autocmd BufWritePre *.js,*.jsx sil! %s/class=/className=/
augroup END

augroup insertmode
  " Adjust timeouts for 'jj' insert mode command
  autocmd!
  autocmd InsertEnter * set timeoutlen=300
  autocmd InsertLeave * set timeoutlen=1000
augroup END


" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_semantic_triggers = { 'elm' : ['.'] }
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_identifier_candidate_chars = 2

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'rst' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}


" NERDTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenVSplit = '<c-v>'
let g:NERDTreeMapPreviewVSplit = 'gv'

let g:NERDTreeIgnore=['.git$', '.pyc$', '__pyc__', '__pycache__']
augroup NerdTree
  autocmd!
  autocmd FileType nerdtree,'' noremap <buffer> <silent> <leader>n :NERDTreeToggle<CR>
  autocmd FileType nerdtree silent! unmap <buffer> <c-j>
  autocmd FileType nerdtree silent! unmap <buffer> <c-k>
augroup END

""" Emmet config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_next_key='<M-j>'
let g:user_emmet_prev_key='<M-k>'
let g:user_emmet_settings = {'html':{'empty_element_suffix': ' />'}}


""" Ultisnips config
let g:UltiSnipsListSnippets='<M-l>'
let g:UltiSnipsExpandTrigger='<M-e>'
let g:UltiSnipsUsePythonVersion='3'

call plug#begin('~/.vim/plugged')
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-vinegar'
Plug 'SirVer/ultisnips'
Plug 'Valloric/ListToggle'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elmcast/elm-vim'
Plug 'guns/xterm-color-table.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
call plug#end()

call neomake#configure#automake('w')
