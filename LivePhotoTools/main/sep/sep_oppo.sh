#!/bin/bash
# 拆分 - OPPO

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

# ************************************************

outputDir="${fatherDir}/OUTPUT/SEP"

# ************************************************

ee "${ye}"
ee "********************************"
ee "动态照片工具箱 - 拆分 - OPPO"
ee "---- V$versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${res}"

# 单文件模式
getLivePhotoDir() {
    ee "${bye}输入 OPPO 动态照片文件路径(仅一张哦)${res}"
    read livePhotoDir
    # 检查文件是否存在
    if [[ ! -f $livePhotoDir ]]; then
        ee "${bre}文件${livePhotoDir}不存在，请重新输入${res}"
        getLivePhotoDir
    fi
    # 通过获取偏移值检查是否为动态照片文件
    videoOffset="$(exiftool -DirectoryItemLength $livePhotoDir | awk -F: '{ $1=""; print $0 }' | sed 's/^[ \t]*//')"
    if [[ $videoOffset == '' ]]; then
        ee "${bre}文件${livePhotoDir}可能不是 OPPO 动态照片格式，请重新输入${res}"
        getLivePhotoDir
        exit 0
    fi
    main
}

# 文件夹模式
getLivePhotoDirD() {
    ee "${bye}输入 OPPO 动态照片文件夹路径${res}"
    read livePhotoDirD
    # 检查目录是否存在
    if [[ ! -d $livePhotoDirD ]]; then
        ee "${bre}目录${livePhotoDirD}不存在，请重新输入${res}"
        getLivePhotoDirD
        exit 0
    fi

    # 获取文件夹内所有文件
    livePhotoFiles=($(find "$livePhotoDirD" -type f -name "*.jpg"))
    if [[ ${#livePhotoFiles[@]} -eq 0 ]]; then
        ee "${bre}目录${livePhotoDirD}中没有找到任何 OPPO 动态照片文件，请重新输入${res}"
        getLivePhotoDirD
        exit 0
    fi
    
    allNum=${#livePhotoFiles[@]}
    ee "${ye}找到${allNum}个动态照片文件，准备处理...${res}"

    # 遍历文件列表并处理
    for livePhotoDir in "${livePhotoFiles[@]}"; do
        processFile "$livePhotoDir"
    done

    ee "${gr}[ 文件夹模式任务完成 $okeyNum / $allNum ] *****************${res}"
}

# 处理单个文件
processFile() {
    local file="$1"
    
    # 获取文件信息
    videoOffset="$(exiftool -DirectoryItemLength "$file" | awk -F: '{ $1=""; print $0 }' | sed 's/^[ \t]*//')"
    if [[ $videoOffset == '' ]]; then
        ee "${bre}文件${file}可能不是 OPPO 动态照片格式，跳过${res}"
        noOkeyNum=$(expr $noOkeyNum + 1)
        return
    fi
    
    fileSize=$(stat -c %s "$file") # 文件总大小
    staticSize=$(expr ${fileSize} - ${videoOffset}) # 静态图像大小
    
    ee "${gr}成功获取到动态照片信息${res}"
    ee "- 总大小: ${fileSize}B"
    ee "- 偏移值: $videoOffset"
    
    ee "${ye}构建输出目录...${res}"
    outputFileDir="${outputDir}/$(basename "$file" | cut -d'.' -f1)"
    mkdir -p "$outputFileDir"
    
    ee "${ye}开始提取...${res}"
    
    ee "- 开始提取静态图片"
    dd if="$file" of="${outputFileDir}/image.jpg" count="$staticSize" bs=1
    
    ee "- 静态图片提取完成，开始提取视频"
    dd if="$file" of="${outputFileDir}/video.mp4" skip="$staticSize" count="$videoOffset" bs=1
    
    ee "${gr}$(basename "$file") | 提取完毕${res}"
    okeyNum=$(expr $okeyNum + 1)
}

# 主函数
main() {
    if [[ $mode == 'a' ]]; then
        allNum=1
        processFile "$livePhotoDir"
    else
        getLivePhotoDirD
    fi
}

# 主逻辑入口
okeyNum=0
noOkeyNum=0
allNum=0

if [[ $mode == 'a' ]]; then
    getLivePhotoDir
elif [[ $mode == 'b' ]]; then
    getLivePhotoDirD
fi