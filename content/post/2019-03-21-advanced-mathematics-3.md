---
title: 高数3 - 中值定理和导数
author: Hoas
date: '2019-03-21'
slug: advanced-mathematics-3
categories:
  - course
tags:
  - Math
  - 中文
lastmod: '2019-03-21T16:56:47+08:00'
keywords: [中值定理和导数]
description: '中值定理,导数'
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

时间隔得有点久，再拖下去之前做的东西估计都忘没了，不过这章要记的东西很多，赶快记下来~

这里以及高数系列中的**某点**特指$x_0$.

# 微分中值定理

## Fermat定理

函数在某点取得极值，那么函数在该点上的导数存在且必等于零，该点可称为函数的驻点。

<!--more-->

## Rolle中值定理

函数**闭连开导端等**，区间内存在一个点使得函数在该点的导数为零。

## Lagrange中值定理

函数**闭连开导**，区间内存在一个点使得：
$$
f'(\xi)=\frac{f(b)-f(a)}{b-a}
$$
这个定理的证明非常妙，借助构造函数和 Rolle 中值定理完成，在书上 124 页。

## Cauchy中值定理

两个函数在同区间内均闭连开导，区间内存在一个点使得：
$$
\frac{f(b)-f(a)}{F(b)-F(a)}=\frac{f'(\xi)}{F'(\xi)}
$$

## 题型

题型主要以考验构造函数的能力。这个确实是需要找手感的，有些题目只要构造得当一次就OK了，但是有些需要多次运用到别的定理，比如两次运用罗尔中值定理。

# 泰勒公式

## Taylor中值定理

若函数在含有某点的某个开区间内具有直到$(n+1)$阶的导数，则对属于区间内的任意一点：
$$
f(x)=f(x_0)+f'(x_0)(x-x_0)+\frac{f^{(2)}(x_0)}{2!}(x-x_0)^2+...+\frac{f^{(n)}(x_0)}{n!}(x-x_0)^n+R_n(x)
$$
以上是指**泰勒公式**，其中误差估计式（拉格朗日型余项）：
$$
R_n{x}=\frac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)^{(n+1)}
$$
注意，这里的$\xi$是**$x_0$和$x$之间的某个值**！

**泰勒多项式** = 泰勒公式 - 拉格朗日型余项。

## Peano余项

$o(x^n)$

## Maclaurin公式

$$
f(x)=f(0)+f'(0)x+\frac{f^{(2)}(0)}{2!}x^2+\frac{f^{(3)}(0)}{3!}x^3+...+\frac{f^{(n)}(0)}{n!}x^n+\frac{f^{(n+1)}(\theta x)}{(n+1)!}x^{(n+1)}
$$

$$
(0<\theta <1)
$$

五个常用的函数的麦克劳林展开式也是要记的。

## 题型

- $n$阶泰勒多项式/泰勒公式：写到$f^{(n)}(x)$项就行了。

- $n$阶麦克劳林公式：写到$x^n$项就行了。
- 展开到含$x^n$的项：写到$x^n$项就行了。
- $n$阶无穷小：写到$n$-1阶就行了。

根本上说还是自己对概念的理解不够！

# $L’Hospital$法则

这个法则我高中的时候就在用了，原因是长征哥的培训。

其他类型的**未定式**都可以通过转化为$\frac{0}{0}$和$\frac{\infty}{\infty}$来解决。