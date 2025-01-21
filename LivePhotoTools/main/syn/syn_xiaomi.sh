#!/bin/bash
# 合成 - 小米

if [[ $versionYule == '' ]]; then
    echo "请运行脚本根目录的'动态照片工具箱.sh'。"
    exit 1
fi

# ************************************************

outputDir="${fatherDir}/OUTPUT/SYN"

# ************************************************

ee "${ye}"
ee "********************************"
ee "动态照片工具箱 - 合成 - 小米"
ee "---- $versionYule - $OS"
ee "By Yule"
ee "********************************"
ee "${res}"

mkdir -p $outputDir

# 生成 ExifTool 配置文件
generateExifToolConfig() {
    cat >./exiftool_config.conf <<EOF
%Image::ExifTool::UserDefined = (
    'Image::ExifTool::Exif::Main' => {
        0x8897 => {
            Name => 'MicroVideo',
            Writable => 'int8u',
        },
    },
    'Image::ExifTool::XMP::Main' => {
        GCamera => {
            SubDirectory => {
                TagTable => 'Image::ExifTool::UserDefined::GCamera',
            },
        },
    },
);
%Image::ExifTool::UserDefined::GCamera = (
    GROUPS => { 0 => 'XMP', 1 => 'XMP-GCamera', 2 => 'Image' },
    NAMESPACE => { 'GCamera' => 'http://ns.google.com/photos/1.0/camera/' },
    WRITABLE => 'string',
    MicroVideo => { Writable => 'integer' },
    MicroVideoVersion => { Writable => 'integer' },
    MicroVideoOffset => { Writable => 'integer' },
    MicroVideoPresentationTimestampUs => { Writable => 'integer' },
);
1;  # 文件必须以数字 1 结尾
EOF
}

# 获取用户输入
getInput() {
    ee "${bye}请输入静态图片路径${res}"
    read staticImage
    if [[ ! -f $staticImage ]]; then
        ee "${bre}文件 $staticImage 不存在，请重新运行脚本并输入正确路径。${res}"
        exit 1
    fi
    staticImageBasename="$(basename ${staticImage})"
    cp $staticImage $HOME
    staticImage="$HOME/${staticImageBasename}"

    ee "${bye}请输入视频路径${res}"
    read videoFile
    if [[ ! -f $videoFile ]]; then
        ee "${bre}文件 $videoFile 不存在，请重新运行脚本并输入正确路径。${bre}"
        exit 1
    fi
    videoFileBasename="$(basename ${videoFile})"
    cp $videoFile $HOME/
    videoFile="$HOME/${videoFileBasename}"
}

# 格式转换
convertFiles() {
    # 检查静态图片格式，如果不是 JPG，则使用 ffmpeg 转换
    if [[ ${staticImage: -4} != ".jpg" ]]; then
        convertedStaticImage="${staticImage%.*}.jpg"
        ffmpeg -i "$staticImage" "$convertedStaticImage"
        staticImage="$convertedStaticImage"
        ee "${gr}静态图片已转换为 JPG 格式：$staticImage${res}"
    fi

    # 检查视频格式，如果不是 MP4，则使用 ffmpeg 转换
    if [[ ${videoFile: -4} != ".mp4" ]]; then
        convertedVideoFile="${videoFile%.*}.mp4"
        ffmpeg -i "$videoFile" "$convertedVideoFile"
        videoFile="$convertedVideoFile"
        ee "${gr}视频文件已转换为 MP4 格式：$videoFile${res}"
    fi
}

# 合成动态照片
createLivePhoto() {
    ee "${ye}开始合成动态照片...${res}"

    # 获取视频文件大小
    videoFileSize=$(stat -c %s "$videoFile")

    # 将视频文件附加到静态图片后
    cat "$videoFile" >> "$staticImage"

    # 添加 0x8897 特殊 EXIF 标签和其他动态照片的 EXIF 属性
    exiftool -config ./exiftool_config.conf -overwrite_original \
        -MicroVideo=1 \
        -MicroVideoOffset=$videoFileSize \
        -XMP-GCamera:MicroVideo=1 \
        -XMP-GCamera:MicroVideoVersion=1 \
        -XMP-GCamera:MicroVideoOffset=$videoFileSize \
        -XMP-GCamera:MicroVideoPresentationTimestampUs=$((videoFileSize / 2)) \
        -EXIF:0x8897=1 \
        "$staticImage"

    # 生成输出文件名
    outputPhoto="${outputDir}/$(basename "$staticImage" .jpg)_$(basename "$videoFile" .mp4).jpg"

    cp "$staticImage" "$outputPhoto"
    rm -f $staticImage
    rm -f $videoFile
    ee "${bgr}动态照片合成完成，文件已保存为：$outputPhoto${res}"
}

# 清理临时文件
cleanup() {
    rm -f ./exiftool_config.conf
}

# 主逻辑
main() {
    generateExifToolConfig
    getInput
    convertFiles
    createLivePhoto
    cleanup
}

main