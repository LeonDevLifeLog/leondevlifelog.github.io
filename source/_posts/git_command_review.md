---
title: git知识点总结
categories: Development
toc: true
tags:
  - Git
date: 2017-06-25 19:19:14
description: git知识点总结
---
# 版本管理
## 版本回退
``` bash
git reset --hard HEAD^ #回退到上一个版本
git reset --hard HEAD^^ #回退到上上一个版本
git reset --hard HEAD~100 #会退到上100个版本
git reflog # 查看命令历史
```
## 撤销修改
``` bash
git checkout -- file #丢弃工作区的修改
git reset HEAD file #git reset HEAD file
```
## 删除文件
``` bash
git rm test.txt
```
# 远程仓库
## 添加远程仓库
``` bash
git remote add origin giturl #远程库的名字是origin
git push -u origin master #第一次推送master分支的所有内容 -u 是关联upstream
```
## 断开远程仓库
``` bash
git remote rm origin #断开origin上游仓库
git rename origin neworigin #修改远程仓库在本地的简称
```
# 分支管理
## 创建与合并分支
``` bash
git checkout -b dev #创建dev分支并切换到dev分支 等同以下两句
git branch dev #创建分支
git checkout dev #切换分支 注意-b
git branch -d dev # 删除分支
git branch # 查看分支
git merge dev #命令用于合并指定分支到当前分支
git branch --set-upstream branch-name origin/branch-name #建立本地分支和远程分支的关联
git pull #push不上,先pull下来合并一下,再push
```
# 标签管理
## 创建标签
``` bash
git tag <name> #创建标签
git tag #查看所有标签
git tag <name> <commit id> #对某次commit打标签
git show <tagname> #查看标签内容
git tag -a v0.1 -m "version 0.1 released" <commit id> # -a指定标签名，-m指定说明文字
git tag -s v0.2 -m "signed version 0.2 released" fec145a #-s 用私钥签名一个标签(gnupg 签名)
```
## 操作标签
``` bash
git tag -d <tagname> #删除标签
git push origin <tagname> #推送标签
git push origin --tags #一次性推送全部尚未推送到远程的本地标签
git push origin :refs/tags/<tagname> #删除远程标签(前提先删除本地标签)
```
# 参考链接
1. [Pro Git book 2nd Edition(2014)](https://git-scm.com/book/zh/v2)
2. [Git教程 - 廖雪峰](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)