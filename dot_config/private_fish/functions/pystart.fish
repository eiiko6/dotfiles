# Quickly start a python project in the current location
function pystart
    if test (count $argv) -eq 0
        echo "No path specified."
        return
    end
    set path (realpath $(pwd))/$argv[1]
    cp -r ~/Desktop/random-code/python-projects/template $path
    cd $path/src
    cls
    vim .
end
