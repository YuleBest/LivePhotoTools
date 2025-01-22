#!/bin/bash
versionYule='V2.3'

# ************************************************

# 动态照片工具箱 / Live Photo Tools

# By Yule
# 酷安/CoolApk: http://www.coolapk.com/u/18214705
# GitHub: https://github.com/YuleBest

# ************************************************

# [ 函数与变量定义 ] ********************************

#  获取根目录
fatherDir="$(dirname $(readlink -f $0))"

#  文字和文字背景颜色
gr='\033[0;32m'
ye='\033[1;33m'
re='\033[0;31m'
bre='\033[41m'
bye='\033[43m'
bgr='\033[42m'
res='\033[0m'

#  echo -e 快捷函数
ee() {
    echo -e " $1"
}
#  空行快捷函数
br() {
    ee ''
}
#  日志记录函数
logr() {
    echo "$(date +'%Y-%m-%d %H:%M:%S.%N') | $1" >> $logFile
}
logx() {
    echo "$(date +'%Y-%m-%d %H:%M:%S.%N') | 退出工具。" >> $logFile
}

# 检查环境是否有错误
if [ "$(basename "$HOME")" != "home" ] && [ "$(basename "$HOME")" != "term" ] || [ ! "$HOME" ]; then
    ee "${re}- HOME 路径错误，请不要使用系统环境来执行 ($(basename $(dirname "$HOME")))${res}"
    ee "错误示范: /bin/sh 本工具"
    ee "正确示范: bash 本工具，或使用 MT 扩展包选项"
    exit 1
fi

#  使用 yq 读取配置文件
cp ${fatherDir}/tools/bin/yq ${HOME}/yq
chmod 777 ${HOME}/yq
toolsTrue="$(${HOME}/yq '.ToolTmp' "${fatherDir}/Config.yaml")"
OS=$(${HOME}/yq '.OS' "${fatherDir}/Config.yaml")

if [ $toolsTrue = "HOME" ]; then
    toolsTrue=${HOME}
elif [ ! -d $toolsTrue ]; then
    ee "${re}- 指定的 '工具释放目录' 不存在于设备上 ($toolsTrue)${res}"
    ee "解决方法: 前往 'Config.yaml' 配置正确的工具释放目录"
    exit 1
fi

#  初始化函数
toInitialize() {
    requiredToolsList="exiftool awk sed ffmpeg yq"
    for tool in $requiredToolsList; do
    ee "--- 检查 [$tool]..."
    sleep 0.1
        if ! command -v "$tool" &> /dev/null; then
            ee "${re}-- 工具 [$tool] 没有被安装，将进入初始化${res}"
            ee "${ye}开始初始化，马上就好 (无需联网)${res}"
            . "${fatherDir}/main/init.sh"
            ee "${gr}- 初始化完成，请重新启动工具${res}"
            ee "- bash ${fatherDir}/LivePhotoTools.sh"
            exit 0
        fi
    done # 检查使用到的工具是否安装
}

# 设置环境变量
export PATH=$toolsTrue/livephototools/bin:${PATH}
export LD_LIBRARY_PATH=$toolsTrue/livephototools/lib:${LD_LIBRARY_PATH}
# PERL5LIB=$toolsTrue/livephototools/lib/perl5 $toolsTrue/livephototools/lib/perl5/site_perl/5.38.2

#  选择系统
OSCho() {
    br; br
    if [ -z "$OS" ] || [ "$OS" = "null" ] || ( [ "$OS" != "MIUI/HyperOS" ] && [ "$OS" != "ColorOS" ] ); then
        ee "${re}- 默认系统未设置或设置错误 ($OS)${res}"
        ee "- 解决方法: 前往 'Config.yaml' 配置正确的 'OS'"
        exit 1
    fi
}

# [ 初始化与选择功能 ] ********************************

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
toInitialize
OSCho

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ee "${gr}"
ee "********************************"
ee "动态照片工具箱 / Live Photo Tools"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${res}"

ee "${bye}功能列表 =_=${res}"
ee "[a] 合成静态图片和视频为动态照片(测试版)"
ee "[b] 拆分动态图片为静态图片和视频"
# ee "[c] 对不同系统的动态图片进行转换"
ee "[d] 查看照片 Exif/Xmp 信息"
read fun
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ $fun == 'a' ]]; then
    . "${fatherDir}/main/main.sh" "syn"
elif [[ $fun == 'b' ]]; then
    . "${fatherDir}/main/main.sh" "sep"
# elif [[ $fun == 'c' ]]; then
    # . ${fatherDir}/main/tra.sh
elif [[ $fun == 'd' ]]; then
    . "${fatherDir}/main/main.sh" "info"
elif [[ $fun == 'init' ]]; then
    . ${fatherDir}/main/init.sh
else
    ee "${bre}输入错误，能不能检查下再回车啊喂! ￣△￣||${res}"
fi
