#!/bin/bash

if [[ ! -z $1 ]]; then
  flutter run --debug -d "$1"
else
  # 
  devices=$(flutter devices --machine)

  #  jq 
  device_ids=$(echo "$devices" | jq -r '.[].id')

  #  id
  device_array=()
  for device in $device_ids
  do
    device_array+=("$device")
  done

  # 
  echo "Please select a device:"
  for i in "${!device_array[@]}"; do
    printf "%d) %s\n" $((i+1)) "${device_array[$i]}"
  done

  # 
  read -p "Enter the number of your choice: " choice

  #  id
  selected_device=${device_array[$((choice-1))]}

  #  id  flutter 
  flutter run --debug -d "$selected_device"
fi
