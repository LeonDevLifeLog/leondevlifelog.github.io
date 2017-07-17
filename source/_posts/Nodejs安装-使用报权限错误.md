---
title: Nodejs安装/使用报权限错误
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - Nodejs
post_asset_folder: false
date: 2017-07-17 17:33:50
description:
---

# 错误日志

在安装新的nodejs模块或使用一些nodejs命令时会报权限不够的错误，日志类似下面：
<!--more-->

```
npm ERR! tar.unpack untar error /Users/deangibson/.npm/eslint/2.4.0/package.tgz
npm ERR! Darwin 15.3.0
npm ERR! argv "/usr/local/bin/node" "/usr/local/bin/npm" "install" "-g" "eslint"
npm ERR! node v4.2.3
npm ERR! npm  v2.14.7
npm ERR! path /usr/local/lib/node_modules/eslint
npm ERR! code EACCES
npm ERR! errno -13
npm ERR! syscall mkdir

npm ERR! Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules/eslint'
npm ERR!     at Error (native)
npm ERR!  { [Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules/eslint']
npm ERR!   errno: -13,
npm ERR!   code: 'EACCES',
npm ERR!   syscall: 'mkdir',
npm ERR!   path: '/usr/local/lib/node_modules/eslint',
npm ERR!   fstream_type: 'Directory',
npm ERR!   fstream_path: '/usr/local/lib/node_modules/eslint',
npm ERR!   fstream_class: 'DirWriter',
npm ERR!   fstream_stack: 
npm ERR!    [ '/usr/local/lib/node_modules/npm/node_modules/fstream/lib/dir-writer.js:35:25',
npm ERR!      '/usr/local/lib/node_modules/npm/node_modules/mkdirp/index.js:47:53',
npm ERR!      'FSReqWrap.oncomplete (fs.js:82:15)' ] }
npm ERR! 
npm ERR! Please try running this command again as root/Administrator.

npm ERR! Please include the following file with any support request:
npm ERR!     /Users/deangibson/npm-debug.log
```
# 解决方法

更改系统安装目录的用户为自己而非root
``` bash
sudo chown -R $(whoami) $(npm config get prefix)/lib/node_modules
```