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
  echo "---------------------i: $i------------------------"
  #jhead -model "COOLPIX AW110" $i
  #current_jhead=$(jhead -model "COOLPIX AW110" $i)
  #current_file_name=$(echo $current_jhead | cut -d$':' -f2 | cut -d$'.' -f1)
  jhead "$i"
  if [[ $(jhead -model "COOLPIX AW110" "$i" | wc -m) -gt 0 ]]; then
    echo "$i is a NIKON photo"
  else
    echo "$i failed"
    continue
  fi
  #current_file_name+=".JPG"
  jhead "$i"
  #echo $current_file_name
  jhead -ta+00:17 "$i"
  jhead "$i"
done #do jhead "$i"; done

echo "Complete"
