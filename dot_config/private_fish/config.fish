# Aliases
alias ..='cd ..'
alias ...='cd ../../'
alias grep='grep --color=auto'
alias tt='tt -n 10 -theme custom'
alias ff='fastfetch -c ~/.config/fastfetch/image.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/small.jsonc --logo-type small'
alias fff='fastfetch -c ~/.config/fastfetch/full.jsonc'
alias sd='shutdown 0'
alias rb='shutdown -r 0'
alias vim='nvim'
alias svim='sudo nvim'
alias p='sudo pacman'
alias ls='exa -1lhmU --group-directories-first --no-permissions --no-user --icons --color always --sort date -r --time-style iso --hyperlink'
alias lsa='exa -1alhmUF --group-directories-first --no-permissions --no-user --icons --color always --sort date -r --time-style iso --hyperlink'
alias cls='c && ls'
alias clsa='c && lsa'
alias lls='command ls'
alias c='clear'
alias dim='echo 70 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias clock="tty-clock -s -C 5"
alias led="echo off | sudo tee /sys/class/sound/ctl-led/mic/mode"
alias commits="~/Desktop/git-repos/commits/commits.sh"
alias cm='chezmoi'
alias dcolors='Desktop/scripts/display-colors.fish'
alias cmcd='cd /home/strawberries/.local/share/chezmoi/'
alias deb="sudo lxc-start -n debian -f /var/lib/lxc/debian/config -d; sudo lxc-attach -n debian -- login"
alias t="tmux"
alias ta="tmux attach"
alias y='yazi'
alias gs='git status'
alias gps='git push'
alias gpl='git pull'
alias ga='git add'
alias gf='git fetch'
alias gc='git commit -m'
alias h='helix'
alias zel='zellij'
alias dla='yt-dlp --extract-audio'

function files
  for file in (fd -t f)
    echo $file
    command cat $file
    echo
  end
end

function amazon-shorten
    set url (echo $argv | cut -d '/' -f 4 --complement | awk -F '?' '{print $1}')
    echo $url
    echo $url | tr -d '\n' | wl-copy
end

function theme
    dotswitch switch $argv[1] common $argv[2]
end

function palette
    ~/.config/scripts/palette/change-wallpaper.sh $argv
end

function upscale
    if test (count $argv) -lt 3
        echo "Usage: upscale <input> <output> <size>"
        return 1
    end
    ffmpeg -i $argv[1] -vf "scale=$argv[3]:$argv[3]:flags=neighbor" $argv[2]
end

# Rerun last command
function rr
  set PREV_CMD (history | head -1)
  # set PREV_OUTPUT (eval $PREV_CMD)
  # set CMD $argv[1]
  # eval "$CMD $PREV_OUTPUT"
  if test "$PREV_CMD" != "rr"
    eval "$PREV_CMD"
  else
    echo "Cannot execute rr again"
  end
end

# Setup greeting
if status is-interactive
    #~/.config/fish/functions/random_krabby.sh
    #krabby name sylveon

    if not set -q CLEAN_FISH; or test "$CLEAN_FISH" != true
        ff
    end
else
    set -U fish_greeting
end

# Env variables
set -x MANPAGER 'nvim +Man!'

# Set the prompt
starship init fish | source

# Add PATH
set PATH $PATH /home/strawberries/.local/bin
set PATH $PATH /home/strawberries/.cargo/bin
set PATH $PATH /home/strawberries/go/bin
set PATH $PATH /home/strawberries/.local/share/gem/ruby/*/bin

set JAVA_HOME /opt/android-studio/jbr

# Bindings
bind ctrl-backspace 'commandline -r ""'
bind alt-backspace backward-kill-word

# External configs
for file in ~/.config/fish/functions/*
    source $file 2>/dev/null
end

# pyenv init - fish | source

source ~/private/config.fish 2>/dev/null

set -x EDITOR nvim
