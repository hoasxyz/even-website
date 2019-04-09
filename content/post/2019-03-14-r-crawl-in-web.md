---
title: R语言网络爬虫
author: Hoas
date: '2019-03-14'
slug: r-crawl-in-web
categories:
  - fragmentray
tags:
  - R
  - 中文
lastmod: '2019-03-14T21:13:45+08:00'
keywords: [R语言,网络爬虫]
description: 'R语言网络爬虫'
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
下个[SelectorGadget](https://chrome.google.com/webstore/search/selectorgadget?hl=zh-CN)然后开启你的爬虫之旅~

<!--more-->

# 常用函数

- `read_html()`, 读取html文档或链接，可以是url链接，也可以是本地的html文件，
  甚至是包含html的字符串。
- `html_nodes()`, 选择提取文档中指定元素的部分。
  支持`css`路径选择, 或`xpath`路径选择。
  如果tags层数较多，必须使用selectorGadget复制准确的路径。
  使用方式：开启SelectorGadget,然后鼠标选中位置，右击选择检查元素，光标移动到tags上。
  然后选择copy,选择selector或xpath选项。
- `html_text()`,提取tags内文本，
- `html_table()`, 提前tags内表格。
- `html_form()`, `set_values()`, 和`submit_form()`分别表示提取、修改和提交表单。

# 表格提取

```r
library(rvest)
library(magrittr)

city_name <- c(
  "beijing", "shanghai", "guangzhou", "shenzhen", "hangzhou",
  "tianjin", "chengdu", "nanjing", "xian", "wuhan"
)
url_cites <- paste0("http://www.pm25.in/", city_name)

for (n in 1:length(city_name)) {

  # 提取表格
  pm_city <- read_html(x = url_cites[n]) %>%
    html_nodes(css = ".aqis_live_data .container .table") %>%
    .[[2]] %>% # 注意这里的点
    html_table()

  # 批量生成变量
  assign(x = paste0("pm_", city_name[n]), value = pm_city)
}
rm(url_cites, pm_city)

DT::datatable(pm_chengdu)
DT::datatable(pm_beijing)
```



# 实例

## 链家网深圳二手房

爬取网站：https://sz.lianjia.com/ershoufang/pg/

```c
require(pacman)
p_load(xml2,rvest,downloader)
#t1 <- proc.time()
hs <- tibble()

for (i in 1:100) {
  url <- paste("https://sz.lianjia.com/ershoufang/pg/d", i, sep = "")
  
  hs_info <- url %>%
    read_html() %>%
    html_nodes("div.houseInfo") %>%
    html_text() %>%
    str_split("\\|", simplify = TRUE)
  
  hs_info[, 3] <- hs_info[, 3] %>%
    str_remove("(平米)")
  
  hs_posi <- url %>%
    read_html() %>%
    html_nodes("div.positionInfo") %>%
    html_text() %>%
    str_split(" - ", simplify = TRUE)
  
  hs_pric <- url %>%
    read_html() %>%
    html_nodes("div.priceInfo") %>%
    html_text() %>%
    str_extract_all("(\\d{3,6})", simplify = TRUE)
  
  house <- cbind(hs_info, hs_posi, hs_pric) %>%
    as_tibble() %>%
    rename(
      小区名 = V1, 厅室 = V2, 面积 = V3, 朝向 = V4, 装饰 = V5,
      电梯 = V6, 楼层 = V7, 周边 = V8, 总价 = V9, 单价 = V10
    )
  
  hs <- rbind(hs, house)
}

hs$面积 <- as.numeric(hs$面积)
hs$总价 <- as.numeric(hs$总价)
hs$单价 <- as.numeric(hs$单价)

write.csv(hs, "深圳二手房.csv")
#proc.time() - t1
hs <- read.csv("E:/1R/website/Excel/ershou.csv", fileEncoding = "UTF-8") %>%
  select(-1)
```

这里一共100页，一页30个二手房源，一共有3000个房源数据，和网友分析的一样，关于正则表达式的那一块，这里也贴上他们的小改进：

```c
# 1
str_split_fixed(house_tag," *\\|",7) #正则改成这样就能将所有的变量都分隔开了

# 2
library(tidyverse)
#df是数据集，col是按那一列进行划分，into是划分为新数据集的列名称，sep是划分的符号
df=separate(data = df, col = colname, into = c("code", "name"), sep = "\\|")
```

安居客深圳租房

我发现我自己有点不知天高地厚啊？竟然有胆量去查 **二手房** ！！知错就改还是好孩子嘛，这不马上写个~~单室~~租房的……不过换了网站，因为：

- 不想套用代码；
- 房源数量一样；
- 想尝试使用progress；
- 价钱只有一个。

链接：https://sz.zu.anjuke.com/fangyuan/fx1/

```c
library(rvest)
library(progress)
pg <- progress_bar$new(total = 50)

hs <- tibble()

for (i in 1:50) {
  url <- paste("https://sz.zu.anjuke.com/fangyuan/fx1-p", i, sep = "")

  hs_info <- url %>%
    read_html() %>%
    html_nodes("p.details-item.tag") %>%
    html_text() %>%
    str_split("\\|", simplify = TRUE)

  hs_info[, 1] <- str_remove_all(hs_info[, 1], "\\s")
  hs_info[, 2] <- str_remove(hs_info[, 2], "平米") %>%
    as.numeric()
  hs_info_else <- str_split(hs_info[, 3], "\\s", simplify = TRUE)[, 1] %>%
    str_split("层\\ue147", simplify = TRUE)
  hs_info <- hs_info[, 1:2] %>%
    cbind(hs_info_else)

  hs_posi <- url %>%
    read_html() %>%
    html_nodes("address.details-item") %>%
    html_text() %>%
    str_split("\\n", simplify = TRUE)
  hs_posi[, 2] <- str_remove_all(hs_posi[, 2], "\\s")
  hs_posi_else <- str_split(hs_posi[, 3], "\\s", simplify = TRUE)
  hs_posi <- cbind(hs_posi[, 2], hs_posi_else[, 57], hs_posi_else[, 58])

  hs_pric <- url %>%
    read_html() %>%
    html_nodes("div.zu-side") %>%
    html_text() %>%
    str_extract("(\\d{3,})") %>%
    as.numeric()

  house <- cbind(hs_posi, hs_info, hs_pric) %>%
    as_tibble() %>%
    rename(小区名 = V1, 地区 = V2, 道路 = V3, 厅室 = V4, 面积 = V5, 层数 = V6, 联系人 = V7, 月租 = hs_pric)

  hs <- rbind(hs, house)
  pg$tick()
  Sys.sleep(1 / 100)
}

write.csv(hs, "深圳市租房.csv")

```

这网站还设人机识别……加了进度条感觉目标似乎更加明确了呢！这里发现如果要导出`.csv`文件用到的是`write.csv()`，如果是`write.csv2()`那么所有的信息都在一列了，而且都是乱码……

如果在`write.csv()`中使用`fileEncoding = "UTF-8"`那么生成的也是乱码。因为Excel的默认编码方式不是`UTF-8`。但是不管是哪种在R中都没问题！

## 爬取豆瓣图书top250

说实话豆瓣还没人家二手房网站用心，你看看你们自己的数据，再看看人家的？我真是写得恼火气！

```c
library(rvest)
book <- tibble()
for (i in seq(0, 225, 25)) {
  url <- paste("https://book.douban.com/top250?start=", i, sep = "")

  bname <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("div.pl2") %>%
    html_text() %>%
    str_split("\\n", simplify = TRUE)
  bname <- bname[, 5] %>%
    str_remove_all("(\\s)")

  bdetail <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("p.pl") %>%
    html_text() %>%
    str_split("/", simplify = TRUE)
  for (j in 1:25) {
    if(length(bdetail[j,]) ==5){
      if (bdetail[j, 5] != "") {
        bdetail[j, 1] <- str_c(bdetail[j, 1], "(译)", bdetail[j, 2])
        bdetail[j, 2] <- bdetail[j, 3]
        bdetail[j, 3] <- bdetail[j, 4]
        bdetail[j, 4] <- bdetail[j, 5]
      }
    }#else if(length(bdetail[j,]) ==6){# 加一个判断，50时的"你今天真好看"...
    #   bdetail[j,] <- bdetail[j,-3]
    #   if (bdetail[j, 5] != "") {
    #     bdetail[j, 1] <- str_c(bdetail[j, 1], "(译)", bdetail[j, 2])
    #     bdetail[j, 2] <- bdetail[j, 3]
    #     bdetail[j, 3] <- bdetail[j, 4]
    #     bdetail[j, 4] <- bdetail[j, 5]
    # }
    # }
  }
  bdetail <- bdetail[, 1:4]
  for (j in 1:25) {
    if (bdetail[j, 4] != "") {
      bdetail[j, 4] <- bdetail[j, 4] %>%
        str_extract_all("(\\d{1,3}).(\\d{1,2})", simplify = TRUE)
    }
  }

  bgrade <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.rating_nums") %>%
    html_text()
  bnumber <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.pl") %>%
    html_text() %>%
    str_extract_all("(\\d{4,})", simplify = TRUE)
  if (length(bnumber) >= 25) bnumber <- bnumber[1:25, 1]
  bquote <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.inq") %>%
    html_text()
  b <- cbind(bname, bdetail, bgrade, bnumber, bquote) %>%
    as_tibble() %>%
    rename(
      书名 = bname, 作者 = V2, 出版社 = V3, 出版时间 = V4,
      售价 = V5, 豆瓣评分 = bgrade, 评分人数 = bnumber, 引言 = bquote
    )
  book <- rbind(book, b)
}
```

只能运行到前100个，其中还有个张爱玲的书豆瓣连作者都没加上去；还有一书多价的（别找借口）；还有多个出版社的……

掀桌了！

## 网上下载`.txt`文件

```c
require(pacman)
p_load(downloader)

wd <- tibble()

# for(i in 1901:2100){
#   url <- paste("https://data.weather.gov.hk/gts/time/calendar/text/T", i,"e.txt", sep = "")
#   name <- paste("T", i, "e.txt", sep = "")
#   download(url = url, destfile = name)
# }
    
for (i in 2019:2025) {
  url <- paste("https://hoas.xyz/txt/calendar/T", i, "e.txt", sep = "")
  
  wd_en <- fread(url, fill = TRUE, header = FALSE, skip = 2, select = 1:5) %>%
    as_tibble()
  
  wd <- rbind(wd, wd_en)
}

wd <- wd %>%
  rename(solar = V1, lunar = V2, week = V3) %>%
  as_tibble() %>%
  mutate(month = NA)

for (i in seq_along(wd[[1]])) {
  if (str_detect(wd[[2]][i], "[td]")) {
    wd[[3]][i] <- wd[[5]][i]
    wd[[2]][i] <- str_replace(wd[[2]][i], "(.d)|(th)|(st)", "/1")
    wd$month[i] <- as.numeric(str_split(wd[[2]][i], "/", simplify = TRUE)[1])
    wd$lunar[i] <- str_split(wd[[2]][i], "/", simplify = TRUE)[2]
  }
}

wd <- wd %>%
  select(1:3, month) %>%
  mutate(year = 0)

j <- 0
k <- 0
l <- length(wd[[1]])
for (i in seq_along(wd[[1]])) {
  if (!is.na(wd[[4]][i])) {
    j <- i - 1
    if (wd[[4]][i] - 1 < 1) {
      wd[[4]][k:j] <- 12
    } else {
      wd[[4]][k:j] <- wd[[4]][i] - 1
    }
    k <- i + 1
  } else if ((i == l) & (is.na(wd[[4]][i]))) {
    wd[[4]][k:l] <- wd[[4]][k - 1]
  }
}

# 英文最终整理
j <- 0
for (i in seq_along(wd[[1]])) {
  if (wd$month[i] == 1) {
    j <- i
    wd$year[j:length(wd[[1]])] <- as.numeric(str_split(wd$solar, "/", simplify = TRUE)[1])
    break
  }
}
wd$year[1:(j - 1)] <- as.numeric(str_split(wd$solar, "/", simplify = TRUE)[1]) - 1

wd$month <- as.character(wd$month)

# 2-29显示不出来！！！
wd$lunar <- str_c(
  as.character(wd$year),
  "-",
  as.character(wd$month),
  "-",
  wd$lunar
)

wd$solar <- lubridate::ymd(wd$solar)

wd %>%
  dplyr::filter(is.na(wd$solar))
```

