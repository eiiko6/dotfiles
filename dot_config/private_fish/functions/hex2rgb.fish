# Convert hex color to rgb
function hex2rgb
    set -l hex_color "$argv[1]"
    printf "%d %d %d\n" 0x(string sub -s 2 -l 2 $hex_color) 0x(string sub -s 4 -l 2 $hex_color) 0x(string sub -s 6 -l 2 $hex_color)
end
