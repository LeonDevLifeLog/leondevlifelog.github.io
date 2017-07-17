---
title: Linux下Android模拟器无法启动
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - Android
post_asset_folder: false
date: 2017-07-17 17:24:32
description:
---

# 错误日志

Linux下Android模拟器无法启动，报错找不到i965_dri.so

<!--more-->

```
Cannot launch AVD in emulator.
Output:
libGL error: unable to load driver: i965_dri.so
libGL error: driver pointer missing
libGL error: failed to load driver: i965
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
X Error of failed request:  GLXBadContext
  Major opcode of failed request:  154 (GLX)
  Minor opcode of failed request:  6 (X_GLXIsDirect)
  Serial number of failed request:  49
  Current serial number in output stream:  48
libGL error: unable to load driver: i965_dri.so
libGL error: driver pointer missing
libGL error: failed to load driver: i965
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
X Error of failed request:  GLXBadContext
  Major opcode of failed request:  154 (GLX)
  Minor opcode of failed request:  6 (X_GLXIsDirect)
  Serial number of failed request:  49
  Current serial number in output stream:  48
libGL error: unable to load driver: i965_dri.so
libGL error: driver pointer missing
libGL error: failed to load driver: i965
libGL error: unable to load driver: swrast_dri.so
libGL error: failed to load driver: swrast
emulator: WARNING: VM heap size set below hardware specified minimum of 228MB
X Error of failed request:  BadValue (integer parameter out of range for operation)
emulator: WARNING: Setting VM heap size to 384MB
  Major opcode of failed request:  154 (GLX)
  Minor opcode of failed request:  24 (X_GLXCreateNewContext)
  Value in failed request:  0x0
  Serial number of failed request:  33
  Current serial number in output stream:  34
QObject::~QObject: Timers cannot be stopped from another thread
```

# 解决方法

## 方法一

``` bash
emulator -avd Nexus_5X_API_23_x86 -use-system-libs #使用系统库
```

## 方法二

``` bash
ln -sf /usr/lib/libstdc++.so.6  tools/lib64/libstdc++/libstdc++.so.6 #给库做个链接
```
