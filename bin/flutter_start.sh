#!/bin/bash

if [[ -n $1 ]]; then
  flutter run --debug -d "$1"
  exit $?
fi

devices=$(flutter devices --machine)
device_ids=$(echo "$devices" | jq -r '.[].id')

device_array=()
for device in $device_ids; do
  device_array+=("$device")
done

echo "Please select a device:"
for i in "${!device_array[@]}"; do
  printf "%d) %s\n" $((i + 1)) "${device_array[$i]}"
done

read -r -p "Enter the number of your choice: " choice
selected_device=${device_array[$((choice - 1))]}
flutter run --debug -d "$selected_device"
