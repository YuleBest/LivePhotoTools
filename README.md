# 动态照片工具箱V2

随时合成、拆分你的动态照片

2025年马上就要来了，在这里预祝大家新年快乐！
在新年前一天，动态照片工具箱V2.0也在此发布了，接下来给大家介绍由我带来的全新重构版本！

## [最新版本: V2.3](https://github.com/YuleBest/LivePhotoTools/releases/latest)

```
1. [优化] 终于学会打包 perl 模块了，将 exiftool 和所需的库打包了，大幅降低工具体积。
2. [优化] 更新 exiftool 版本到 13.14。
3. [新增] 在合并功能新增动态照片检测，如果尝试使用动态照片进行合并，会拦截请求并进行提示。
4. [新增] 优化部分注释和判断代码。
5. [修复] linker、chmod 报错。
6. [修复] 拆分动态照片后，系统仍识别为动态照片的问题。
7. [新增] 拆分动态照片后，自动删除和动态照片有关的 EXIF/XMP 标签。
8. [优化] 修改 README.md，让它更详细易懂。
9. [删除] SHA256 文件，原因是太累了。
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

4. 执行文件夹内的 `动态照片工具箱.sh`，选择你需要的功能即可。

5. 生成后的照片和视频会被保存到 `工具同目录/OUTPUT/`。

<details>
  <summary>点击展开/折叠演示图</summary>

  ![1000010987.png](https://maxpcimg.cc/i/2025/01/23/679162a3a9f61.png)

  ![1000010991.jpg](https://maxpcimg.cc/i/2025/01/23/679162a5a8481.jpg)

  ![1000010989.jpg](https://maxpcimg.cc/i/2025/01/23/679162a537719.jpg)

  ![1000010993.jpg](https://maxpcimg.cc/i/2025/01/23/679162a648799.jpg)

</details>

## 参考

- [酷安] (@知湫丶) [苹果实况转为小米动态照片教程](https://www.coolapk.com/feed/61563333)

- [酷安] (@橘子Jun) [国内厂商动态照片/实况照片格式对比](https://www.coolapk.com/feed/61209226)

- [GitHub] (@ZhiQiu-KinSey) [AppleLivePhotoConcert](https://github.com/ZhiQiu-Kinsey/AppleLivePhotoConvert)

- [Android Developers] [动态照片格式1.0](https://developer.android.com/media/platform/motion-photo-format?hl=zh-cn)

- [GitHub] [exiftool](https://github.com/exiftool/exiftool)

- [GitHub] [FFmpeg](https://github.com/FFmpeg/FFmpeg)