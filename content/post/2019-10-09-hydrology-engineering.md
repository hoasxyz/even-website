---
title: 工程水文概述
author: hoas
date: '2019-10-09'
slug: hydrology-engineering
categories:
  - course
tags:
  - 中文
lastmod: '2019-10-09T19:43:04+08:00'
keywords: []
description: ''
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

因怕忘却自己的身份，写此文谨记之。

# 绪论

## 水

研究对象当然是**地球上的水（资源）**，更多侧重于陆地上的水。由**地表水循环**所引申出的**水量平衡**是水文学中的一个重要的概念（其本质是质量守恒和能量守恒）。

**我国水资源特征**：

1. 总量丰富，人均匮乏；
2. 天然来水时空分布不均，年际、年内分配不均；
3. 水土流失问题和水污染问题严重；
4. 水能资源丰富（世界第一），但开发有限。

## 水文

**水文**指的是自然界中水的变化、运动等的各种现象，文作自然界“现象”讲。水文也有其基本特点：

1. 时程变化上的周期性与随机性；
2. 空间变化上的相似性与特殊性。

**水文要素**包括各种水文变量的水文现象。**降水**、**蒸发**和**径流**是水文循环的基本要素。同时，水位、流速、流量、水温、含沙量、冰凌和水质等也列为水文要素。

## 工程水文学

**工程水文学**是由于需要解决水灾害和水资源开发利用中出现的一系列工程上的问题而诞生的学科，根据工程规划设计、施工建设和经营管理的三个常规阶段有不同的要求。

工程水文学的**主要内容**包括：

- 水文测验（水文信息采集与处理）
- 降雨径流关系分析
- 水文分析与计算
- 水文预报

研究工程水文的方法主要有：

- 成因分析法：研究水文过程机理，定量分析水文现象与影响因素的关系，建立相应数学物理方程求解，例如降雨径流的定量关系；
- 地理综合法：根据水文的地区性分析水文要素的地理分布规律，利用现有的水文资料建立地区性经验公式（葵花宝典），绘制水文特征等值线图。
- 数理统计法：以概率论和统计学为基础，通过大量历史资料分析水文现象的统计规律，以概率的角度定量预估设计地点未来的水文情势，例如**频率分析**。

<!--more-->

# 径流

降水落到地面后，除了下渗、蒸发等损失外，在重力的作用下沿着一定方向和路径流动，称为**地面径流**。

降雨或融雪形成的径流从它形成的地点沿坡地向河槽的汇集，形成**坡面径流**，径流过程称为**坡面汇流**；各种成分的径流经坡面汇流之后注入河网，最后流出流域出口断面，称为**河网汇流**。

## 基本知识

### 降水

**降水**包括**降雨**和**降雪**，其本质是空气中的水汽量达到饱和或过饱和后多余的水汽发生凝结，最终在重力的作用下降落至地面。降水也由一些基本要素表示：**降水量**、**降水历时**、降水强度（**雨强**）、降水面积、暴雨中心等。与降水有关的主要气象要素包括**气温**、**气压**、**风**、**湿度**、云等。

根据**空气抬升形成动力冷却**的原因，将雨分为对流雨、地形雨、锋面雨（**锋**）和气旋雨等。

### 河流

地面径流长期腐蚀地面，冲成沟壑，最后汇集成**河流**。河流也有其基本特征：河长、河流的平面形态、河流断面（横、纵断面）、河道纵比降等。

河流的各种干支流和湖泊等构成的脉络相连的系统称为**水系**。为了进一步区别，常用[河流分级法](http://support.supermap.com.cn/datawarehouse/webdochelp/idesktop/Features/Hydrology/StreamOrderType.htm)进行分级。

### 流域

汇集地表水和**地下水**的区域称为**流域**。流域也有基本要素：流域面积、河网密度、形状系数等。

### 下渗

地表水、土壤水和地下水是陆地上普遍存在的三种水体。