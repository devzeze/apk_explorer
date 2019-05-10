#!/bin/bash


if [ ! "$1" ];then
   echo "Empty argument, please run "
   echo "apk_package_explorer <package_name>"
fi

if ! [ -x "$(command -v adb)" ]; then
  echo "Error: adb is not installed"
  exit 1
fi

echo "Get apk full name"
full_path_name="$(adb shell pm path $1)"
full_path_name=${full_path_name:8}
apk_name=${full_path_name:10}
echo "${full_path_name}"

echo "Pull apk"

adb pull ${full_path_name} ./temp/"$1.apk"
