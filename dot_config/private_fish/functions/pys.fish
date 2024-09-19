# Quickly start a python project
function pys
    set path (realpath ~/Desktop/random-code/python-projects/)/$argv[1]
    cp -r ~/Desktop/random-code/python-projects/template $path
    cd $path/src
    nvim +2 $path/src/main.py
end
