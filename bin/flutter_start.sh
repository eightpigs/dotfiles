#!/bin/bash

# 获取设备列表
devices=$(flutter devices --machine)

# 使用 jq 提取设备列表
device_ids=$(echo "$devices" | jq -r '.[].id')

# 创建一个数组存储设备 id
device_array=()
for device in $device_ids
do
  device_array+=("$device")
done

# 显示设备列表供用户选择
echo "Please select a device:"
for i in "${!device_array[@]}"; do
  printf "%d) %s\n" $((i+1)) "${device_array[$i]}"
done

# 读取用户输入
read -p "Enter the number of your choice: " choice

# 获取所选设备的 id
selected_device=${device_array[$((choice-1))]}

# 使用所选设备的 id 运行 flutter 应用
flutter run --debug -d "$selected_device"
