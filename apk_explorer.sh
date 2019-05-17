#!/bin/bash

if [ ! "$1" ]; then
   echo "--------- Empty argument, please run"
fi

if [ ! "$1" ] || [[ $1 = "-h" ]]; then
   echo "--------- sh apk_explorer.sh with options:"
   echo "--------- -h                   Help"
   echo "--------- -b                   Build modules"
   echo "--------- -x <package_name>    Extract apk, explore and decompile"
   echo "--------- -e <apk_path>        Explore apk and decompile"
   echo "--------- -d <jar_path>        Decompile jar file"
   exit 1

fi

if ! [ -x "$(command -v adb)" ]; then
    echo "--------- Error: adb is not installed"
    exit 1
fi


if  [[ $1 = "-b" ]]; then
############################################################
#           command Run -b
############################################################

    echo "--------- Build dependencies"
    echo "--------- Build dex2jar"
    (cd submodules/dex2jar; ./gradlew clean)
    (cd submodules/dex2jar; ./gradlew build)
    (cd submodules/dex2jar; ./gradlew distZip)


    echo "--------- Copy dex2jar"
    rm -rf ./dex2jar
    unzip ./submodules/dex2jar/dex-tools/build/distributions/dex-tools-*.zip -d ./dex2jar
    mv dex2jar/dex-tools*/* dex2jar/
    rm -rf dex2jar/dex-tools*


    echo "--------- Build jd-gui"
    (cd submodules/jd-gui; ./gradlew clean)
    (cd submodules/jd-gui; ./gradlew build)

    echo "--------- Copy jd-gui"
    rm -rf ./jd-gui
    unzip ./submodules/jd-gui/build/distributions/jd-gui-osx*.zip -d ./jd-gui
    mv jd-gui/jd-gui*/* jd-gui/
    rm -rf jd-gui/jd-gui*


    echo "--------- Build complete"
    echo "--------- Congrats"
    exit 1

fi

if  [[ $1 = "-x" ]]; then
############################################################
#           command Extract
############################################################

    if [ ! "$2" ]; then
        echo "--------- Empty argument, please run"
        echo "--------- -x <package_name>    Extract apk, explore and decompile"
        exit 1
    fi

    echo "--------- Get apk full name $2"
    full_path_name="$(adb shell pm path $2)"
    full_path_name=${full_path_name:8}
    apk_name= ${full_path_name:10}

    echo "--------- Pull apk ${full_path_name}"
    adb pull ${full_path_name} ./temp/"$2.apk"

    
fi

if  [[ $1 = "-x" ]] || [[ $1 = "-e" ]]; then
############################################################
#           command Explore -e   %   Extract -x
############################################################

    if [ ! "$2" ]; then
        echo "--------- Empty argument, please run"
        echo "--------- -e <apk_path>        Explore apk and decompile"
        exit 1
    fi

    echo "--------- Convert to jar"
    if [[ $1 = "-x" ]]; then
        apk_file=./temp/"$2.apk"
        jar_file=./temp/"$2.jar"
        dex2jar/d2j-dex2jar.sh -f ${apk_file} -o ${jar_file}
    else
        apk_file=$2
        jar_file=${apk_file/.apk/.jar}
        dex2jar/d2j-dex2jar.sh -f ${apk_file} -o ${jar_file}
    fi
    
fi

if  [[ $1 = "-d" ]] || [[ $1 = "-x" ]] || [[ $1 = "-e" ]]; then
############################################################
#           command Decompile -d   &   Explore -e   %   Extract -x
############################################################

    if [ ! "$2" ]; then
        echo "--------- Empty argument, please run"
        echo "--------- -d <jar_path>        Decompile jar file"
        exit 1
    fi
    
    if [[ $1 = "-d" ]]; then
        jar_file=$2
    fi

    echo "--------- Open in jd-gui"
    open -a JD-GUI ./jd-gui/JD-GUI.app ${jar_file}

fi