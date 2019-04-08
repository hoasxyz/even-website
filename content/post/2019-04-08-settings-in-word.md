---
title: Word设置汇总
author: Hoas
date: '2019-04-08'
slug: settings-in-word
categories:
  - fragmentray
tags:
  - Word
  - 中文
lastmod: '2019-04-08T20:32:07+08:00'
keywords: [Word]
description: 'Word设置汇总'
comment: yes
toc: yes
autoCollapseToc: no
postMetaInFooter: yes
hiddenFromHomePage: no
exclude_jquery: no
contentCopyright: no
reward: no
mathjax: yes
mathjaxEnableSingleDollar: yes
mathjaxEnableAutoNumber: yes
hideHeaderAndFooter: no
---

想着自己还得老老实实用Word用几年，一些每次遇到都头疼的问题都写这儿吧！

<!--more-->

# 插入页码

在封面上插入，设置首页不同，分节的话不要另外加页码，直接选中下一节的页码后右键设置格式。

若设置奇偶页不同，那么需要额外加页码了，在省略掉的奇/偶页上加上页码。

注意：

1. 别忘了每个分节后调整页脚底端距离！

# 插入奇偶互异的页眉

设置奇偶页不同，在正文第一页的页眉上左对齐点击`域`，选择`Styleref`然后点击查看域代码。若不改动那么就是标题文字了，如果这样设置`STYLEREF  "标题 1,章" \r`就可以提取标题前的编号。

注意：

1. 正文前要加分节符！

2. 正文后两页要取消`链接到前一条页眉`！

3. 若在正文开始奇偶互异页眉，别忘了取消勾选`首页不同`！