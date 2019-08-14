
#!/bin/bash

### Purpose ###
# What does this script do? Automate moving photos from my phone to backup drive
# All photos of a given date will be moved to the folder with the matching date.
# If the folder does not exist, then the folder will be created with (TODO) for unknown information

# To run: `./move_photos <Folder with photos you want to move> <Destination Folder>`
# Note: If script won't run, make the script executable with `chmod +x move_photos.sh`

# Folder structure: YYYY-MM-DD Activity (Initials)
# Ex: I went to the Golden Gate Bridge on 7/4/2019
# Folder Name: 2019-07-04 Golden Gate Bridge (I)

# Photos are named with a date and timestamp in the following format:
# Image name structure: YYYYMMDD_ABCDEF.jpg
##############

source_folder=$1
dest_folder=$2
delete_source_files=$3

# TODO: nil check and check not the same folder and variables exist
echo 'Moving photos from' $1 'to' $2 # TODO: Make this cleaner for file paths

# Check I can access source & destination folders
if [ ! -d "$source_folder" ]; then
  echo "Error: Directory $source_folder does not exists."
  exit 1
fi
if [ ! -d "$dest_folder" ]; then
  echo "Error: Directory $dest_folder does not exist."
  exit 1
fi

source_folder_file_count=$(ls -1q $source_folder | wc -l)
dest_folder_file_count=$(ls -1q $dest_folder | wc -l)

echo "$source_folder has $source_folder_file_count files"
echo "$dest_folder has $dest_folder_file_count files"

# Exit if source_folder has no files
if [ "$source_folder_file_count" -eq "0" ]; then
  echo "Nothing to transfer"
  exit;
fi

echo "Success!"
