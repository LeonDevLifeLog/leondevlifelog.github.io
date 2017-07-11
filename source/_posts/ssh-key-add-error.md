---
title: 执行ssh-add时出现错误
categories: ErrorLog
toc: false
tags:
  - ErrorLog
  - ssh
post_asset_folder: false
date: 2017-07-11 10:11:48
---

执行` ssh-add /.ssh/id_rsa `出现这个错误:`Could not open a connection to your authentication agent`

<!--more-->

解决办法:
先执行如下命令:`ssh-agent bash`