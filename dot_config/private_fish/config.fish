# ===> Functions
# Simplify wifi connection
function nmcli-wifi
    if test (count $argv) -eq 0
        echo "usage: wifi <SSID> <password>"
    else
        nmcli device wifi connect "$argv[1]" password $argv[2]
    end
end

# Setup my theme switcher
function themeswitcher
    set path $(pwd)
    cd ~/Desktop/git-repos/themeSwitcher/
    ./switch_theme.sh $argv[1] $argv[2]
    cd $path
end


# ===> Custom aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tt='tt -n 10 -theme custom'

alias ff='fastfetch -c ~/.config/fastfetch/custom.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/custom2.jsonc --logo-type small'
alias sd='shutdown 0'
alias rb='reboot'
alias vim='nvim'
alias svim='sudo nvim'
alias p='sudo pacman'
alias lsa='ls -a --color=auto'
alias wifi='nmcli-wifi'
alias c='clear'
alias dim='echo 70 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias theme='themeswitcher'
alias clock="tty-clock -s -C 5"
alias led="echo off | sudo tee /sys/class/sound/ctl-led/mic/mode"
alias commits="~/Desktop/git-repos/commits/commits.sh"
alias ls-sym='ls -la ./ | grep "\->"'
alias cm='chezmoi'


# Welcome message
~/Desktop/scripts/random_krabby.sh


# Set the prompt
starship init fish | source

# Created by `pipx` on 2024-06-25 06:22:23
set PATH $PATH /home/mxstoto/.local/bin
