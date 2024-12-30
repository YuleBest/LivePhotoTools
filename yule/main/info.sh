#!/bin/bash
# 查看信息主脚本

# ************************************************

# 动态照片工具箱 / Live Photo Tools

# By Yule
# 酷安/CoolApk: http://www.coolapk.com/u/18214705
# GitHub: https://github.com/YuleBest

# 本项目使用 MIT 许可证，另外，您在二次传播此工具时，不得抹去任何有关作者的标识、标记、注释等内容
# This project uses the MIT License. In addition, you may not erase any identifying, labeling, commenting, etc. of the author when you distribute this tool a second time.
# https://mit-license.org

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

cd ./yule/main/

ee "${ye}"
ee "********************************"
ee "动态照片工具箱 - 查看信息"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${ba}"

oneFile() {
    clear
    if [[ $OS == 'MIUI/HyperOS' ]]; then
        . "./信息/info_xiaomi.sh"
    elif [[ $OS == 'ColorOS' ]]; then
        . "./信息/info_oppo.sh"
    elif [[ $OS == 'iOS' ]]; then
        . "./信息/info_apple.sh"
    fi
}

oneFile
