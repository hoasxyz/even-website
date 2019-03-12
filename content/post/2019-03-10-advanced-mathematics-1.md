---
title: 高数1 - 极限与连续
author: Hoas
date: '2019-03-10'
slug: advanced-mathematics-1
categories:
  - course
tags:
  - Math
  - 中文
lastmod: '2019-03-10T17:01:28+08:00'
keywords: [极限与连续]
description: '第一章极限与连续摘要'
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

为什么数学书上的句号都是点呢？从高中开始我就有这个问题，这次为了考研又重新看了高数后明白了这个问题：假设一个变量为x。

看着大一的自己做过的题目，觉得当初自己好笨，那么多都不会……现在除了一些难点的和一些证明题以外，别的题目似乎没有当初那么难了。

<!--more-->

# 数列极限

## $\varepsilon - N$

\begin{equation}
\lim_{n \to \infty} x_n = A
\label{1}
\end{equation}

\begin{equation}
|x_n-A|<\varepsilon
\label{2}
\end{equation}

证明数列极限的方法就是找到那个 N ，因为数列极限几乎只考虑 n 趋近于无穷大，所以只要找到 N，使得 N > n 的时候满足公式\eqref{2}就行了。另外在很多证明题里要会用 $\varepsilon$ 来赋一个特定的值完成证明。

除此之外还要记住书上两个很重要的极限公式。

## 数列极限存在的判别定理

### 夹逼准则

### 单调有界原理

需要依次证明单调性和有界性。其中很可能用到数学归纳法。最简单和常见的数学归纳法是证明当*n*等于任意一个自然数时某命题成立。证明分下面两步：

![数学归纳法](https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Dominoeffect.png/200px-Dominoeffect.png)

1. 证明当 *n* = 1 时命题成立。



1. 证明如果在 *n* = *m* 时命题成立，那么可以推导出在 *n* = *m* + 1 时命题也成立。（ *m* 代表任意自然数）

这种方法的原理在于：首先证明在某个起点值时命题成立，然后证明从一个值到下一个值的过程有效。当这两点都已经证明，那么任意值都可以通过反复使用这个方法推导出来。把这个方法想成[多米诺效应](https://zh.wikipedia.org/wiki/%E5%A4%9A%E7%B1%B3%E8%AF%BA%E6%95%88%E5%BA%94)也许更容易理解一些。

### Cauchy 收敛准则

$$
|x_m-x_n|<\varepsilon
$$

其中 m 可以取 n 的倍数。

# 函数极限

\begin{equation}
\lim_{x \to \infty} f(x) = A
\label{3}
\end{equation}

\begin{equation}
|f(x)-A|<\varepsilon
\label{4}
\end{equation}

函数极限的充要条件是左右极限（单侧极限）和函数极限相等。

函数极限有两种情况：

## $\varepsilon - X$

自变量趋于无穷大。所以 X 可以和数列极限的 N 一样取。

## $\varepsilon - \delta$

自变量趋于有限值。这个时候只要求$\delta$就行。

## 函数极限存在的条件

证明极限存在后，可以直接用定值换取表达式中的变量求极限。

### Heine定理（归结原理）

函数的极限用套于函数的数列来表示，数列满足极限（值）则函数满足极限（值）。这里具体有两个说明函数极限不存在的方法：

- 找到一个数列直接证明数列的函数的极限不存在。

- 找到两个都以一个固定值（不是无穷！）为极限的数列，使两个数列的函数的极限不相等。

以上的方法大多是用来处理三角函数的，以下还需要知道几个函数极限的不存在，它们也关于三角函数:

$$\lim_{x \to 0} sin \frac{1}{x} \; \lim_{x \to \infty}sinx \; \lim_{x \to \infty} cosx \; \lim_{x \to 0}cos\frac{1}{x}$$

### 夹逼准则

同样适用于函数极限。不过这里书上给出了两个极限的经典案例，其中一个是用单位圆面积法求来的；另一个和数列极限相似。

## 无穷大/小

无穷大并不是一个很大的数，而是一个不确定的量，因此如果说极限趋于无穷，那么可以说极限是不存在的。

无穷小多了一些比较，主要影响两个无穷小量的**比**：

- 高阶无穷小

- 同阶无穷小

- 等价无穷小

- k阶无穷小

从这里开始接触到一些无穷小的代换，尤其是等价无穷小。

# 连续性和间断点

## （某点的）连续性

<center>
连续 = 领域有定义+极限存在+（极限值 = 函数值）
</center>

或，
<center>
连续 = 领域有定义+极限存在+（左极限 = 右极限）
</center>

函数连续的充要条件也是左右同时连续。通俗点说，连续在极限的前提下就增加了一个极限值 = 函数值。

## 间断点

- 第一类间断点。左右极限均存在。

 - 可去间断点。左右极限相等。

 - 跳跃间断点。左右极限不等。

- 第二类间断点。左右极限至少有一个不存在。

 - 无穷间断点。极限为无穷说明极限不存在。

 - 震荡间断点。多出现于三角函数中的无穷。

注意：做题的时候先判断在哪些地方有间断再进一步判定间断点。考虑间断点时，分式上下不能消掉。

# 闭区间上连续函数的性质

## 零点定理

## 介值定理

介值定理的应用很灵活，如果没有给端点值（最大最小值），需要自己去设置。

# 其他

掌握函数的积化和差、和差化积公式。https://www.zhihu.com/question/20829733