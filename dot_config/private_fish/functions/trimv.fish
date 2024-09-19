# Helper to trim videos with ffmpeg
function trimv
    if test (count $argv) -lt 5
        echo "Usage: trim <input_video> <start_time> <end_time> <bitrate> <output_video>"
        return 1
    end

    set input_video $argv[1]
    set start_time $argv[2]
    set end_time $argv[3]
    set bitrate $argv[4]
    set output_video $argv[5]

    ffmpeg -i $input_video -ss $start_time -to $end_time -c:v libx264 -c:a aac -strict experimental -b:a $bitrate $output_video
end
