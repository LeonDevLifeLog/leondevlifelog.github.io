---
title: 解决ScrollView嵌套RecyclerView显示不全
categories: ErrorLog
toc: true
tags:
  - ErrorLog
  - Android
post_asset_folder: false
date: 2017-07-21 14:08:21
description:
---
# 问题描述
在ScrollView嵌套ListVIew、GirdView的时候都会出现显示不全的情况，对于这种情况只需要重写ListView和GridView的高度即可。
　　在Android6.0以下，ScrollView嵌套RecyclerView并不会出现显示不全的问题，但是在Android6.0及以上版本使用这种布局嵌套的时候就会出现RecyclerView显示不全的问题，解决方法很简单，只需要在RecyclerView的外面套上一层RelativeLayout即可，代码如下：
<!--more-->

``` xml
<RelativeLayout
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:descendantFocusability="blocksDescendants">

    <android.support.v7.widget.RecyclerView
        android:id="@+id/gv_goods_list"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>
</RelativeLayout>
```

> 转载自[进击的阿达](http://www.jianshu.com/p/dd9c1631a71a)
