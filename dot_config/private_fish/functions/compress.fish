# Compress a file and convert from mkv to mp4
function compress
    if test (count $argv) -lt 3
        echo "usage: compress <input_video_name> <output_video_name> <resolution_factor>"
        return 1
    end

    set input_file $argv[1]
    set output_file $argv[2]
    set resolution_factor $argv[3]

    set file_extension (string split -r . $input_file)[-1]

    if test $file_extension = mkv
        ffmpeg -i $input_file -vf "scale=iw*$resolution_factor:ih*$resolution_factor, pad=iw:ih:0:0:color=black" -map 0 -c:v libx264 -c:a aac -loglevel warning $output_file.mp4
    else if test $file_extension = mp4
        echo "The file is already in mp4 format. Skipping conversion."
        ffmpeg -i $input_file -vf "scale=iw*$resolution_factor:ih*$resolution_factor, pad=iw:ih:0:0:color=black" -map 0 -c:v libx264 -c:a aac -loglevel warning $output_file.mp4
    else
        echo "Unsupported file format: $file_extension. Please use an mkv or mp4 file."
        return 1
    end
end
