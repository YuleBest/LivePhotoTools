#!/bin/bash
# 初始化脚本

# ************************************************

# 动态照片工具箱 / Live Photo Tools

# By Yule
# 酷安/CoolApk: http://www.coolapk.com/u/18214705
# GitHub: https://github.com/YuleBest

# 本项目使用 MIT 许可证，另外，您在二次传播此工具时，不得抹去任何有关作者的标识、标记、注释等内容
# This project uses the MIT License. In addition, you may not erase any identifying, labeling, commenting, etc. of the author when you distribute this tool a second time.
# https://mit-license.org

# ${fatherDir} 是脚本的根目录
# ${fatherDir}/yule/tools 是存放工具的目录
# ${newDir} 是后续读取的工具路径

newDir="/data/local/tmp/livephototools"
toolsDir="${fatherDir}/yule/tools"

# 首先需要确认路径...
ee "开始初始化..."
ee "$toolsDir"

# 先删除原目录...
rm -rf ${newDir}

# 新建目录用来存储...
ee "新建目录..."
mkdir -p ${newDir}/bin
mkdir -p ${newDir}/lib
# 添加环境变量
export PATH=$PATH:${newDir}/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${newDir}/lib

# 使用tar解包tools.tar到对应目录...
ee "解压工具包..."
# 先把包复制到可执行目录，避免权限问题
mkdir /data/local/tmp/yule
cp ${toolsDir}/tools.tar /data/local/tmp/yule
cp ${toolsDir}/other_lib.tar /data/local/tmp/yule
cd /data/local/tmp/yule
chmod 777 /data/local/tmp/yule/*
tar -xf tools.tar -C ${newDir}/
tar -xf other_lib.tar -C ${newDir}/lib/

# 复制busybox工具以兼容...
cp ${toolsDir}/other_bin/busybox ${newDir}/bin/
chmod -R 777 ${newDir}/bin/busybox
# 获取支持的工具列表
export PATH=$PATH:${newDir}/bin
TOOLS=$(busybox --list)
# 创建软链接
for TOOL in $TOOLS; do
    ln -s "${newDir}/bin/busybox" "${newDir}/bin/${TOOL}"
    ee "创建软链接 ${TOOL} -> busybox"
done

# 设置权限捏
chmod -R 777 ${newDir}
# 再次添加环境变量
export PATH=$PATH:${newDir}/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${newDir}/lib
# 设置@INC
export PERL5LIB=${newDir}/lib/perl5:${newDir}/lib/perl5/site_perl/5.38.2

# 测试Exiftool和perl
exiftool ${fatherDir}/yule/示例图片/MVIMG_20241230_045126.jpg
perl -V

# 删除临时文件...
rm -rf /data/local/tmp/yule/*
ee "初始化完成!"
