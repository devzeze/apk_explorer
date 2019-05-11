# Apk-Explorer

Utilit to explore Android's apk file.


## Description
Apk-Explorer is an utility shell script that performs the following actions to analyse Android's apk files.

1. Uses adb to extract apk from smartphone installed apps.
2. Uses dex2jar to convert apk to a jar file.
3. Uses jd-gui to decompile and explore jar file.


## How to build Apk-Explorer ?
```
> git clone https://github.com/devzeze/apk_explorer.git
> sh apk_explorer_build.sh
```

## Are there any dependencies ?
The Apk-Explorer requires [adb](https://developer.android.com/studio/command-line/adb) installed and in path.


## How to run Apk-Explorer ?
Connect smartphone to computer by usb.

```
> sh apk_explorer_build.sh
> sh apk_explorer_run.sh <package-name>
```


## Third party apps.
Apk-Explorer has dependencies on this submodules.

- [dex2jar](https://github.com/devzeze/dex2jar.git)
- [jd-gui](https://github.com/devzeze/jd-gui.git)


## Authors

* **devzeze** -[GitHub](https://github.com/devzeze)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
