#!/bin/bash

echo --------- Build dependencies
echo --------- Build dex2jar
(cd submodules/dex2jar; ./gradlew clean)
(cd submodules/dex2jar; ./gradlew build)
(cd submodules/dex2jar; ./gradlew distZip)


echo --------- Copy dex2jar
rm -rf ./dex2jar
unzip ./submodules/dex2jar/dex-tools/build/distributions/dex-tools-*.zip -d ./dex2jar


echo --------- Build jd-gui
(cd submodules/jd-gui; ./gradlew clean)
(cd submodules/jd-gui; ./gradlew build)

echo --------- Copy jd-gui
rm -rf ./jd-gui
unzip ./submodules/jd-gui/build/distributions/jd-gui-osx*.zip -d ./jd-gui

echo --------- Build complete
