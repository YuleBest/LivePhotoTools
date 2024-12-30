#!/bin/bash
# 拆分 - Apple  

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

# ************************************************

outputDir="${fatherDir}/输出文件/拆分"

# ************************************************

ee "${ye}"
ee "********************************"
ee "动态照片工具箱 - 拆分 - Apple"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${ba}"