function convert2mp3
    if test (count $argv) -ne 1
        echo "Usage: convert2mp3 <input_file>"
        return 1
    end

    set input $argv[1]
    set output (string replace -r '\.(webm|mp4|mkv)$' '.mp3' $input)

    if not test -e $input
        echo "Error: File '$input' does not exist."
        return 1
    end

    ffmpeg -i "$input" -q:a 0 -map a "$output"
    echo "Converted '$input' to '$output'"
end
