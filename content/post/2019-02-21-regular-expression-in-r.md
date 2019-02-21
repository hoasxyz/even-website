---
title: Learning Regular Expression with Stringr
author: Hoas
date: '2019-02-21'
slug: learning-regular-expression-with-stringr
categories:
  - fragmentray
tags:
  - R
lastmod: '2019-02-21T23:03:43+08:00'
keywords: [Regular Expression,R]
description: 'Regular Expression in R'
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

A copy of _R for data science_.
<center>
<img src="https://github.com/tidyverse/stringr/raw/master/man/figures/logo.png">
</center>
<!--more-->

# String Basics

You can create strings with either single quotes or double quotes. Unlike other languages, there is no difference in behavior.

To include a literal single or double quote in a string you can use `\` to “escape” it:

```r
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"
```

That means if you want to include a literal backslash, you’ll need to double it up: `\\`.

{{% admonition warning warning %}}
Beware that the printed representation of a string is not the same as string itself, because the printed representation shows the escapes(转义). To see the raw contents of the string, use `writeLines()`:
```r
x <- c("\"", "\\")
x
#> [1] "\"" "\\"
writeLines(x)
#> "
#> \
```
{{% /admonition %}}

There are a handful of other special characters. The most common are `\n`, newline, and `\t`, tab, but you can see the complete list by requesting help on `?'"'`, or `?"'"`. You’ll also sometimes see strings like `\u00b5`, which is a way of writing non-English characters that works on all platforms:

```r
x <- "\u00b5"
x
#> [1] "μ"
```

## Basic String Operations

The functions from __stringr__ all start with `str_`:

- String Length

```r
str_length(c("a", "R for data science", NA))
#> [1] 1 18 NA
```
- Combining Strings

```r
str_c("x", "y")
#> [1] "xy"
str_c("x", "y", "z")
#> [1] "xyz"

str_c("x", "y", sep = ", ")
#> [1] "x, y"
```
Like most other functions in R, missing values are contagious. If you want them to print as `NA`, use `str_replace_na()`:

```r
x <- c("abc", NA)
str_c("|-", x, "-|")
#> [1] "|-abc-|" NA
str_c("|-", str_replace_na(x), "-|")
#> [1] "|-abc-|" "|-NA-|"

str_c("prefix-", c("a", "b", "c"), "-suffix")
#> [1] "prefix-a-suffix" "prefix-b-suffix" "prefix-c-suffix"
```

- To collapse a vector of strings into a single string, use `collapse()`:

```r
str_c(c("x", "y", "z"), collapse = ", ")
#> [1] "x, y, z"
```

## Subsetting Strings

```r
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
#> [1] "App" "Ban" "Pea"

# negative numbers count backwards from end
str_sub(x, -3, -1)
#> [1] "ple" "ana" "ear"

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x
#> [1] "apple" "banana" "pear"
```
## Locales

However, changing case is more complicated than it might at first appear because different languages have different rules for changing case.

Another important operation that’s affected by the locale is sorting. The base R `order()` and `sort()` functions sort strings using the current locale. If you want robust behavior across different computers, you may want to use `str_sort()` and `str_order()`, which take an additional locale argument:

```r
x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en") # English
#> [1] "apple" "banana" "eggplant"

str_sort(x, locale = "haw") # Hawaiian
#> [1] "apple" "eggplant" "banana"
```



```r

```