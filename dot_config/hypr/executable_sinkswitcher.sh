#!/bin/bash

# Get a list of all sink indexes and names
sinks=($(pactl list short sinks | awk '{print $1}'))
sink_names=($(pactl list short sinks | awk '{print $2}'))

# Get the sink currently used by active audio streams (first found stream)
current_sink=$(pactl list short sink-inputs | awk '{print $3}' | head -n 1)

# Find the index of the current sink in the list of sinks
for i in "${!sinks[@]}"; do
  if [ "${sinks[$i]}" -eq "$current_sink" ]; then
    current_index=$i
    break
  fi
done

# Calculate the next sink index (loop back to the first if at the end)
next_index=$(((current_index + 1) % ${#sinks[@]}))

# Move all current sink inputs (applications playing audio) to the next sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input "$input" "${sinks[$next_index]}"
done

# Send a notification with the name of the new sink
notify-send "Switched output to ${sink_names[$next_index]}"
