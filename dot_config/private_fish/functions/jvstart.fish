# Quickly start a java project
function jvstart
    set path (realpath ~/Desktop/random-code/java-projects/)/$argv[1]
    cp -r ~/Desktop/random-code/java-projects/template $path
    cd $path/src
    nvim +3 $path/src/Main.java
end
