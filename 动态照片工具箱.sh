#!/bin/bash
versionYule='V2.0'

# ************************************************

# 动态照片工具箱 / Live Photo Tools

# By Yule
# 酷安/CoolApk: http://www.coolapk.com/u/18214705
# GitHub: https://github.com/YuleBest

# 本项目使用 MIT 许可证，另外，您在二次传播此工具时，不得抹去任何有关作者的标识、标记、注释等内容
# This project uses the MIT License. In addition, you may not erase any identifying, labeling, commenting, etc. of the author when you distribute this tool a second time.
# https://mit-license.org

# [ 函数与变量定义 ] ********************************

# < 工具根目录 >
fatherDir="$PWD"

# < 文字和文字背景颜色 >
gr='\033[0;32m'
ye='\033[1;33m'
re='\033[0;31m'
bre='\033[41m'
bye='\033[43m'
bgr='\033[42m'
ba='\033[0m'
# < 文件列表 >
filesList="./yule/record/filesList"
# < 默认系统配置 >
defaultOS=$(cat "./yule/record/defaultOS")
# < 环境 >
toolsTrue="/data/local/tmp/livephototools"

# < echo -e 快捷函数 >
ee() {
    echo -e " $1"
}
# < 空行快捷函数 >
br() {
    ee ''
}
# < 日志记录函数 >
logr() {
    echo "$(date +'%Y-%m-%d %H:%M:%S.%N') | $1" >> $logFile
}
logx() {
    echo "$(date +'%Y-%m-%d %H:%M:%S.%N') | 退出工具。" >> $logFile
}
# < 初始化函数 >
toInitialize() {
    # 关闭link提示
    export LD_WARN=0
    # 先设置环境变量，避免兼容性问题
    export PATH=/product/bin:/apex/com.android.runtime/bin:/apex/com.android.art/bin:/system_ext/bin:/system/bin:/system/xbin:/odm/bin:/vendor/bin:/vendor/xbin
    # 文件列表路径
    filelist="./yule/tools/filelist"
    newFilelist="/data/local/tmp/current_filelist.txt"
    # 生成现在的filelist
    find /data/local/tmp/livephototools/ -type f -print > $newFilelist
    # 比较文件列表
    if cmp -s $filelist $newFilelist; then
      ee "${bgr}所有文件验证完成，无异常${ba}"
      rm -f $newFilelist
    else
      ee "${bye}有文件缺失，进行初始化~请稍等${ba}"
      # 初始化
      ee "${ye}开始初始化，马上就好...${ba}"
      sleep 2
      . ./yule/main/initialize.sh
      ee "${bgr}初始化完毕，正在重启工具...${ba}"
      sleep 2
      # 重新cd回根目录
      cd ${fatherDir}
      # 重新启动，初始化完成
      . ./动态照片工具箱.sh
      exit 0
    fi
    # 然后我们要设置环境变量以使用exiftool和ffmpeg
    export PATH=$PATH:/data/local/tmp/livephototools/bin
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/data/local/tmp/livephototools/lib
    export PERL5LIB=/data/local/tmp/livephototools/lib/perl5:/data/local/tmp/livephototools/lib/perl5/site_perl/5.38.2
}
# < 选择系统 >
choiceOS() {
    br
    ee "${bye}请选择你要操作的动态照片拍摄时使用的系统 (￣ε￣*)${ba}"
    ee "(动态照片用什么系统拍摄的)"
    ee "[m] MIUI/HyperOS"
    ee "[c] ColorOS"
    # ee "[i] iOS"
    read OS
    if [[ $OS == 'm' ]]; then
        OS='MIUI/HyperOS'
    elif [[ $OS == 'c' ]]; then
        OS='ColorOS'
    # elif [[ $OS == 'i' ]]; then
        # OS='iOS'
    else
        ee "${bre}输入错误，能不能检查下再回车啊喂! ￣△￣||${ba}"
        exit 1
    fi
    ee "${bye}你选择了 ${OS}，要设为默认值么${ba}"
    ee "[y] 好"
    ee "[n] 不好"
    read default
    if [[ $default == "y" ]]; then
        echo "$OS" > "./yule/record/defaultOS"
    fi
}

# [ 初始化与选择功能模块和系统 ] ********************************

clear
toInitialize

if [[ $defaultOS == '' ]]; then
    ee "${ye}你还没有设置默认系统...${ba}"
    choiceOS
else
    ee "${ye}默认系统: ${defaultOS}${ba}"
    OS="$defaultOS"
fi

clear
ee "${gr}"
ee "********************************"
ee "动态照片工具箱 / Live Photo Tools"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${ba}"

ee "${bye}功能列表 =_=${ba}"
ee "[h] 合成静态图片和视频为动态照片(测试版)"
ee "[c] 拆分动态图片为静态图片和视频"
# ee "[z] 对不同系统的动态图片进行转换"
ee "[e] 查看照片 Exif/Xmp 信息"
ee "[u] 查看更新日志"
ee "[d] 清除默认设置"
read fun
clear

if [[ $fun == 'h' ]]; then
    . ./yule/main/syn.sh
elif [[ $fun == 'c' ]]; then
    . ./yule/main/sep.sh
# elif [[ $fun == 'z' ]]; then
    # . ./yule/main/tra.sh
elif [[ $fun == 'e' ]]; then
    . ./yule/main/info.sh
elif [[ $fun == 'u' ]]; then
    echo "$(cat ./yule/Change)"
elif [[ $fun == 'd' ]]; then
    echo '' > ./yule/record/defaultOS
    sh ./动态照片工具箱.sh
elif [[ $fun == 'test' ]]; then
    . ./yule/main/initialize.sh
else
    ee "${bre}输入错误，能不能检查下再回车啊喂! ￣△￣||${ba}"
fi
