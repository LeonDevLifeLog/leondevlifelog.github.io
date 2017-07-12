---
title: APK Installation failed with message Invalid File
categories: ErrorLog
toc: false
tags:
  - ErrorLog
  - Android
post_asset_folder: false
date: 2017-07-12 13:36:39
description:
---

# 错误信息如下:
利用Android studio debug时安装不上apk,一直报错,错误日志如下:

```
Installation failed with message Invalid File: D:\project\app\build\intermediates\split-apk\with_ImageProcessor\debug\slices\slice_0.apk. It is possible that this issue is resolved by uninstalling an existing version of the apk if it is present, and then re-installing.

WARNING: Uninstalling will remove the application data!

Do you want to uninstall the existing application?
```

<!--more-->

# 解决方法
## 方案一
```
Click Build tab ---> Clean Project

Click Build tab ---> Build APK

Run.
```
## 方案二
打开`settings`>`build,execute,deployment`>`instant run`>
`Enable instant run to hot swap code /resource change on deploy`(取消选中此项)