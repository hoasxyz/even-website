---
title: R Knowledge Communication
author: Hoas
date: '2019-02-12'
slug: r-knowledge-communication
categories:
  - fragmentray
tags:
  - R
  - RMarkdown
  - 中文
lastmod: '2019-02-12T18:45:04+08:00'
keywords: [Capital of Statistics, COS,R,R语言,统计之都,SO]
description: 'R语言统计之都/SO摘要'
comment: yes
toc: yes
autoCollapseToc: no
postMetaInFooter: yes
hiddenFromHomePage: no
contentCopyright: no
reward: no
mathjax: yes
mathjaxEnableSingleDollar: yes
mathjaxEnableAutoNumber: yes
hideHeaderAndFooter: no
---
  从[统计之都](https://d.cosx.org/)、[SO](https://stackoverflow.com/)摘抄以及自己的备忘。
![Capital of Statistics](https://slidesplayer.com/slide/11292749/61/images/40/%E7%BB%9F%E8%AE%A1%E4%B9%8B%E9%83%BD+%E4%B8%BB%E7%AB%99%EF%BC%9A%E7%9C%8B%E7%9C%8B%E5%A4%A7%E5%AE%B6%E9%83%BD%E5%9C%A8%E7%A0%94%E7%A9%B6%E4%BB%80%E4%B9%88%EF%BC%9F+%E8%AE%BA%E5%9D%9B%EF%BC%9A%E4%BB%8A%E5%A4%A9%E7%9A%84%E8%AE%B2%E5%BA%A7%E6%B2%A1%E5%90%AC%E6%87%82%EF%BC%9F+%E7%BB%B4%E5%9F%BA%EF%BC%9A%E7%BB%9F%E8%AE%A1%E5%AD%A6%E7%99%BE%E7%A7%91%E5%85%A8%E4%B9%A6%EF%BC%9F+%E5%92%8C%E7%BB%9F%E8%AE%A1%E4%B9%8B%E9%83%BD%E7%9B%B8%E5%85%B3%E7%9A%84%EF%BC%9A+R%E8%AF%AD%E8%A8%80%E4%BC%9A%E8%AE%AE+%E6%95%B0%E6%8D%AE%E6%8C%96%E6%8E%98%E9%82%80%E8%AF%B7%E8%B5%9B.jpg)

<!--more-->

## txt文件提取冒号后的数值

https://d.cosx.org/d/3004-3004

```r
library(gsubfn)
#> 载入需要的程辑包：proto
x <- c("1:2.000000"   ,    "2:5.000000"   ,  "13:155000000" )
gsubfn("([[:alnum:]])+(:)","",x)
#> [1] "2.000000"  "5.000000"  "155000000"
```
## 提取每一行中的最大数值形成新的一行

https://d.cosx.org/d/420429-r

附上apply函数族的介绍：http://blog.fens.me/r-apply/。
```r
library(dplyr)
#> 
#> 载入程辑包：'dplyr'

df =data.table::fread(
  "
1 2 3
4 5 6
7 8 9
"
)
df1 = df %>%
  mutate(rowmax = pmax(V1,V2,V3))

df1
#>   V1 V2 V3 rowmax
#> 1  1  2  3      3
#> 2  4  5  6      6
#> 3  7  8  9      9

df2 = df
df2$rowmax = apply(df,1, max)

df2
#>    V1 V2 V3 rowmax
#> 1:  1  2  3      3
#> 2:  4  5  6      6
#> 3:  7  8  9      9
```

## 改进for循环

https://d.cosx.org/d/420414-for

```r
x <- c(1, 2)
y <- c(3, 4, 5)
z <- c(6, 7, 8, 9)
for(i in x){
	for(j in y){
		for(k in z){
			sum <- i + j + k
			print(sum)
		}

	}
}
```
改进，全排列：
```r
library(dplyr)

expand.grid(x = c(1, 2), y = c(3, 4, 5), z = c(6, 7, 8, 9)) %>%
  dplyr::mutate(sum = x+y+z)
#>    x y z sum
#> 1  1 3 6  10
#> 2  2 3 6  11
#> 3  1 4 6  11
#> 4  2 4 6  12
#> 5  1 5 6  12
#> 6  2 5 6  13
#> 7  1 3 7  11
#> 8  2 3 7  12
#> 9  1 4 7  12
#> 10 2 4 7  13
#> 11 1 5 7  13
#> 12 2 5 7  14
#> 13 1 3 8  12
#> 14 2 3 8  13
#> 15 1 4 8  13
#> 16 2 4 8  14
#> 17 1 5 8  14
#> 18 2 5 8  15
#> 19 1 3 9  13
#> 20 2 3 9  14
#> 21 1 4 9  14
#> 22 2 4 9  15
#> 23 1 5 9  15
#> 24 2 5 9  16
```
注意！这样会出错：
```r
library(dplyr)
#> 
#> 载入程辑包：'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
expand.grid(x = c(1, 2), y = c(3, 4, 5), z = c(6, 7, 8, 9)) %>%
  dplyr::mutate(sum = sum(x,y,z))
#>    x y z sum
#> 1  1 3 6 312
#> 2  2 3 6 312
#> 3  1 4 6 312
#> 4  2 4 6 312
#> 5  1 5 6 312
#> 6  2 5 6 312
#> 7  1 3 7 312
#> 8  2 3 7 312
#> 9  1 4 7 312
#> 10 2 4 7 312
#> 11 1 5 7 312
#> 12 2 5 7 312
#> 13 1 3 8 312
#> 14 2 3 8 312
#> 15 1 4 8 312
#> 16 2 4 8 312
#> 17 1 5 8 312
#> 18 2 5 8 312
#> 19 1 3 9 312
#> 20 2 3 9 312
#> 21 1 4 9 312
#> 22 2 4 9 312
#> 23 1 5 9 312
#> 24 2 5 9 312
```

## 把符合某项的纯字母多行挑出来

https://d.cosx.org/d/420335-r

```r
v1 = c("AABBCC", "BBCCDD", "DDEEFF")
v2 = c("ABCABC", "DEFDEF", "ABCDEF")
ind1 = grepl("B|C", v1)
ind2 = grepl("B|C", v2)
ind = ind1 & ind2
ind1
#> [1]  TRUE  TRUE FALSE
ind2
#> [1]  TRUE FALSE  TRUE
ind
#> [1]  TRUE FALSE FALSE
```

```r
library(dplyr)


df = data.table::fread(
"| v1     | v2     | col3 | col4 |
| AABBCC | ABCABC |      |      |
| BBCCDD | DEFDEF |      |      |
| DDEEFF | ABCDEF |      |      |
| CCDDFF | DDEEFF |      |      |
| ABCABC | CCDDFF |      |      |
", header = T
)

df$V1 = 1:nrow(df)

df %>%
  filter((v1 %in% c("BBCCDD","DDEEFF")) | (v2 %in% c("BBCCDD","DDEEFF")))
#>   V1     v1     v2 col3 col4 V6
#> 1  2 BBCCDD DEFDEF   NA   NA NA
#> 2  3 DDEEFF ABCDEF   NA   NA NA
#> 3  4 CCDDFF DDEEFF   NA   NA NA
```

## 用lubridate包生成像seq()函数一样的序列

https://d.cosx.org/d/420280-lubridate-seq

```r
train <- data[data$ARRIVE_DATE < ymd(20181106),] #可以直接这样筛选
train <- filter(data,data$ARRIVE_DATE < ymd(20181106) #也可以这样

library(dplyr)

raw <- data.table::fread(
"   T              Q     P    E0
 1 1987-01-01  16.5   0.4  0.6 
 2 1987-01-02  16.5   0    1.05
 3 1987-01-03  16.1   0.2  1   
 4 1987-01-04  15.6   0    1.25
 5 1987-01-05  15.6   0    1.6 
 6 1987-01-06  15.6   0    2.75
 7 1987-01-07  15.6   0    2.6 
 8 1987-01-08  14.9   0    2   
 9 1987-01-09  14.8   0    2.5 
10 1987-01-10  14.8   0    2.05",
)


raw %>%
  filter(T > lubridate::ymd(19870102), T < lubridate::ymd(19870107))
#>   V1          T    Q   P   E0
#> 1  3 1987-01-03 16.1 0.2 1.00
#> 2  4 1987-01-04 15.6 0.0 1.25
#> 3  5 1987-01-05 15.6 0.0 1.60
#> 4  6 1987-01-06 15.6 0.0 2.75
```

## 向量中某值与其相邻n个数的subset

https://stackoverflow.com/questions/55507218/subset-adjacent-values-around-one-value

```c
v <- seq(1, 50, .5)
# 1
v1 <- v[which(v == 25)  +  (-2:2)]
embed(v1, 3)[, 3:1]
# embed(v1, 3)

# 2
v[abs(v-25) <= 1]
embed(v1, 3)
    
# 3
n <- 3
v[which(v==25) + (-n+1):0 + rep(seq_len(n)-1,each=n)]
```

