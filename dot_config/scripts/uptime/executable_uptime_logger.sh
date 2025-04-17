#!/bin/bash

LOG_DIR="$HOME/.local/share/uptime/"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/uptime_log"

log_uptime() {
  local now=$(date +"%Y-%m-%d %H:%M:%S")
  local uptime_secs=$(awk '{print $1}' /proc/uptime)
  local hostname=$(cat /etc/hostname)
  local user=$(whoami)
  echo "$now|$uptime_secs|$hostname|$user" >>"$LOG_FILE"
}

show_total_uptime() {
  local total_secs=$(awk -F '|' '{sum += $2} END {print sum}' "$LOG_FILE")

  # Calculate the days, hours, minutes
  awk -v total="$total_secs" 'BEGIN {
        days = int(total / 86400);
        hours = int((total % 86400) / 3600);
        mins = int((total % 3600) / 60);

        # Print the total uptime in days, hours, minutes
        printf "Total Uptime: %d days, %d hours, %d minutes\n", days, hours, mins;

        # Print the total uptime in hours, minutes (e.g. 3h 28min)
        total_hours = int(total / 3600);
        remaining_minutes = int((total % 3600) / 60);  # Remaining minutes after hours
        printf "Total Uptime: %dh %dmin\n", total_hours, remaining_minutes;
    }'
}

show_sessions() {
  printf 'date       time      uptime           host\tuser\n'
  awk -F '|' '{
        # Calculate the uptime in hours, minutes, and seconds
        uptime = $2;
        hours = int(uptime / 3600);
        minutes = int((uptime % 3600) / 60);
        seconds = int(uptime % 60);

        # Print in the desired format with a fixed width for uptime
        printf "%s  %2dh  %2dmin  %2ds  %s\t%s\n", $1, hours, minutes, seconds, $3, $4
    }' "$LOG_FILE"
}

show_menu() {
  while true; do
    echo -e "\nUptime Logger Menu"
    echo "1. Show total uptime"
    echo "2. Show session list"
    echo "3. Exit"
    read -p "Choose an option: " choice
    case "$choice" in
    1) show_total_uptime ;;
    2) show_sessions ;;
    3) exit 0 ;;
    *) echo "Invalid choice!" ;;
    esac
  done
}

case "$1" in
--menu | -m) show_menu ;;
--total | -t) show_total_uptime ;;
--list | -l) show_sessions ;;
*) log_uptime ;; # Default: Log uptime
esac
