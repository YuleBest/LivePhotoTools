#!/bin/bash
# 初始化脚本

# ${fatherDir} 是脚本的根目录
# ${fatherDir}/yule/tools 是存放工具的目录
# ${newDir} 是后续读取的工具路径

newDir="$toolsTrue/livephototools"
toolsDir="${fatherDir}/tools"

# 首先需要确认路径...
ee "开始初始化..."

# 先删除原目录...
rm -rf ${newDir}

# 新建目录用来存储...
ee "新建目录..."
mkdir -p ${newDir}/bin
mkdir -p ${newDir}/lib
# 添加环境变量
export PATH=$PATH:${newDir}/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${newDir}/lib

# 复制文件
ee "复制文件..."
cp -r ${toolsDir}/bin/* ${newDir}/bin/
cp -r ${toolsDir}/lib/* ${newDir}/lib/
chmod -R 777 ${newDir}

# 配置busybox以兼容...
ee "配置 busybox..."
# 获取支持的工具列表
TOOLS=$(busybox --list)
# 创建软链接
for TOOL in $TOOLS; do
    ln -s "${newDir}/bin/busybox" "${newDir}/bin/${TOOL}"
done

# 设置权限捏
chmod -R 777 ${newDir}
ee "初始化完成!"