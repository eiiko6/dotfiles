# Quickly start a java project
function jvstart
    if test (count $argv) -eq 0
        echo "No path specified."
        return
    end
    set path (realpath $(pwd))/$argv[1]
    cp -r ~/Desktop/random-code/java-projects/template $path
    cd $path/src
    cls
end
