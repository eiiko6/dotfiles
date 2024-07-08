#!/usr/bin/env fish

set colors (cat $argv | sed "s/.*/'&'/")

set i 0

echo $colors

# Function to convert hex color to RGB and print a colored square
for color in $colors
    set i (math $i + 1)
    if test $i -eq 9
        echo -e "a\na"
    end
    set r (printf "%d\n" 0x(string sub -s 2 -l 2 $color))
    set g (printf "%d\n" 0x(string sub -s 4 -l 2 $color))
    set b (printf "%d\n" 0x(string sub -s 6 -l 2 $color))
    for i in (seq 0 1)
        printf "\e[48;2;%d;%d;%dm  \e[0m" $r $g $b
    end
end

# Print a newline at the end
echo
