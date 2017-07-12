title: OpenWrt编译过程记录
date: 2016-07-20 15:31:00
categories: Development
toc: true
tags:
- OpenWrt
- Linux
---
时隔半年多，我又再次鼓捣起来OpenWrt了，这次终于摸索出干货了。在次记录一下。
<!--more-->
# 软硬件环境
* Hackintosh OSX10.11.5
* ThinkPad Windows10
* parallels Desktop
* Ubuntu14.04 桌面版
* WrtNode 1代
* MakerRouter （wrtnode底板）

# 常规编译
## 安装环境

### Ubuntu

```
leon@leon-ubuntu:~$sudo apt-get install gcc g++ binutils patch bzip2 flex bison make autoconf gettext texinfo unzip sharutils git libncurses5-dev ncurses-term zlib1g-dev gawk libssl-dev python wget subversion xz-utils
```

Ubuntu64位系统还需

```
leon@leon-ubuntu:~$sudo apt-get install lib32gcc1 libc6-dev-i386
```

## 获取源码

> WIKI:[GetSource](https://dev.openwrt.org/wiki/GetSource)

为了提高速度，我把OpenWrt以及相关的package在Coding做了个镜像。
```
leon@leon-ubuntu:~$git clone https://git.coding.net/leon0516/openwrt-15.05.git
leon@leon-ubuntu:~$cd openwrt-15.05
leon@leon-ubuntu:~/openwrt-15.05$cat > feeds.conf << EOF
>src-git packages https://git.coding.net/leon0516/packages.git;for-15.05
>src-git luci https://git.coding.net/leon0516/luci.git;for-15.05
>src-git routing https://git.coding.net/leon0516/routing.git;for-15.05
>src-git telephony https://git.coding.net/leon0516/telephony.git;for-15.05
>src-git management https://git.coding.net/leon0516/management.git;for-15.05
>EOF
```

## 更新相关feeds

```
leon@leon-ubuntu:~/openwrt-15.05$./scripts/feeds update -a 
leon@leon-ubuntu:~/openwrt-15.05$./scripts/feeds install -a 
```

## 检查编译环境

```
leon@leon-ubuntu:~/openwrt-15.05$make defconfig
```

若提示缺少软件包或编译库等依赖，则按提示安装所缺软件包或库等即可
## 选择组件

```
leon@leon-ubuntu:~/openwrt-15.05$make menuconfig
```



## 编译

```
make V=99 j=处理器数目+1
```

也可以直接

```
make V=99
```

编译并生成build.log文件并把相关错误高亮显示出来

```
make -j 5 V=99 2>&1 | tee build.log | grep -i error  #4核处理器
```
我的CPU是6700K，4核4GHz。硬盘是SSD。编译时已经预下载好相关软件包，开启4核编译CPU占用率50%左右，编译完成耗时30分钟多点。大家可以对照自己电脑性能参考计算一下时间。影响时间的因素有CPU速度，硬盘读写速度（网络软件包下载已经提前完成，不影响编译速度）。
### tips
由于编译过程中会下载一些软件包，会消耗大量时间，在编译之前可以先预下载下来，以便节约时间。命令如下
```
make -j 10 download
```
下载的软件包会放在`dl`文件夹下，为了读者方便，我已打包dl文件夹放于网上以节约大家时间。
点击下载[ld.tar.gz](http://o9xqkc534.bkt.clouddn.com/ld.tar.gz)


生成的固件在/bin目录下

# 进阶编译
## 修改默认波特率
由于Uboot的默认波特率是115200而OpenWrt系统的默认波特率是57600为了方便调试我们把系统波特率修改为115200.
在OpenWrt源码根目录编辑以下文件`target/linux/ramips/dts/mt7620n.dtsi`将
```
chosen {
                bootargs = "console=ttyS0,57600";
        };
```
修改为：
```
chosen {
                bootargs = "console=ttyS0,115200";
        };
```
## 默认开启WIFI
由于OpenWrt默认关闭WIFI的，如何一编译好就默认开启WIFI呢？
我们只需要修改配置文件就OK了。方法如下：
打开`package/kernel/mac80211/files/lib/wifi/mac80211.sh`文件，大约在文件最后有如下代码
```
config wifi-device  radio$devidx
        option type     mac80211
        option channel  ${channel}
        option hwmode   11${mode_band}
$dev_id
$ht_capab
        # REMOVE THIS LINE TO ENABLE WIFI:
        #这里↑说的很清楚了，注释掉下面一行就行了
        option disabled 1

config wifi-iface
        option device   radio$devidx
        option network  lan
        option mode     ap
        option ssid     OpenWrt    #这里修改默认SSID SSID中不允许有空格
        option encryption none
#另外强调一点，配置文件都是以tab缩进
```

## ipk开发&luci开发
另开一篇做记录，择日更新


# 注意:
## menuconfig说明
* `*号是编译进固件，M 是编译但是不编译进固件,生成 ipkg 文件`,路由器 flash 不够大的话要考虑尽量编译成模块
1. 选择Target System
2. 选择Target Profile
3. LuCI->Collections->luci(可以通过网页设置路由器)
4. LuCI->Translations->luci-i18n-chinese(中文界面)
5. 其余设置自行决定  

## 界面说明:
* luci：WEB界面
* LuCI ->Applications：应用软件的WEB界面、
* Base system：系统基础，里面有USB挂载 block-mount
* Kernel modules：内核模块，内容很多，不如文件系统等等按照自己需要的选吧
* Utilities：一些实用工具，比如自动挂载选项，无线开关等

## 硬改路由器
* 这个择日更新