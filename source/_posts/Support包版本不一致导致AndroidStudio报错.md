---
title: Support包版本不一致导致AndroidStudio报错
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - Android
post_asset_folder: false
date: 2017-07-18 15:59:47
description:
---

# 错误日志
```
Error:Execution failed for task ':app:processDebugManifest'.
> Manifest merger failed : Attribute meta-data#android.support.VERSION@value value=(25.3.1) from [com.android.support:design:25.3.1] AndroidManifest.xml:27:9-31
  	is also present at [com.android.support:support-v4:26.0.0-alpha1] AndroidManifest.xml:27:9-38 value=(26.0.0-alpha1).
  	Suggestion: add 'tools:replace="android:value"' to <meta-data> element at AndroidManifest.xml:25:5-27:34 to override.
```
<!--more-->
# 解决方法

修改依赖`com.android.support`为统一版本