# Display items taking up space in specified directory
function here
    if test (count $argv) -eq 0
        du -cha --max-depth=1 ./ | grep -E "M|G"
    else
        du -cha --max-depth=1 $argv[1] | grep -E "M|G"
    end
end
function shere
    if test (count $argv) -eq 0
        sudo du -cha --max-depth=1 ./ | grep -E "M|G"
    else
        sudo du -cha --max-depth=1 $argv[1] | grep -E "M|G"
    end
end
