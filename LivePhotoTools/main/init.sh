#!/bin/bash
# 初始化脚本

# ${fatherDir} 是脚本的根目录
# ${fatherDir}/yule/tools 是存放工具的目录
# ${newDir} 是后续读取的工具路径

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

newDir="$toolsTrue/livephototools"
toolsDir="${fatherDir}/tools"

# 确认路径...
ee "开始初始化..."

# 先删除原目录...
rm -rf ${newDir}

# 新建目录用来存储...
ee "新建目录..."
mkdir -p ${newDir}/bin
mkdir -p ${newDir}/lib

# 加入设置文件路径，便于以后适配其他架构
case $(uname -m) in
    aarch64)
        toolsDir="$toolsDir/aarch64"
        ;;
   *)
        ee "${re}我们还没有适配你的 CPU 架构: $(uname -m)${res}"
        exit 1
esac

# 复制文件
ee "复制文件..."
cp -r ${toolsDir}/bin/* ${newDir}/bin/
cp -r ${toolsDir}/lib/* ${newDir}/lib/
chmod -R 777 ${newDir}

# 添加环境变量
export PATH=${newDir}/bin:$PATH
export LD_LIBRARY_PATH=${newDir}/lib:${LD_LIBRARY_PATH}

# 配置busybox以兼容...
ee "配置 busybox..."
# 获取支持的工具列表
TOOLS=$(busybox --list)
# 创建软链接
for TOOL in $TOOLS; do
    ln -s "${newDir}/bin/busybox" "${newDir}/bin/${TOOL}"
done

ee "初始化完成!"