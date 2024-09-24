# Generate wal colorschemes from an image
function palette
    # Check if no arguments were provided
    if test (count $argv) -eq 0
        echo "Usage: palette [-p <full-path-to-image>] [image-name]"
        echo "  -p: Specify the full path to the image"
        echo "  image-name: Specify just the image name (without .png) if the image is in /home/mxstoto/Pictures/Wallpapers/"
        return 1
    end

    # Initialize variable to hold the path
    set wallpaper_path ""

    # Check if the first argument is -p (full path option)
    if test $argv[1] = -p
        if test (count $argv) -lt 2
            echo "Error: Missing path after -p option."
            return 1
        end
        set wallpaper_path $argv[2]
    else
        # Otherwise, treat it as a file name in the default directory
        set wallpaper_path "/home/mxstoto/Pictures/Wallpapers/$argv[1].png"
    end

    # Check if the file exists at the determined path
    if not test -e $wallpaper_path
        echo "Error: File not found: $wallpaper_path"
        return 1
    end

    # Generate the colors using wal
    wal -i $wallpaper_path -n -q -t --saturate 0.5 2>/dev/null

    # Set the background opacity of kitty
    sed -i '3s/.*/background_opacity 0.6/' ~/.cache/wal/colors-kitty.conf

    # Set the wallpaper using swww
    swww img $wallpaper_path -t none

    # Change the fastfetch logo
    magick -size 500x500 xc:none -draw "roundrectangle 0,0,500,500,32,32" ~/.config/fastfetch/mask.png 2>/dev/null
    magick $wallpaper_path -resize 500x500^ -gravity center -extent 500x500 -alpha set ~/.config/fastfetch/mask.png -compose DstIn -composite /home/mxstoto/.config/fastfetch/fetch-logo.png 2>/dev/null

    echo "Colorscheme and background changed!"
end
