#!/bin/bash

# Create test folders
mkdir move_photos_source
mkdir move_photos_dest

num_files=0
num_incorrectly_named=0

while [ $num_files -lt 10 ]
do
  file_name=20190$(($num_files % 3 + 1))01_29384728937$num_files.jpg
  touch move_photos_source/$file_name
  ((num_files++))
  if [ $(($num_files % 3)) -eq 0 ]; then
    ((num_incorrectly_named++))
  fi
  echo $num_incorrectly_named
done

echo "Created test directories <move_photos_source/> and <move_photos_dest>."
echo "Added $num_files to <move_photos_source/>"
echo "$num_incorrectly_named were incorrectly named"

