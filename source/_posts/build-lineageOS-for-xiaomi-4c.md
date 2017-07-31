---
title: 为小米4c编译LineageOS(CM/AOSP)14.1系统
categories:
  - AOSP
toc: true
tags:
  - AOSP
  - LineageOS
post_asset_folder: false
date: 2017-07-31 13:46:03
description:
---

既然决定往Android底层走了，不整一份源码怎么行。于是在昨天把LineageOS源码拉下来了，深入学习一下！

<!--more-->

# 说明/建议

1. 能不用镜像就别用镜像，老是出现错误，去搜索错误太浪费时间
2. 除了下载源码，非特别说明，操作都是在docker里的源码根目录
3. 为小米4c编译，codename为libra，给自己设备编译时，注意替换
4. 小米手机使用第三方固件需要解锁bootloader（去官网解）
5. 本人使用Arch Linux，编译环境使用的Docker

# 准备

1. 国际网络（gce一年免费，搞了一台学校的50MB带宽被榨干，还是Google的活动实在）
2. 磁盘100GB（最好SSD）
3. 最低双核CPU
4. Docker

> 从我的电脑配置(6700k CPU,256G SSD,8G RAM)来看，编译的时间还是可以接受的，只用了01:19:06 (hh:mm:ss)。

# 拉取源码

## 下载repo

``` bash
sudo curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo #翻墙下载用下面的命令，proxychain功能自己去百度
#proxychain sudo curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo 
sudo chmod a+x /usr/bin/repo
```

## 下载源码
``` bash
cd <WORK_DIR>
repo init -u https://github.com/LineageOS/android.git -b cm-14.1
repo sync
#proxychain repo sync
```

> 大约需要下载30G，50MB带宽大约用了2~3小时

# 准备编译环境

## 拉取docker镜像

``` bash
docker pull registry.cn-hangzhou.aliyuncs.com/leon/docker-lineageos
```

> dockerfile 源码地址[源码地址](https://code.aliyun.com/leon0516/lineageos-docker)
> 里面有说明
> 使用dockerfile源码里的run.sh来启动镜像，前提要设置run脚本里的SOURCE，CCACHE，OUT三个bash变量

# 准备设备私有文件

## 方法一 从设备提取

### 前提

1. 手机已经root
2. 电脑安装adb工具

### 提取

``` bash
source build/envsetup.sh
cd device/xiaomi/libra
./extract-files.sh #自动连接adb 提取/system里的文件
#文件提取到vendor/xiaomi/libra/ 相对源码根目录
./setup-makefiles.sh
#配置makefile文件
```

## 方法二 TheMuppets（别人提取的）

``` bash
cd vendor/xiaomi
git clone https://github.com/TheMuppets/proprietary_vendor_xiaomi.git .
```

# 进行编译

## 前期准备

``` bash
source build/envsetup.sh
breakfast libra #准备内核和配置文件（需要下载）
```

## 编译

``` bash
source build/envsetup.sh
brunch libra
```

## 编译结果

``` bash
cache_fs_type             = (str) ext4
cache_size                = (int) 402653184
default_system_dev_certificate = (str) build/target/product/security/testkey
device_type               = (str) MMC
extfs_sparse_flag         = (str) -s
extra_recovery_keys       = (str) vendor/cm/build/target/product/security/lineage
fs_type                   = (str) ext4
fstab                     = (dict) {'/cache': <common.Partition object at 0x7f4305d2b1d0>, '/data': <common.Partition object at 0x7f4305d2b590>, '/system': <common.Partition object at 0x7f4305d2b650>, '/recovery': <common.Partition object at 0x7f4305d2b5d0>, '/boot': <common.Partition object at 0x7f4305d2b810>, '/misc': <common.Partition object at 0x7f4305d2b410>}
fstab_version             = (int) 2
mkbootimg_args            = (str) --ramdisk_offset 0x02000000 --tags_offset 0x00000100
mkbootimg_version_args    = (str) --os_version 7.1.2 --os_patch_level 2017-07-05
multistage_support        = (str) 1
ota_override_device       = (str) auto
recovery_api_version      = (int) 3
recovery_as_boot          = (str) 
recovery_mount_options    = (str) ext4=max_batch_time=0,commit=1,data=ordered,barrier=1,errors=panic,nodelalloc
recovery_size             = (int) 67108864
selinux_fc                = (str) /tmp/targetfiles-q3gN1M/META/file_contexts.bin
squashfs_sparse_flag      = (str) -s
system_size               = (int) 2013265920
tool_extensions           = (str) device/xiaomi/libra/../common
update_rename_support     = (str) 1
use_set_metadata          = (str) 1
userdata_size             = (int) 12469648896
unable to load device-specific module; assuming none
using prebuilt recovery.img from BOOTABLE_IMAGES...
using system.img from target-files
Total of 491520 4096-byte output blocks in 5607 input chunks.
Finding transfers...
Generating digraph...
Finding vertex sequence...
Reversing backward edges...
  0/0 dependencies (0.00%) were violated; 0 source blocks stashed.
Improving vertex order...
Revising stash size...
  Total 0 blocks (0 bytes) are packed as new blocks due to insufficient cache size.
Reticulating splines...
 973135872  973135872 (100.00%)     new __DATA
max stashed blocks: 0  (0 bytes), limit: 322122547 bytes (0.00%)

using prebuilt boot.img from BOOTABLE_IMAGES...
   boot size (33386496) is 49.75% of limit (67108864)
  running:  openssl pkcs8 -in build/target/product/security/testkey.pk8 -inform DER -nocrypt
  running:  java -Xmx2048m -Djava.library.path=/home/build/android/out/host/linux-x86/lib64 -jar /home/build/android/out/host/linux-x86/framework/signapk.jar -w build/target/product/security/testkey.x509.pem build/target/product/security/testkey.pk8 /tmp/tmplfxQq5 /home/build/android/out/target/product/libra/lineage_libra-ota-21c595d9d1.zip
done.
[100% 49586/49586] build bacon
Package Complete: /home/build/android/out/target/product/libra/lineage-14.1-20170730-UNOFFICIAL-libra.zip
make: Leaving directory '/home/build/android'

#### make completed successfully (01:19:06 (hh:mm:ss)) ####

build@leon-Manjaro:~/android$ 
```

# 导入 Android Studio

``` bash
source build/envsetup.sh
make idegen && development/tools/idegen/idegen.sh #docker下执行
```

> Android Studio 打开已有项目，找到源码根目录的.ipr文件
> 此方法可以避免全部编译源码

# 参考

1. [Build for libra](https://wiki.lineageos.org/devices/libra/build#download-the-source-code)
2. [从CM刷机过程和原理分析Android系统结构](http://blog.csdn.net/luoshengyang/article/details/29688041)
3. [How to import the sources to Android Studio / IntelliJ](https://wiki.lineageos.org/import-android-studio-howto.html)