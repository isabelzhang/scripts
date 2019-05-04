#!/bin/bash
echo "Running hello_world.sh ..."

log_file="time_log.md"
dir_status="status"
prev_date_file="status/prev_date"

current_date=`date +"%D"` # 05/03/19
current_day=`date +"%A"` # Friday
current_time=`date +"%I:%M %p"` # 11:11 PM

# Create status/ if it doesn't exist
if [ ! -d "$dir_status" ]; then
	mkdir "$dir_status";
fi

touch $log_file
touch $prev_date_file

prev_date=`cat $prev_date_file`

if [[ -z "$prev_date" || "$prev_date" < "$current_date" ]]; then
	# Write date into the log file
	echo "" >> "$log_file" 
	echo "## " $current_date " ("$current_day")" >> "$log_file";

	# Overwrite last date in date file
	echo $current_date > "$prev_date_file";
fi

# Ask for input
read -p "Enter activity: " activity_input

if [ -f "$log_file" ]; then
	echo **[$current_time]** $activity_input >> "$log_file"; # Append to end of $log_file
fi

tail -3 $log_file
