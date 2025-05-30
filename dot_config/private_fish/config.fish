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
alias cls='c && lsa'
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

alias theme="~/.config/scripts/palette/change-wallpaper.sh"

function palette
    ~/.config/scripts/palette/change-wallpaper.sh $argv
end

function shufbg
    fish -c 'source ~/.config/fish/functions/palette.fish; set wallpaper (lls ~/Pictures/Wallpapers/rin/ | shuf -n 1 | sed s/.png\$//); palette "rin/$wallpaper"'
end

# Setup greeting
if status is-interactive
    #~/.config/fish/functions/random_krabby.sh
    #krabby name sylveon

    if not set -q KITTY_WINDOW_CLASS; or test "$KITTY_WINDOW_CLASS" != clean_fish
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

# Bindings
bind ctrl-backspace 'commandline -r ""'

# External configs
for file in ~/.config/fish/functions/*
    source $file 2>/dev/null
end

source ~/private/config.fish 2>/dev/null

set -x EDITOR nvim
