# Setup my theme switcher
function theme
    set -l path $(pwd)
    cd ~/Desktop/git-repos/themeSwitcher/
    ./switch_theme.sh $argv[1] $argv[2]
    cd $path
end
