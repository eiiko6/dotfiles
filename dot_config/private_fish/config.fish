# Aliases
alias ..='cd ..'
alias ...='cd ../../'
alias grep='grep --color=auto'
alias tt='tt -n 10 -theme custom'
alias ff='fastfetch -c ~/.config/fastfetch/nice.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/custom2.jsonc --logo-type small'
alias fff='fastfetch -c ~/.config/fastfetch/custom.jsonc'
alias fft='magick /tmp/cover-raw.jpeg -resize 500x500^ -gravity center -extent 500x500 -alpha set ~/.config/fastfetch/mask.png -compose DstIn -composite /home/mxstoto/.config/fastfetch/fetch-logo.png && fastfetch -c ~/.config/fastfetch/track.jsonc'
alias sd='shutdown 0'
alias rb='shutdown -r 0'
alias vim='nvim'
alias svim='sudo nvim'
alias p='sudo pacman'
alias ls='exa -1lhmU --group-directories-first --no-permissions --no-user --icons --color always --sort name --time-style iso'
alias lsa='exa -1alhmUF --group-directories-first --no-permissions --no-user --icons --color always --sort name --time-style iso'
alias cls='c && lsa'
alias lls='/bin/ls'
alias c='clear'
alias dim='echo 70 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias clock="tty-clock -s -C 5"
alias led="echo off | sudo tee /sys/class/sound/ctl-led/mic/mode"
alias commits="~/Desktop/git-repos/commits/commits.sh"
alias cm='chezmoi'
alias dcolors='Desktop/scripts/display-colors.fish'
alias cmcd='cd /home/mxstoto/.local/share/chezmoi/'
alias deb="sudo lxc-start -n debian -f /var/lib/lxc/debian/config -d; sudo lxc-attach -n debian -- login"

# Setup greeting
if status is-interactive
    # Welcome message
    #~/.config/fish/functions/random_krabby.sh
    krabby name sylveon -s
else
    set -U fish_greeting
end

# Set the prompt
starship init fish | source

# Add PATH
set PATH $PATH /home/mxstoto/.local/bin

# External configs
for file in ~/.config/fish/functions/*
    source $file 2>/dev/null
end
source ~/private/config.fish 2>/dev/null
