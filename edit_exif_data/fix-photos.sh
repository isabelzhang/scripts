#!/bin/bash

echo Hello World
source_folder=$1

[ -z "$source_folder" ] && echo "Must have source folder" && exit

if [ ! -d "$source_folder" ]; then
  echo "Error: Directory $source_folder does not exists."
  exit 1
fi

source_folder_file_count=$(ls -1q $source_folder | wc -l)
echo "$source_folder has $source_folder_file_count files"

for i in $source_folder*; do
  current_jhead=$(jhead -model "COOLPIX AW110" "$i")
  # echo $current_jhead
  current_file_name=$(echo $current_jhead | cut -d$':' -f2 | cut -d$'.' -f1)
  if [ -z "$current_jhead" ]; then
    continue
  fi
  current_file_name+=".JPG"
  echo $current_file_name 
  # jhead -ta $current_file_name by desired time
done #do jhead "$i"; done

