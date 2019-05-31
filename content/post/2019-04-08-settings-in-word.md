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