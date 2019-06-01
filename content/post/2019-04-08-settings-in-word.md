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

如果想只是在页眉上加一个横线，只需选中页眉文字，在开始--段落--边框。

注意：

1. 正文前要加分节符！
2. 正文后两页要取消`链接到前一条页眉`！
3. 若在正文开始奇偶互异页眉，别忘了取消勾选`首页不同`！
4. 若单个章节只有一页，那么也要分节然后更改页眉，不仅仅是内容，还有摆放方式！

# 错误！文档中没有指定样式的文字！

我也是醉了，到头来发现竟然是这个梗，掀桌！

复制到新文档中的内容，**样式都变成正文了**，域是没有问题的，问题就在于要重新点样式……

# 目录设置

按照武汉大学论文要求，标题的目录一般是黑体小四，其余为宋体四号，子标题需要有缩进。

# 错误！未定义书签

这word要和我死干到底了？！这些乱七八糟的问题怎么这下全过来了？我告诉你这样只会加快我摒弃word的步伐。

# 代码段

代码段的行距固定为15磅才能显示下划线。

其实这和字体有关，不过小于12磅后行间距会让人太压抑，字体是`Consolas`。

# `PDFMOfficeAddin.dll`

这个是比较坑的一个地方。word自带的PDF导出（即另存为）和文件中的打印设置不能完全还原成你想要的文档样式，目前已经发现了两点：

1. 分页符后面空了一页，现在发现是为了保证**每节一定是偶数页**，我就奇了怪了之前怎么没发现；
2. mathtype插入的章节符被打印出来了。

于是乎，我自己的`.dll`文件又遇到了报错，反正就是使用不了，然后在官网一堆[解决方案](https://helpx.adobe.com/cn/acrobat/kb/pdfmaker-unavailable-office-2007-office.html)中找到了合适的答案：

打开**命令提示符**（可以左下角搜索），然后以管理员身份运行，

```cmd
Microsoft Windows [版本 10.0.17134.765]
(c) 2018 Microsoft Corporation。保留所有权利。

C:\WINDOWS\system32>regsvr32 "C:\Program Files\Adobe\Acrobat\PDFMaker\Office\x64\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "C:\Program Files\Adobe\Acrobat\PDFMaker\Office\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "D:\Adobe\Acrobat DC\PDFMaker\Office\x64\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "D:\Adobe\Acrobat DC\PDFMaker\Office\PDFMOfficeAddin.dll"
```

其中在`x64`中的文件是最终的解决方案。

# 三线表样式设置

主要是上下粗线和内框细线的区别，这个地方有点坑，必须要掌握好设置的顺序。word每次添加新线的磅数默认是0.5磅。因此先不要设置内框线，先设置好上下两个粗线，然后再添加内框线，这时已经默认为0.5磅了。设置上下框线可以**间**接在**格式-边框和底纹**中设置（说实话我不知道要这个有啥用……）。

如果先设置好了一个粗磅，比如1.5磅，然后加上的新线默认为0.5磅，若这个时候在界面中（不是边框和底纹）修改磅数为0.75磅，那么所有的设置的线的磅数都为0.75磅了。

经测试设置三种及三种以上不同粗细的线是不现实的……

# Mathtype

## 插入章节分隔符

一般都是章，这个分隔符不要放在章标题上！我不知道如何不让它在目录中显示。

# 参考文献

R的两本书：

- Hadley Wickam,Garrett Grolemund. R for Data Science[M]. First Edition. Sebastopol. O’Reilly Media, Inc. 2016(12).

- Robert I. Kabacoff. R in Action[M]. Second Edition. Westampton. Manning Publications. 2015.

# 文字样式

文字样式在电脑中的位置为：`C:\Users\Hoas\AppData\Roaming\Microsoft\QuickStyles`。

发现表格样式是包含在文字样式之内的，因为别的不清楚，所以我只留了一个文字样式。

# `Normal.dot`

以下内容要放在该文件中设置：

- 默认表格样式；
- 默认页眉页脚距两端距离。