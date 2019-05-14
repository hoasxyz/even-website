---
title: apply函数族
author: Hoas
date: '2019-05-07'
slug: apply-function-family
categories:
  - fragmentray
tags:
  - R
lastmod: '2019-05-07T09:29:57+08:00'
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

很多开发者都结合C++和R进行R包的开发，这也是**Rcpp**能够下载量第一的原因了。哎，要么说R是面向用户的呢？开发者去调试C++代码在R中优雅地运行，可见开发真的不是一件易事呀！

之前一直认为for循环并不算慢，现在终于有了觉悟，虽然apply函数族不能完全代替for，可这也是用C++写出来的函数呀！

![apply function family](http://blog.fens.me/wp-content/uploads/2016/04/apply.png)

参考文章见：<http://blog.fens.me/r-apply/>

<!--more-->

# `apply()`

```r
apply(X, MARGIN, FUN, ...)
```

| Arguments | Meaning                                                      |
| --------- | ------------------------------------------------------------ |
| `X`       | an array, including a matrix.                                |
| `MARGIN`  | a vector giving the subscripts which the function will be applied over. E.g., for a matrix `1` indicates rows, `2`indicates columns, `c(1, 2)` indicates rows and columns. Where `X` has named dimnames, it can be a character vector selecting dimension names. |
| `FUN`     | the function to be applied: see ‘Details’. In the case of functions like `+`, `%*%`, etc., the function name must be backquoted or quoted. |
| `...`     | optional arguments to `FUN`.                                 |

``` r
x <- matrix(1:12, ncol = 3)
x
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
apply(x, 1, sum)
#> [1] 15 18 21 24

x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
#>      x1 x2
#> [1,]  3  4
#> [2,]  3  3
#> [3,]  3  2
#> [4,]  3  1
#> [5,]  3  2
#> [6,]  3  3
#> [7,]  3  4
#> [8,]  3  5

myFUN <- function(x, c1, c2) {
  c(sum(x[c1], 1), mean(x[c2]))
}

apply(x, 1, myFUN, c1 = "x1", c2 = c("x1", "x2"))
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
#> [1,]  4.0    4  4.0    4  4.0    4  4.0    4
#> [2,]  3.5    3  2.5    2  2.5    3  3.5    4

data.frame(x1 = x[, 1] + 1, x2 = rowMeans(x))
#>   x1  x2
#> 1  4 3.5
#> 2  4 3.0
#> 3  4 2.5
#> 4  4 2.0
#> 5  4 2.5
#> 6  4 3.0
#> 7  4 3.5
#> 8  4 4.0
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

`apply()`的默认摆放方式和自己理解的稍有不同（按列从上往下摆放，如果原数据换列则结果也换列），不过使用R内置的向量计算操作几乎不耗时间。

# `lappy()`

```r
lapply(X, FUN, ...)
```

``` r
x <- list(a = 1:10, b = rnorm(6, 10, 5), c = c(TRUE, FALSE, FALSE, TRUE))
x
#> $a
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $b
#> [1] 10.428540 13.721877 13.196627  7.140429  9.671823  6.126874
#> 
#> $c
#> [1]  TRUE FALSE FALSE  TRUE
lapply(x, fivenum)
#> $a
#> [1]  1.0  3.0  5.5  8.0 10.0
#> 
#> $b
#> [1]  6.126874  7.140429 10.050182 13.196627 13.721877
#> 
#> $c
#> [1] 0.0 0.0 0.5 1.0 1.0

x <- cbind(x1 = 3, x2 = c(2:1, 4:5))
x
#>      x1 x2
#> [1,]  3  2
#> [2,]  3  1
#> [3,]  3  4
#> [4,]  3  5
lapply(x, sum)
#> [[1]]
#> [1] 3
#> 
#> [[2]]
#> [1] 3
#> 
#> [[3]]
#> [1] 3
#> 
#> [[4]]
#> [1] 3
#> 
#> [[5]]
#> [1] 2
#> 
#> [[6]]
#> [1] 1
#> 
#> [[7]]
#> [1] 4
#> 
#> [[8]]
#> [1] 5

lapply(data.frame(x), sum)
#> $x1
#> [1] 12
#> 
#> $x2
#> [1] 12
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `sapply()`

```r
sapply(X, FUN, ..., simplify=TRUE, USE.NAMES = TRUE)
```

`sapply()` 是一个简化版的 `lapply()`，`sapply()` 增加了 2 个参数 simplify 和 `USE.NAMES`，主要就是让输出看起来更友好，返回值为向量，而不是 list 对象。

如果 `simplify=FALSE` 和 `USE.NAMES=FALSE`，那么完全 `sapply()` 就等于 `lapply()` 了。

``` r
x <- cbind(x1 = 3, x2 = c(2:1, 4:5))
x
#>      x1 x2
#> [1,]  3  2
#> [2,]  3  1
#> [3,]  3  4
#> [4,]  3  5

sapply(x, sum)
#> [1] 3 3 3 3 2 1 4 5

sapply(data.frame(x), sum)
#> x1 x2 
#> 12 12

a <- 1:2

sapply(a, function(x) matrix(x, 2, 2), simplify = "array")
#> , , 1
#> 
#>      [,1] [,2]
#> [1,]    1    1
#> [2,]    1    1
#> 
#> , , 2
#> 
#>      [,1] [,2]
#> [1,]    2    2
#> [2,]    2    2

sapply(a, function(x) matrix(x, 2, 2))
#>      [,1] [,2]
#> [1,]    1    2
#> [2,]    1    2
#> [3,]    1    2
#> [4,]    1    2
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>