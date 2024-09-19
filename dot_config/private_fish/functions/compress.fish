# Compress a file and convert from mkv to mp4
function compress
    if test (count $argv) -eq 0
        echo "usage: compress <input_video_name>.mkv <output_video_name> <resolution_factor>"
    else
        ffmpeg -i $argv[1] -vf "scale=iw*$argv[3]:ih*$argv[3]" -map 0 -c:v libx264 -c:a aac -loglevel warning $argv[2].mp4
    end
end
