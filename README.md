# 动态照片工具箱V2

随时合成、拆分你的动态照片

2025年马上就要来了，在这里预祝大家新年快乐！
在新年前一天，动态照片工具箱V2.0也在此发布了，接下来给大家介绍由我带来的全新重构版本！

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

2. 前往[MT管理器官网](https://mt2.cn/)下载并安装MT管理器。

3. 使用MT管理器打开下载的压缩包，你会看到一个文件夹，解压它到任意目录。

4. 执行文件夹内的`动态照片工具箱.sh`，不必使用"拓展包"。

5. 执行后，根据提示选择要操作的动态照片对应的系统(可设置默认)，然后选择你需要的功能即可。

## 参考

- [酷安] (@知湫丶) 苹果实况转为小米动态照片教程 https://www.coolapk.com/feed/61563333

- [酷安] (@橘子Jun) 国内厂商动态照片/实况照片格式对比 https://www.coolapk.com/feed/61209226

- [GitHub] (@ZhiQiu-KinSey) AppleLivePhotoConcert https://github.com/ZhiQiu-Kinsey/AppleLivePhotoConvert

- [Android Developers] 动态照片格式1.0 https://developer.android.com/media/platform/motion-photo-format?hl=zh-cn

- [GitHub] exiftool https://github.com/exiftool/exiftool

- [GitHub] FFmpeg https://github.com/FFmpeg/FFmpeg
