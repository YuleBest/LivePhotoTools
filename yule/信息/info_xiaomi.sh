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

lang="zh-cn"

ee "${ye}"
ee "********************************"
ee "动态照片工具箱 - 查看信息 - 小米"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${ba}"

# 获取输入
getPhotoFile() {
    ee "${bye}请输入要查看信息的照片文件路径 (^ ^)${ba}"
    read photoFile
}

# 导出
outputInfo() {
    fileName=$(basename "$photoFile" .*)
    mkdir "${fatherDir}/输出文件/照片信息"
    outputFile="${fatherDir}/输出文件/照片信息/${fileName}_info.txt"
    touch $outputFile
    echo "${photoFile}" >> $outputFile
    echo "${info}" >> $outputFile
    echo "lang: ${lang}" >> $outputFile
    ee "${bgr}已将信息导出为 ${outputFile}."
}

# 设置语言
setLanguage() {
    ee "${bye}请输入语言相对应的代号${ba}"
    ee "[zh-cn] 中文简体"
    ee "[zh-tw] 中文繁体"
    ee "[en]    英文"
    ee "[cs, de, en, en-ca, en-gb, es, fi, fr, it, ja, ko, nl, pl, ru, sk, sv, tr] 自行搜索"
    read lang
    ee "${ye}切换中...${na}"
    getInfo
}

# 使用Exiftool获取信息
getInfo() {
    ee "${ye}获取信息中...${ba}"
    sleep 0.1
    ee "--------------------------------"
    info=$(exiftool -lang ${lang} ${photoFile})
    echo "$info"
    ee "--------------------------------"
    ee "${bgr}获取成功，以上为照片的 Exif/Xmp 信息${ba}"
    ee "[o] 导出到 info.txt"
    ee "[l] 使用其他语言显示(当前:${lang})"
    read more
    
    if [[ $more == 'o' ]]; then
        outputInfo
    elif [[ $more == 'l' ]]; then
        setLanguage
    else
        ee "${bre}输入错误！！${ba}"
    fi
}

# 主逻辑
getPhotoFile
getInfo
