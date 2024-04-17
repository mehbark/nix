''
#### BEGIN ALIASES ####
alias v='nvim'

alias vcf="v ~/.config/nvim/init.vim"

alias vw='nvim ~/vimwiki/index.wiki; commit-vimwiki'

function commit-vimwiki --description "go to and from the vimwiki directory, commit with message (to encourage uh, good stuff, and go back"
  cd ~/vimwiki
  git add *
  git commit
  prevd
end

alias vt='nvim ~/vimwiki/Tasks.wiki'

alias vwo="firefox ~/vimwiki_html/index.html"
alias vwr="nvim -c "VimwikiAll2HTML" -c "q" ~/vimwiki/index.wiki"
alias nv='neovide'
# alias hx='helix'
alias lv="~/.local/bin/lvim"
alias e='emacs'
alias ce='code .'
alias se="serve ."
alias co='code --reuse-window'
alias ok='okular'
alias ko='kitty .'
alias du="du -h --total"

#exa
alias ls="exa"
alias tree="exa --tree -I target"

# some more ls aliases
# alias ls='ls --color=always'
alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

#some cargo aliases :)
alias c='cargo'
alias cn='cargo new'
alias cnl='cargo new --lib'
alias ci='cargo init'
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'
alias cv='cargo clippy'
alias cf='cargo flamegraph'
alias cff='cargo flamegraph;firefox flamegraph.svg'
alias cvp='cargo clippy -- -W clippy::pedantic'
alias cw="cargo watch -c --poll -x 'clippy -- -W clippy::pedantic'"
alias cwr='cargo watch -c -x run'
alias cwt='cargo watch -c -x test'
alias cbr='cargo build --release'
alias crr='cargo run --release'
alias crd="cargo rustdoc"
alias cft="cargo fmt"
alias cdc="cargo doc; firefox target/doc/settings.html"

#general rust aliases
alias rft='rustfmt'

#git aliases
alias g="git"
alias gcs="batcat -p -l bash /home/mehbark/main/misc/gitCliCheatSheet.js"
alias gco="git checkout"
alias gb="git branch"
alias gc="git commit -m"
alias gst="git status"
alias ga="git add"
alias gp="git push"
alias gl='git log --oneline --graph --decorate --all'
alias gi='git init'

#more complex aliases
alias ri="git init; cargo init"
alias rn="new_cargo_quick"
alias ka="killall -r '.*'"

function new_cargo_quick --description "make a cargo project with git version control, cd to it and open vscode"
mkdir "$argv[1]"
cd "$argv[1]"
git init
cargo init
code .
end

function speed-up --description "take arg 1, speed it up by arg 3 and output it to arg 2"
  echo "$argv[1]"
  mencoder -o "$argv[2]" -speed "$argv[3]" -ovc lavc -oac lavc "$argv[1]"
end

alias doom='~/.config/emacs/bin/doom'
alias pipers='pipes-rs'
alias yt='yt-dlp'
alias compile_and_serve="cargo run --quiet --release example_in example_out;cd example_out;serve;cd .."
alias icat="kitty +kitten icat"

alias do="dolphin . &> /dev/null &"

#homestuck
alias hnav "source /home/mbk/hs/bin/hsnav"
alias hstree "tree ~/hs"
alias codestuck "code ~/hs"

function m
  mkdir $argv[1]
  cd $argv[1]
end

function playflac
  flac -c -d $argv | aplay
end

function filelink
  echo "file://$(realpath $argv)"
end
alias xpy '~/Aims/rust/x.py'
# alias sbcl "rlwrap sbcl"
# alias guile "rlwrap guile"
alias chez "rlwrap chez"
#alias clj 'clojure -Sdeps "{:deps {com.bhauman/rebel-readline {:mvn/version \"0.1.4\"} $args}}" -m rebel-readline.main'
alias csi "rlwrap chicken-csi"

# zig
alias zb "zig build"
alias zbr "zig build run"
alias zbt "zig build test"

# nix
alias nrb "sudo nixos-rebuild"
#### END ALIASES ####
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH:$HOME/.ghcup/bin:$HOME/.cabal/bin:$HOME/hs/bin:$HOME/.cargo/bin:$HOME/.deno/bin:$HOME/Aims/curlfire"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# setopt autocd
fish_vi_key_bindings
fish_vi_cursor
starship init fish | source
export RUSTC_FORCE_INCREMENTAL=1
export EDITOR="nvim"
export TROLLNAMES_PATH="/home/mbk/hs/content/mine/trollname/6-letter-english-words.txt"

set fish_greeting

if status is-interactive
if set -q ASCIINEMA_REC
return
end
if test $PWD = "/home/mbk/hs"
homestartup
else
fortune | cowsay
end
end

# export CHEZSCHEMELIBDIRS="/home/mbk/Aims/chez/thunderchez:/home/mbk/Aims/chez/thunderchez:/home/mbk/Aims/chez/chez-srfi:/home/mbk/Aims/chez/pfds"

# opam configuration
source /home/mbk/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
''
