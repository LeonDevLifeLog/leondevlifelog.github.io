
title: 借助Travis CI持续集成工具，自动编译OpenWrt平台ipk软件包
date: 2016-08-02 23:45:00
categories: OpenWrt
toc: true
tags:
- OpenWrt
- Linux
- Travis CI
---

# 实现的功能
* push更改到github后触发编译
* 每次编译成功之后都会推送*.ipk到gh-pages分支
* 新建tag时，会触发编译并发布*.ipk文件到release页面

<!--more-->

# 使用方法
1. 按照官方方法编写OpenWrt程序
2. 将下面两个文件放到程序源码根目录
    * 根据.travis.yml文件中文注释按需修改
    * deploy.sh文件不用修改
3. 登录Travis CI并对此repo开启持续集成

# 代码文件
* .travis.yml

``` yml .travis.yml
#filename:.travis.yml
sudo: false
cache:
  bundler: true
  directories:
  - cache/
notifications:
  email: false
language: c
compiler: gcc
env:
  global:
  - PACKAGE=mpu6050
  - USER=leon0516
  - REPO=openwrt-mpu6050-example
  # 设置环境变量
  # env:
  #  global:
  #  - USER: <your GitHub username>
  #  - REPO: <this GitHub repo name>
  #  - PACKAGE: <the package name> #OpenWrt软件包名称
  - secure: "WVzPUBwjpPGGDtgQoGMZe/tVTQ721p66mvLgzWuH1SSvLHQxWoFE8eymXLPQXFpZ0VjntQPHnTmzgazOv4aUiJPplswSfLiQUtbaSfuZftxAULGqqzaR3UvzXptdKpXP/quAfgSrVRWgnU3053DjY86oDcIp22O0NnK4LOxPcuadc62dmsS8UQlnrNVoCPCtWorjF/LXcuR12BMxFDCRnrIwveFp57V8x3szE1kOW9ghtBboKqcqN+U/guvE6vCND8VW3JLQkC1fZMIkhJF1tP0M5EyuTwIStZKXH+Ln5ohfRZQS5GFtFiD1ARYsQrIc1rPaA/Yq2/kQRHoKNLn+TsBNiI1+gK63jm3ufN7YW1Sm2Rv5jv/T3v/H2s2OBP6Idbp66RquuE7Ec7Q1B2WPDJ8CwBUiouRUQTWNHfoAu+eeeG3wGMjssXX6zQJA3//aaPXv6sTtMoIQHMrK+X53799WvLs29bvH2g+rpTMzur7jRBsEC4F3mRl6vLuciV357ktz19iJkcftCCL+7m915OYokwzy5PguN2hqjvlLMTi5y5RXbG5o4tmQHJGzc5PEjkxFcHflIc8/NLWJeFEPCgVfXocezvv3rfdAw4A2Iv85v4uO+Hb8SiNuKj4xyyY1Hikd5lMxIWF4CN6EGIDA5a+r1oNTLscM8AWsozy4n1c="
    # Go to GitHub.com -> Settings -> Applications -> Personal Access Tokens 
    # —> Create new token, and copy it to your clipboard
    # travis encrypt TOKEN=123459... -r username/reponame
    # 注意！这里加密的内容包含 「TOKEN=」
    # 会生成环境变量${TOKEN}，${TOKEN}等同于123459...
    # Paste here
  matrix:
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/ar71xx/generic/OpenWrt-SDK-15.05-ar71xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/ramips/mt7620/OpenWrt-SDK-15.05-ramips-mt7620_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/brcm63xx/generic/OpenWrt-SDK-15.05-brcm63xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/ramips/mt7621/OpenWrt-SDK-15.05-ramips-mt7621_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/ramips/mt7628/OpenWrt-SDK-15.05-ramips-mt7628_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/bcm53xx/generic/OpenWrt-SDK-15.05-bcm53xx_gcc-4.8-linaro_uClibc-0.9.33.2_eabi.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/brcm47xx/generic/OpenWrt-SDK-15.05-brcm47xx-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  - SDK_URL=https://downloads.openwrt.org/chaos_calmer/15.05/x86/generic/OpenWrt-SDK-15.05-x86-generic_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
  #SDK的下载连接,按需填写，需要什么平台，添加什么平台的sdk下载连接
install:
- mkdir -p $TRAVIS_BUILD_DIR/local ; cd $TRAVIS_BUILD_DIR/local
- wget "http://us.archive.ubuntu.com/ubuntu/pool/main/c/ccache/ccache_3.1.6-1_amd64.deb"
- dpkg -x *.deb .
- mkdir -p $TRAVIS_BUILD_DIR/cache ; cd $TRAVIS_BUILD_DIR/cache
- wget -c $SDK_URL
- mkdir -p $TRAVIS_BUILD_DIR/sdk ; cd $TRAVIS_BUILD_DIR/sdk
- export FILE=$TRAVIS_BUILD_DIR/cache/$(basename $SDK_URL)
- file $FILE
- tar xjf $FILE
- cd $TRAVIS_BUILD_DIR/sdk/OpenWrt-SDK-*
- mkdir package/$PACKAGE
- ln -s $TRAVIS_BUILD_DIR/Makefile package/$PACKAGE/
- ln -s $TRAVIS_BUILD_DIR/src package/$PACKAGE/
script:
- export PATH=$TRAVIS_BUILD_DIR/local/usr/bin:$PATH
- cd $TRAVIS_BUILD_DIR/sdk/OpenWrt-SDK-*
- "./scripts/feeds update packages >/dev/null"
- make V=s
- find $TRAVIS_BUILD_DIR/sdk/OpenWrt-SDK-*/bin/
- find . -name *.ipk -exec cp {} $TRAVIS_BUILD_DIR \;
- cd $TRAVIS_BUILD_DIR/
- chmod a+x $TRAVIS_BUILD_DIR/deploy.sh
after_success: "$TRAVIS_BUILD_DIR/deploy.sh"
before_deploy: git fetch --tags
deploy:
  provider: releases
  api_key:
    secure: "bUcfHyjQDKvGbVKnbdqfkG/kCMpsU+VuoZxm7+9ckB+lhpHFLaN/xIKmnikNfcEpEbq8wCnnbbW4TOlF7sUVOCcKQ9mazgtZamcO+ZM09ig73rci2v7JYK7NLLJaxd1AWTWi8S6GSFgAIqucWxKdIGTONnTSkGzGjljFPtVBCLY6KCXeQHukrDjVMCBMp+k+rNYHP58OmjpJVrKG9kskF3BaRmkqkFrVDUeL1MCPDfMwprCpmImxW07xW7aWSGIs0CGttfbkVC+1vz5bJsFvqcF1qHlkmfTImumsc8DtDvGvdhb08xOb/DYueT43VFa2UHG2xglMLcF1/+4PqCC9eugoq0NgN16xHXG8HhAMKjBCr6tvcxhkLeYiYTGweZsfLfLQdcGirSe8TDhr1daedbazOPNiqGzy0aypGjCFPeyHxBzuPHAJixRmwVI+jZzs8a4vG+3GI5ZNf4U0uH08bhAHqvgILULJ0QliZc74h6+EYUYmLbf4M8MzRspLGh3GFh1+QUvm2+UhHWk5LuLGgi68X5ISUJQrEL+wm35m3o9MDnP47VgnELb+lGUx0bGOeuT0ywEQCROPNLso844lHXK/zVZ5HILo+RRMIE7eAcUCBPZa2fbil0SYhKhHZMQ+MOfXKIrO/djpW+cjv5k6sYeATi1R4UqHVFZqMvim64c="
      # Go to GitHub.com -> Settings -> Applications -> Personal Access Tokens 
      # —> Create new token, and copy it to your clipboard
      # travis-encrypt -r username/reponame api_key(Personal Access Tokens)
      # e.g. travis-encrypt -r username/reponame 123459...
      # 注意！这里加密的内容不包含 「TOKEN=」
      # 直接加密123459...
      # encrypted api_key
      # Paste here
  skip_cleanup: true
  file_glob: true
  file: "$TRAVIS_BUILD_DIR/*.ipk"
  on:
    tags: true
    all_branches: true

```
* deploy.sh

``` bash deploy.sh
#filename:deploy.sh
#!/bin/bash

# Deploy binaries built with travis-ci to GitHub Pages,
# where they can be accessed by OpenWrt opkg directly

cd /tmp/

git clone https://${USER}:${TOKEN}@github.com/${USER}/${REPO}.git --branch gh-pages \
--single-branch gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors 防止在log中泄露TOKEN明文

cd gh-pages || exit 1

git config user.name "Travis CI"
git config user.email "travis@noreply"

cp $TRAVIS_BUILD_DIR/*ipk .
$TRAVIS_BUILD_DIR/sdk/OpenWrt-SDK-*/scripts/ipkg-make-index.sh . > Packages
gzip -c Packages > Packages.gz

cat > index.html <<EOF
<html><body><pre>
echo "src/gz announce http://${USER}.github.io/${PACKAGE}" >> /etc/opkg.conf
opkg update
opkg install ${PACKAGE}
</pre></body></html>
EOF

DATE=$(date "+%Y-%m-%d")
cat > README.md <<EOF
OpenWrt repository for ${PACKAGE}
========
Binaries built from this repository on $DATE can be downloaded from http://${USER}.github.io/${REPO}/.
To install the ${PACKAGE} package, run
\`\`\`
echo "src/gz announce http://${USER}.github.io/${PACKAGE}" >> /etc/opkg.conf
opkg update
opkg install ${PACKAGE}
\`\`\`
EOF

git add -A
#git pull
git commit -a -m "Deploy Travis build $TRAVIS_BUILD_NUMBER to gh-pages"
#git push -fq origin gh-pages:gh-pages > /dev/null 2>&1 || exit 1
git push -fq origin gh-pages > /dev/null 2>&1 || exit 1 # so that the key does not leak to the logs in case of errors防止在log中泄露TOKEN明文
#git push -f origin gh-pages:gh-pages
echo -e "Uploaded files to gh-pages\n"
cd -
```
# 使用实例

[leon0516/openwrt-mpu6050-example](https://github.com/leon0516/openwrt-mpu6050-example)  
[travis-ci.org/leon0516/openwrt-mpu6050-example](https://travis-ci.org/leon0516/openwrt-mpu6050-example)