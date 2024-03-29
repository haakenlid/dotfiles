# test that program exists
program_exists () {
  type "$1" &> /dev/null ;
}
alias whois='whois -h whois.geektools.com'
alias tt="stty sane && clear && echo terminal sanity restored!"

# tassen run
alias tassen="$HOME/projects/tassen/tassen/run"

program_exists fdfind && alias fd="fdfind"

if ! command -v docker-compose > /dev/null; then
  alias docker-compose="docker compose"
fi

doco() {
  # docker compose from git root directory
  gitroot=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  pushd $gitroot >/dev/null
  docker-compose $@;
  popd >/dev/null
}

# open
alias open=xdg-open

# Remote servers
alias UIO='ssh -t haakenl@login.uio.no "cd /uio/kant/div-universitas-desken/; bash"'

# cd to git root
cdg() {
  dir=$(git rev-parse --show-toplevel 2>/dev/null)
  [[ -n "$dir" ]] && cd "$dir"
}

# pip install user
pipi() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "installing in $VIRTUAL_ENV"
    python -m pip install --upgrade $@
  else
    echo "installing in user directory"
    python3 -m pip install --user --upgrade $@
  fi
}

# Clipboard shortcuts using xclip
clip() {
  if [ -t 0 ]; then # no stdin
    xclip -selection clipboard -o # pipe from clipboard
  else
    xclip -selection c # pipe to clipboard
  fi
}

killchrome(){
  local PROCS=$(ps ax -o sess,pgrp,pid,cmd | awk '$4 ~ /\/chrome$/ { printf "%d ", $3 }')
  if [[ $PROCS == '' ]]; then
    echo "no chromeos processes found"
  else
    echo "kill chromeos processes: $PROCS"
    kill $PROCS > /dev/null
  fi
}

# grep in glorious TECHNICOLOR
alias grep='grep --color=auto'

# Better python repl
function pp() {
  python3 -c 'import ptpython, IPython' &>/dev/null || python3 -m pip install --user ptpython ipython
  python3 $(which ptipython) $@
}

# NEOVIM
program_exists nvim.appimage && alias vim=nvim.appimage

# Don't use vimrc with vi.
program_exists vi && alias vi="vi -u NONE"

# Keyboard layout changes (only works if you have the keyboard layouts installed)
function nor() {  # Norwegian
  [ $DISPLAY ] || return
  setxkbmap -layout no -option caps:escape
  echo 'norwegian keyboard'
}
function eng() {  # Like English – but better!
  [ $DISPLAY ] || return
  xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/en-improved $DISPLAY >& /dev/null
  echo 'english (improved) keyboard'
}
function chromeng() {  # Like English – but better!
  [ $DISPLAY ] || return
  xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/en-chromebook $DISPLAY >& /dev/null
  echo 'english (improved) keyboard for chromebook'
}

# print in nice color
p () {
  echo -e "\n    \e[1;33m$@\e[0m"
}

# Spotify shortcuts
if program_exists spotify; then
  alias sv='sptfy volume'  # usage v [+, ++, --, 0, 3, 4, max]
  alias sn='sptfy next'
  alias sb='sptfy back'
  alias sp='sptfy play'  # plauy / pause
fi

# remove ansi color codes. Nice for piping
alias nocolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

# make a directory and cd into it
function mcd () {
  mkdir -p $1 && cd $1
}

alias rr='reset'

# You only live once
alias YOLO='git add -A && git commit -m "$(fortune -o | cowsay -W80)" && git push --force'

# Start a program and disown
function run(){
  if which $1 > /dev/null; then
    echo "running and disowning $1"
    (nohup $@ &> /dev/null & disown)
  else
    echo "no such command $1" 1>&2
    return 1
  fi
}
