---
title: R语言读取Access
author: Hoas
date: '2019-03-28'
slug: read-access-in-r
categories:
  - course
tags:
  - R
  - Access
lastmod: '2019-03-28T12:33:10+08:00'
keywords: [Access,R]
description: 'R语言读取Access'
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

用 R 语言读取 Access 的经历，通过 ODBC 。十分感谢万飚老师的帮助！

<!--more-->

# 基本配置信息

- win 10 ，x64 系统。
- O365ProPlusRetail，x64 **体系架构**。
- 64和32位的 R 。

# 报错一

```c
Warning messages:
1: In odbcDriverConnect(con, ...) :
  [RODBC] ERROR: state IM002, code 0, message [Microsoft][ODBC 驱动程序管理器] 未发现数据源名称并且未指定默认驱动程序
2: In odbcDriverConnect(con, ...) : ODBC connection failed
```

这个问题分数据源和默认驱动程序两部分。

## 数据源

在控制面板管理工具中的`ODBC`处——设置 ODBC 数据源。这里分为32位和64位，但是我没有明白明确的区别，不过这个不重要。

随便点开一个可以发现`DSN`和驱动程序。我的电脑上默认的三个数据源都是不能配置的，只能添加和删除。点开添加，发现32位的 ODBC 的驱动程序比较齐全而64位的就仨（因为我装了 SQL）。

## 驱动程序

接上，可以看到驱动程序。我的电脑需要安装一个和office没有保持同一个体系架构的`engine`——Microsoft Access Database Engine 2010 Redistributable。装好后驱动程序就有了，添加后也有了`.accdb`后缀的驱动程序（`driver`）。

注意这里是2010版本的，我曾经尝试过16版本的，failed。如果装了64位的engine，那么会**在64位的 ODBC 中进行添加操作会出现64位的数据源**。当然我们这里是32位。

添加好后，需要在自定义的数据源里选择你要导入的数据库——这也是万老师说的使用 ODBC 的缺点，每次都要设置。没设置的情况尚未测试。

# 报错二

```c
Warning messages:
1: In RODBC::odbcDriverConnect("DSN=hoas") :
  [RODBC] ERROR: state IM014, code 0, message [Microsoft][ODBC 驱动程序管理器] 在指定的 DSN 中，驱动程序和应用程序之间的体系结构不匹配
2: In RODBC::odbcDriverConnect("DSN=hoas") : ODBC connection failed
```

其实按照上述报错一的操作已经么得这个问题了，网上有很多人测试说要用32位的 R ，但是我这里测试后两个都行。至于这个驱动程序和应用程序分别是什么，我不太清楚。老师的意思应该是`engine`就是驱动，因为我装的是32位的驱动，创建了32位的数据源，然后调用成功，**尽管我的 office 和 R 都是64位的**。如果要我强行解释，那么我会说向下兼容……

对了，R 中要设置的好像是工作路径要和数据库一致。

# 使用

## 读取

这里试了两种最后成功了的方法：

``` c
library(RODBC)
a <- odbcConnect("hoas")
acc <- odbcConnectAccess2007(access.file = "E:/1R/Database1.accdb",uid = "hoas")
# conn <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ='E:/1R/Database1.accdb'") 

a
#> RODBC Connection 1
#> Details:
#>   case=nochange
#>   DSN=hoas
#>   DBQ=E:\1R\Database1.accdb
#>   DriverId=25
#>   FIL=MS Access
#>   MaxBufferSize=2048
#>   PageTimeout=5
acc
#> RODBC Connection 2
#> Details:
#>   case=nochange
#>   DBQ=E:\1R\Database1.accdb
#>   Driver={Microsoft Access Driver (*.mdb, *.accdb)}
#>   DriverId=25
#>   FIL=MS Access
#>   MaxBufferSize=2048
#>   PageTimeout=5
#>   UID=admin
sqlFetch(a, "T_Class")
#>    ClassCode ClassName MajorCode
#> 1      61121   生物061    110002
#> 2      71111   食品071    110001
#> 3      71121   生物071    110002
#> 4      71211 计算机071    120001
#> 5      71212 计算机072    120001
#> 6      71221   软件071    120002
#> 7      81221   软件081    120002
#> 8      91105   软件091    120001
#> 9      91109   软件092    120002
#> 10    222222   软件089    120002
sqlFetch(acc, "T_Course")
#>    CourseCode         CourseName Credit    Academy ClassTime LabTime
#> 1      100002           数学分析      3     理学院        32      16
#> 2      100003       空间解析几何      3     理学院        48       0
#> 3      100004       数学专业导论      1     理学院        20      12
#> 4      110001         生物信息学      2   化工学院        32       8
#> 5      110002       分析化学概论      4   化工学院        48      16
#> 6      110003           物理化学      4   化工学院        48      16
#> 7      110006 食品分析与卫生检验      2   化工学院        20      12
#> 8      120001         计算机原理      3 计算机学院        30      19
#> 9      120002   数据库原理及应用      4 计算机学院        32      35
#> 10     120003           软件工程      3 计算机学院        32      17
#> 11     130001           体育舞蹈      2     文学院        20      18
#> 12     130002             武术史      2     文学院        32       0
#> 13     130004       竞技武术理论      2     文学院        32       0
#> 14     130005         伤科推拿学      2     文学院        16      16
#> 15     150001               软件      3     计算机        48      32
#> 16     500001               历史      1     文学院        10       0
#> 17     700003               政治      2   所有学院        20      10
#>    TotalStudent Teacher Description
#> 1           100  王志民          NA
#> 2            80  赵可霞          NA
#> 3           140  毛芝闻          NA
#> 4            60  白瑞欣          NA
#> 5            80    刘洁          NA
#> 6           130    张超          NA
#> 7            70  马建军          NA
#> 8            80    王岚          NA
#> 9           100    李明          NA
#> 10           80  李政道          NA
#> 11           20    杜岚          NA
#> 12           50  石明明          NA
#> 13           70    萧玄          NA
#> 14           15  宋小波          NA
#> 15           NA      黄          NA
#> 16           NA    章立          NA
#> 17           NA    王磊          NA

odbcClose(a)
odbcClose(acc)
```

<sup>Created on 2019-03-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)