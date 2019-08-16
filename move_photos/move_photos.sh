
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
[ -z "$source_folder" ] && echo "Must have source folder" && exit
[ -z "$dest_folder" ] && echo "Must have destination folder" && exit

if [ "$source_folder" = "$dest_folder" ]; then
  echo "Source folder cannot be the same as destination folder"
  exit
fi

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

# Determine whether to just copy the files over or copy and delete
if [ $delete_source_files = "true" ]; then
  cmd="mv"
else
  cmd="cp"
fi

# Loop through and change files
for file in $source_folder/* ; do
  if [ ! -d "$file" ]; then
    file_name=`echo $file | cut -d '/' -f 2` # Get file name
    file_date=`echo $file | cut -d '/' -f 2 | cut -d '_' -f 1` # take file name and cut everything after the delimiter

    year=`echo $file_date | cut -c1-4`
    month=`echo $file_date | cut -c5-6`
    day=`echo $file_date | cut -c7-8`
    folder_name="$year-$month-$day"

    # Create folder in destination folder corresponding to file date
    if [ ! -d "$dest_folder/$folder_name" ]; then
      echo "Making folder: $folder_name in destination folder"
      mkdir $dest_folder/$folder_name
    fi

    # Copy / Move file
    echo "$cmd $file $dest_folder/$file_date/$file_name"
    `$cmd $file $dest_folder/$folder_name/$file_name`
  fi
done

echo "Success!"

