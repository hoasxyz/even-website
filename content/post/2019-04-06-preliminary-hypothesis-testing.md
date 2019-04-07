---
title: 假设检验初步
author: Hoas
date: '2019-04-06'
slug: preliminary-hypothesis-testing
categories:
  - course
tags:
  - R
  - 中文
lastmod: '2019-04-06T14:20:27+08:00'
keywords: [假设检验初步]
description: '假设检验初步'
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

最近忙课设，不过假设检验这些自己不太熟悉的东西以后自己读研极有可能用到，因此先放在这里。

置信水平和置信度应该是一样的，就是变量落在置信区间的可能性，“置信水平”就是相信变量在设定的置信区间的程度，是个0~1的数，用1-α表示。

置信区间，就是变量的一个范围，变量落在这个范围的可能性是就是1-α。显著性水平就是变量落在置信区间以外的可能性，“显著”就是与设想的置信区间不一样，用α表示。显然，显著性水平与置信水平的和为1。

<!--more-->

# 胡江堂的统计模型

1. [P-value：一个注脚](https://cosx.org/2008/12/p-value-notes/)

2. [假设检验初步](https://cosx.org/2010/11/hypotheses-testing)

3. [决策与风险](https://cosx.org/2008/12/decision-and-risk/)

# t检验

1. [t分布表](https://zh.wikipedia.org/wiki/%E5%AD%A6%E7%94%9Ft-%E5%88%86%E5%B8%83)。这里的单双侧其实不用太纠结，假设显著水平为α，你试试1-α/2就行了~

2. [傻瓜弄懂t检验](https://mangowu97.github.io/%E5%82%BB%E7%93%9C%E5%BC%84%E6%87%82t%E6%A3%80%E9%AA%8C)
3. [spearman秩次相关检验](https://wenku.baidu.com/view/bbe42447cc7931b765ce15f6.html)
4. [Spearman等级相关分析](https://wenku.baidu.com/view/cf1b5d48767f5acfa1c7cd11.html)
5. 另外随机水文学课件里也有比较细致的示例

# PIII曲线离均系数值表

[Excel表格获取](https://hoas.xyz/PIII.xlsx)

