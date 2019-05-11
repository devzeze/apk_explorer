#!/bin/bash

if ! [ -x "$(command -v adb)" ]; then
  echo "--------- Error: adb is not installed"
  exit 1
fi


if [ ! "$1" ];then
   echo "--------- Empty argument, please run"
   echo "--------- apk_package_explorer <package_name>"
   exit 1
fi


echo "--------- Get apk full name"
full_path_name="$(adb shell pm path $1)"
full_path_name=${full_path_name:8}
apk_name=${full_path_name:10}
echo "${full_path_name}"

echo "--------- Pull apk"
adb pull ${full_path_name} ./temp/"$1.apk"

echo "--------- Convert to jar"
dex2jar/d2j-dex2jar.sh -f ./temp/"$1.apk" -o ./temp/"$1.jar"

echo "--------- Open in jd-gui"
open -a JD-GUI ./jd-gui/JD-GUI.app ./temp/"$1.jar"

