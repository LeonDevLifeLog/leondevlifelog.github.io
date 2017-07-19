---
title: Android手机局域网调试
categories: Development
toc: true
tags:
  - Android
  - adb
  - WIFI
post_asset_folder: false
date: 2017-07-19 15:22:04
---

数据线忘记带到公司了，目前大部分同事都是用的iPhone手机，导致无法实机调试，于是想到了局域网调试。于是记录一下。

<!--more-->
方法如下

# 手机端开启adb tcp连接端口
```
:/$su
:/#setprop service.adb.tcp.port 5555
:/#stop adbd
:/#start adbd
```
> setprop是用来设置系统属性的
> 需要root权限

# 电脑端的设置和使用
## 连接ADB
连接adb，其中phone_ipaddress和portnumber是指手机的ip和前面设置的监听端口号（如5555）
```
adb connect <phone_ipaddress>:<portnumber>
```
直接`adb shell`或`adb -s`设备shell连接设备

## 断开ADB
```
adb disconnect <phone_ipaddress>:<port>
```