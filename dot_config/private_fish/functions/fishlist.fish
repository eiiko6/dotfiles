# List all the available custom fish functions
function fishlist
    echo "Here are the available fish functions:"

    # Use find to locate all regular files in ~/.config/fish/functions directory
    find ~/.config/fish/functions -type f | sort | while read -l file
        echo ------------------------

        # Print the file name without the extension
        echo "> "(basename $file .fish)

        # Print the first line, stripping any leading '#' characters
        head -n 1 $file | sed 's/^#//'
    end
end
