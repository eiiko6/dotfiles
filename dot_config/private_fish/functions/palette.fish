# Generate wal colorschemes from an image
function palette
    if not test -e /home/mxstoto/Pictures/Wallpapers/$argv[1].png
        ls /home/mxstoto/Pictures/Wallpapers/$argv[1].png >/dev/null
        return
    end

    # Generate the colors
    wal -i /home/mxstoto/Pictures/Wallpapers/$argv[1].png -n -q -t --saturate 0.5 2>/dev/null

    # Set the background opacity of kitty
    sed -i '3s/.*/background_opacity 0.6/' ~/.cache/wal/colors-kitty.conf

    # Set the wallpaper
    swww img /home/mxstoto/Pictures/Wallpapers/$argv[1].png -t none

    # Change the fastfetch logo
    #magick /home/mxstoto/Pictures/Wallpapers/$argv[1].png -resize 500x500^ -gravity center -extent 500x500 -format png -alpha set \( +clone -alpha extract -draw "roundrectangle 0,0 499,499 50,50" \) -compose CopyOpacity -composite /home/mxstoto/.config/fastfetch/fetch-logo.png

    magick -size 500x500 xc:none -draw "roundrectangle 0,0,500,500,32,32" ~/.config/fastfetch/mask.png 2>/dev/null
    magick /home/mxstoto/Pictures/Wallpapers/$argv[1].png -resize 500x500^ -gravity center -extent 500x500 -alpha set ~/.config/fastfetch/mask.png -compose DstIn -composite /home/mxstoto/.config/fastfetch/fetch-logo.png 2>/dev/null
end
