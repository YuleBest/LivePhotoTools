# 动态照片工具箱V2

随时合成、拆分你的动态照片

2025年马上就要来了，在这里预祝大家新年快乐！
在新年前一天，动态照片工具箱V2.0也在此发布了，接下来给大家介绍由我带来的全新重构版本！

## [最新版本: V2.2](https://github.com/YuleBest/LivePhotoTools/releases/latest)

```
1. [修复] Termux 导出文件路径错误。
2. [修复] 工具的错误使用。
3. [修复] 初始化阶段的不流畅以及错误引用。
4. [新增] 配置文件 Config.yaml，你现在可以使用此文件来个性化。
5. [新增] SHA256 校验防篡改系统，可选择是否开启 (Config.yaml)。
6. [优化] 目录和文件结构，使用全英文路径。
7. [优化] 将几个分散的脚本合成为一个。
8. [优化] 部分函数与变量的命名。
9. [优化] 所有脚本文件开头的声明。
10. [优化] 脚本运行性能。
11. [优化] 去除多余的压缩，方便上传 GitHub 以及性能优化。
12. [优化] 初始化环境的步骤与文件操作，适配无 Root 设备，你可以自定义工具释放目录 (Config.yaml)。
13. [优化] 使用分割线来分割区域而不是 Clear。
```

## 项目简介

本项目基于Exiftool和FFmpeg，旨在使用Shell便携地对动态照片进行合并、拆分等操作。

目前支持：小米系与OPPO系的动态照片格式的拆分；小米系动态照片格式的合并。

本项目已在GitHub上进行开源，安全绿色，不会将你的任何数据进行需求以外的处理，欢迎检阅代码：[GitHub](https://github.com/YuleBest/LivePhotoTools)

## 功能介绍

- 合并：使用静态图片+视频合成一个动态照片。

    合成的照片可以在抖音、小红书等社交媒体平台的发布，支持使用Google相册和小米相册进行查看，目前，合并功能仅支持合并为小米系格式，OPPO系与Apple系正在研究和开发。

- 拆分：将一张动态照片拆分为静态图片+视频。

    支持小米系和OPPO系动态照片的拆分，Apple系正在研究和开发。可以使用文件夹模式，工具会自动处理文件夹下所有符合条件的照片。

- 查看信息：查看一张图片的Exif、Xmp等信息。

    支持将信息导出到文件，支持多语言。

## 使用方法

1. 在[123云盘](https://www.123684.com/s/iBeVVv-yNHV)或[GitHub Release](https://github.com/YuleBest/LivePhotoTools)下载最新版本，你会得到一个压缩包。

2. 打开你下载的压缩包，你会看到一个文件夹，解压它到任意目录。

3. 在 `Config.yaml` 进行配置。

4. 执行文件夹内的`动态照片工具箱.sh`，选择你需要的功能即可。

## 参考

- [酷安] (@知湫丶) [苹果实况转为小米动态照片教程](https://www.coolapk.com/feed/61563333)

- [酷安] (@橘子Jun) [国内厂商动态照片/实况照片格式对比](https://www.coolapk.com/feed/61209226)

- [GitHub] (@ZhiQiu-KinSey) [AppleLivePhotoConcert](https://github.com/ZhiQiu-Kinsey/AppleLivePhotoConvert)

- [Android Developers] [动态照片格式1.0](https://developer.android.com/media/platform/motion-photo-format?hl=zh-cn)

- [GitHub] [exiftool](https://github.com/exiftool/exiftool)

- [GitHub] [FFmpeg](https://github.com/FFmpeg/FFmpeg)