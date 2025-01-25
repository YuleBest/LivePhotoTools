#!/bin/bash
# 在线更新脚本

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

# 获取 GitHub 上最新版本号与本地版本号做对比
# Get the latest version number on GitHub to compare with the local version number
getAndCompare() {
    latestVerNum="$(curl -s "https://api.github.com/repos/YuleBest/LivePhotoTools/releases/latest" | grep '"tag_name":' | sed -E 's/.*"tag_name": "V([0-9]+\.[0-9]+)".*/\1/')"
    localVerNum="$versionYule"
    newVer=0
    
    if awk "BEGIN {exit !($localVerNum < $latestVerNum)}"; then
        newVer=1  # 有更新
    elif awk "BEGIN {exit !($localVerNum > $latestVerNum)}"; then
        newVer=0  # 没有更新
    else
        newVer=0  # 版本号相同
    fi
}

# 下载更新包并进行更新
# Download the update package and update
update() {
    mkdir -p "$HOME/tmp"
    downloadLink="https://github.com/YuleBest/LivePhotoTools/archive/refs/tags/V${latestVerNum}.zip"
    installDir="$(dirname $fatherDir)"
    curl -L -o "$HOME/tmp/LPTUpdate.zip" "$downloadLink"
    unzip -o "$HOME/tmp/LPTUpdate.zip" -d "$installDir"
    rm -rf "$HOME/tmp"
}

getAndCompare
ee "本地版本: V$localVerNum"
ee "最新版本: V$latestVerNum"

if [ $newVer -eq 1 ]; then
    ee "${ye}发现新版本 V$latestVerNum，是否要更新? (Y/n)${res}"
    read toUpdate
    case "$toUpdate" in
        Y)
            update
            [ "$?" != "0" ] && ee "更新失败" && exit 1
            ee "${gr}更新成功 | $installDir${res}"
            ;;
        y)
            update
            [ "$?" != "0" ] && ee "更新失败" && exit 1
            ee "${gr}更新成功 | $installDir${res}"
            ;;
        *)
            ee "取消更新"
    esac
else
    ee "没有发现更新"
fi