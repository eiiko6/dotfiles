# Setup my theme switcher
function theme
    set -l path $(pwd)
    cd ~/.config/scripts/theme-switcher/
    ./switch_theme.sh $argv[1] $argv[2] $argv[3]
    cd $path
end
