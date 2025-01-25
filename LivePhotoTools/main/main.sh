#!/bin/bash
# 主逻辑跳转脚本

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

cd ${fatherDir}/main

# 查看信息功能
info() {
    ee "${ye}"
    ee "********************************"
    ee "动态照片工具箱 - 查看信息"
    ee "---- V$versionYule - $OS"
    ee "By Yule"
    ee "********************************"
    ee "${res}"
    . "./info/info_all.sh"
}

# 拆分功能
sep() {
    ee "${ye}"
    ee "********************************"
    ee "动态照片工具箱 - 拆分"
    ee "---- V$versionYule - $OS"
    ee "By Yule"
    ee "********************************"
    ee "${res}"
    oneFile() {
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        if [[ $OS == 'MIUI/HyperOS' ]]; then
            . "./sep/sep_xiaomi.sh"
        elif [[ $OS == 'ColorOS' ]]; then
            . "./sep/sep_oppo.sh"
        # elif [[ $OS == 'iOS' ]]; then
            # . "./sep/sep_apple.sh"
        fi
    }
    # 选择模式
    ee "${bye}请选择模式${res}"
    ee "[a] 单文件模式 | 只处理一张照片"
    ee "[b] 文件夹模式 | 处理一个文件夹内所有照片"
    read mode
    if [[ $mode == 'a' ]]; then
        ee "${ye}你选择了 单文件模式${res}"
        oneFile
    elif [[ $mode == 'b' ]]; then
        ee "${ye}你选择了 文件夹模式${res}"
        oneFile
    else
        ee "${bre}输入错误，能不能检查下再回车啊喂! ￣△￣||${res}"
        exit
    fi
}

# 合成功能
syn() {
    ee "${ye}"
    ee "********************************"
    ee "动态照片工具箱 - 合成"
    ee "---- V$versionYule"
    ee "By Yule"
    ee "********************************"
    ee "${res}"
    ee "${re}暂仅支持合成单个小米格式动态照片${res}"
    oneFile() {
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        . "./syn/syn_xiaomi.sh"
    }
    # 选择模式
    ee "${bye}请选择模式${res}"
    ee "[a] 单文件模式 | 只处理一次"
    # ee "[b] 文件夹模式 | 处理一个文件夹"
    read mode
    if [[ $mode == 'a' ]]; then
        ee "${ye}你选择了 单文件模式${res}"
        oneFile
    # elif [[ $mode == 'b' ]]; then
        # ee "${ye}你选择了 文件夹模式${res}"
        # oneFile
    else
        ee "${bre}输入错误，能不能检查下再回车啊喂! ￣△￣||${res}"
        exit
    fi
}

case $1 in
    info)
        info
        ;;
    sep)
        sep
        ;;
    syn)
        syn
        ;;
   *)
esac