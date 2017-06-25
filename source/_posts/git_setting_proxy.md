title: 设置和取消git proxy
date: 2016-7-5 10:19:43
categories: Git
toc: false
tags:
- Git
- Proxy
---
最近不知怎么搞的，中国移动的手机网络和家里的宽带都无法使用github，只能通过fan.墙来访问，安装的github for Windows也无法使用。一直报错。
<!--more-->
开启影梭后，打开git bash，然后使用以下命令设置代理。
```
git config --global http.proxy http://127.0.0.1:1080 #设置http代理

git config --global https.proxy https://127.0.0.1:1080 #设置https代理

git config --global --unset http.proxy #取消设置代理

git config --global --unset https.proxy #取消设置代理