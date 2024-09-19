# Helper to trim audio with ffmpeg
function trima
    if test (count $argv) -lt 5
        echo "Usage: trim <input> <start_time> <end_time> <bitrate> <output>"
        return 1
    end

    set input $argv[1]
    set start_time $argv[2]
    set end_time $argv[3]
    set output $argv[5]

    ffmpeg -i $input.mp3 -ss $start_time -to $end_time -c copy $output
end
