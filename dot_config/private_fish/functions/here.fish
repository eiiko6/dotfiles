# Display items taking up space in specified directory
function here
    if test (count $argv) -eq 0
        du -cha --max-depth=1 ./ | grep -E "M|G" | sort -rh | grep -v total
    else
        du -cha --max-depth=1 $argv[1] | grep -E "M|G" | sort -rh | grep -v total
    end
end
function shere
    if test (count $argv) -eq 0
        sudo du -cha --max-depth=1 ./ | grep -E "M|G" | sort -rh | grep -v total
    else
        sudo du -cha --max-depth=1 $argv[1] | grep -E "M|G" | sort -rh | grep -v total
    end
end
