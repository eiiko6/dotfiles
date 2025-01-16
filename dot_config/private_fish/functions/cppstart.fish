# Quickly start a cpp project in the current location
function cppstart
    if test (count $argv) -eq 0
        echo "No path specified."
        return
    end
    set path (realpath $(pwd))/$argv[1]
    cp -r ~/Desktop/random-code/cpp-projects/template $path
    cd $path/src
    cls
    vim .
end
