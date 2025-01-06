# Quickly start a python project
function pystart
    set path (realpath ~/Desktop/random-code/python-projects/)/$argv[1]
    cp -r ~/Desktop/random-code/python-projects/template $path
    cd $path/
    nvim +2 $path/main.py
end
