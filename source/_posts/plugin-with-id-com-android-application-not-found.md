---
title: Plugin with id 'com.Android.application' not found
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - Android
post_asset_folder: false
date: 2017-07-14 10:45:30
description:
---

# 错误日志

这个错误是build.gradle造成的，我们打开文件

```
Error:(1, 0) Plugin with id 'com.Android.application' not found.
```

<!--more-->

# 解决方法

打开报错的项目的build.gradle，看看有没有buildscript{ } (应该是没有的，因为就是没有这个东西才报错的)

```
buildscript {
    repositories {
        mavenCentral() // or jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:2.3.0'   //注意版本
    }
}
```