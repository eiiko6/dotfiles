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
function theme
    set -l path $(pwd)
    cd ~/Desktop/git-repos/themeSwitcher/
    ./switch_theme.sh $argv[1] $argv[2]
    cd $path
end

# Compress a file and convert from mkv to mp4
function compress
    if test (count $argv) -eq 0
        echo "usage: compress <input_video_name>.mkv <output_video_name> <resolution_factor>"
    else
        ffmpeg -i $argv[1] -vf "scale=iw*$argv[3]:ih*$argv[3]" -map 0 -c:v libx264 -c:a aac -loglevel warning $argv[2].mp4
    end
end

# Convert hex color to rgb
function hex2rgb
    set -l hex_color "$argv[1]"
    printf "%d %d %d\n" 0x(string sub -s 2 -l 2 $hex_color) 0x(string sub -s 4 -l 2 $hex_color) 0x(string sub -s 6 -l 2 $hex_color)
end

# Generate wal colorschemes from an image
function palette
    # Generate the colors
    wal -i $argv[1] -n -q -t --saturate 0.5

    # Set the background opacity of kitty
    sed -i '3s/.*/background_opacity 0.6/' ~/.cache/wal/colors-kitty.conf

    # Set the wallpaper
    swww img $argv[1] -t none
end

# Display items taking up space in specified directory
function here
    if test (count $argv) -eq 0
        du -cha --max-depth=1 ./ | grep -E "M|G"
    else
        du -cha --max-depth=1 $argv[1] | grep -E "M|G"
    end
end

# Quickly start a java project
function jvs
    set path (realpath ~/Desktop/random-code/java-projects/)/$argv[1]
    cp -r ~/Desktop/random-code/java-projects/template $path
    cd $path/src
    nvim +3 $path/src/Main.java
end

# Quickly start a python project
function pys
    set path (realpath ~/Desktop/random-code/python-projects/)/$argv[1]
    cp -r ~/Desktop/random-code/python-projects/template $path
    cd $path/src
    nvim +2 $path/src/main.py
end


# ===> Custom aliases
alias grep='grep --color=auto'
alias tt='tt -n 10 -theme custom'

alias ff='fastfetch -c ~/.config/fastfetch/custom.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/custom2.jsonc --logo-type small'
alias sd='shutdown 0'
alias rb='reboot'
alias vim='nvim'
alias svim='sudo nvim'
alias p='sudo pacman'
alias ls='exa -1lhmU --group-directories-first --no-permissions --no-user --icons --color always --sort name --time-style iso'
alias lsa='exa -1alhmUF --group-directories-first --no-permissions --no-user --icons --color always --sort name --time-style iso'
alias cls='c && lsa'
alias wifi='nmcli-wifi'
alias c='clear'
alias dim='echo 70 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias clock="tty-clock -s -C 5"
alias led="echo off | sudo tee /sys/class/sound/ctl-led/mic/mode"
alias commits="~/Desktop/git-repos/commits/commits.sh"
alias cm='chezmoi'
alias dcolors='Desktop/scripts/display-colors.fish'
alias cmcd='cd /home/mxstoto/.local/share/chezmoi/'


if status is-interactive
    # Welcome message
    ~/Desktop/scripts/random_krabby.sh
else
    set -U fish_greeting
end


# Set the prompt
starship init fish | source

# Created by `pipx` on 2024-06-25 06:22:23
set PATH $PATH /home/mxstoto/.local/bin
