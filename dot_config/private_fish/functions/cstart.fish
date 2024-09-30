# Quickly start a c project in the current location
function cstart
    if test (count $argv) -eq 0
        echo "No path specified."
        return
    end
    set path (realpath $(pwd))/$argv[1]
    cp -r ~/Desktop/random-code/c-projects/template $path
    cd $path/src
    cls
end
