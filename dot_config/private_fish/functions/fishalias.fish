# List all the aliases defined in fish
function fishalias
    set config_file ~/.config/fish/config.fish

    # Use grep to find lines that define aliases
    set aliases $(grep '^alias ' $config_file)

    for line in $aliases
        # Use string manipulation to extract alias and command
        set name (string split '=' $line)[1]
        set command (string split '=' $line)[2]

        # Echo the formatted output
        echo "alias: '$name'"
        echo "  command: '$command'"
        echo ----------
    end
end
