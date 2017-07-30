---
title: AOSP repo 下载源码出现错误
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - AOSP
  - Android
  - LineageOS
post_asset_folder: false
date: 2017-07-30 15:44:09
description:
---

在下载LineageOS(CM/AOSP)源码的时候出现错误

# 错误日志
``` bash
error: .repo/manifests/: manifests checkout 31a4f417d1785e7420e5af2bb571f0e1f16da93a 
Traceback (most recent call last):
  File "/home/leon/LineageOS/.repo/repo/main.py", line 531, in <module>
    _Main(sys.argv[1:])
  File "/home/leon/LineageOS/.repo/repo/main.py", line 507, in _Main
    result = repo._Run(argv) or 0
  File "/home/leon/LineageOS/.repo/repo/main.py", line 180, in _Run
    result = cmd.Execute(copts, cargs)
  File "/home/leon/LineageOS/.repo/repo/subcmds/init.py", line 399, in Execute
    self._SyncManifest(opt)
  File "/home/leon/LineageOS/.repo/repo/subcmds/init.py", line 248, in _SyncManifest
    m.Sync_LocalHalf(syncbuf)
  File "/home/leon/LineageOS/.repo/repo/project.py", line 1399, in Sync_LocalHalf
    upstream_gain = self._revlist(not_rev(HEAD), revid)
  File "/home/leon/LineageOS/.repo/repo/project.py", line 2501, in _revlist
    return self.work_git.rev_list(*a, **kw)
  File "/home/leon/LineageOS/.repo/repo/project.py", line 2700, in rev_list
    (self._project.name, str(args), p.stderr))
error.GitError: manifests rev-list ('^HEAD', u'31a4f417d1785e7420e5af2bb571f0e1f16da93a', '--'): fatal: bad revision '^HEAD'

```

<!--more-->

# 解决办法
删除.repo 目录下的 除 repo 文件夹之外的其它所有文件，重新执行inti和sync
``` bash
rm -rf .repo/manifest*
```