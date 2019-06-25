---
title: 随机事件与概率
author: Hoas
date: '2019-06-25'
slug: random-event-and-probability
categories:
  - course
tags:
  - Math
lastmod: '2019-06-25T17:45:50+08:00'
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

# 事件的关系与运算

- 事件的包含与相等；
- 事件的并；
- 事件的交；
- 事件的差；
- 逆事件或对立事件。

# 概率的基本性质

1.可减性。若$A \subset B$：

$$
P(B-A) = P(B) - P(A)
$$

2.单调性。若$A \subset B$：

$$
P(A) \leq P(B)
$$

3.逆事件概率公式：

$$
P(\overline{A}) = 1 - P(A)
$$

4.加法公式：
$$
P(A \cup B) = P(A) + P(B) - P(AB)
$$
<!--more-->

# 古典概型和几何概型

## 古典概型

计算所有可能出现的结果的集合中元素出现的次数。对象常有：

1. （球的）排列；
2. （球的）个数；
3. 操作的次数等。

## 几何概型

把图画出来。

# 条件概率

1.条件概率
$$
P(A|B) = \frac{P(AB)}{P(B)}
$$
2.乘法公式
$$
P(AB) = P(B)P(A|B)
$$
3.全概率公式，在事件$A$发生的基础上对另一系列完备事件组（$B_1,...B_n,...$）的考虑
$$
P(A) = \sum_{i = 1}^n P(B_i)P(A|B_i)
$$

该公式为条件概率公式的变形，经常考虑基于事件$A$的某事件$B$以及该事件的对立事件：
$$
P(A) = P(B)P(A|B) + P(\overline{B})P(A|\overline{B})
$$
4.贝叶斯公式（逆概率公式）
$$
P(B_i|A) = \frac{P(B_i)P(A|B_i)}{\sum_{j = 1}^n P(B_j)P(A|B_j) \; (which=P(A))}
$$
其中$P(B_i)$为先验概率，$P(B_i|A)$为后验概率。

同理：
$$
P(B|A) = \frac{P(B)P(A|B)}{P(B)P(A|B) + P(\overline{B})P(A|\overline{B})}
$$

# 事件的独立性

$$
P(ABC) = P(A)P(B)P(C)
$$

$n$重伯努利试验（独立重复试验）：
$$
P(B_k) = C_n^k p^k q^{n-k}
$$
