---
title: 听说这种图最近比较火
author: Hoas
date: '2019-04-09'
slug: animated-bar-plot
categories:
  - brilliant
tags:
  - R
  - ggplot2
lastmod: '2019-04-09T18:58:04+08:00'
keywords: []
description: 'animated bar plot'
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
最近好像这种图比较火，看到好些类似的例子了——有全球发电量的，还有当代羽坛金牌榜排名的……手痒痒了！
<!--more-->

# 实例1

原始数据可以在[这里](https://databank.shihang.org/data/reports.aspx?source=2&series=NY.GDP.MKTP.CD&country=)或[这里](https://github.com/amrrs/animated_bar_charts_in_R)下载。这里就学习别人咋写代码的吧……😭

```r
library(tidyverse)
library(janitor)

gdp <- read_csv("./data/GDP_Data.csv")

#select required columns

gdp <- gdp %>% select(3:15) 

#filter only country rows

gdp <- gdp[1:217,]

gdp_tidy <- gdp %>% 
  mutate_at(vars(contains("YR")),as.numeric) %>% 
  gather(year,value,3:13) %>% 
  janitor::clean_names() %>% 
  mutate(year = as.numeric(stringr::str_sub(year,1,4)))

write_csv(gdp_tidy,"./data/gdp_tidy.csv")
```

这些代码果然厉害，待我细细研究：

1. `mutate_at()`: affects variables selected with a character vector or `vars()`.这个函数影响的只是函数内被选择的字符向量或者是`vars()`。后面跟个函数名，不带括号。这里直接把数据框带有YR的列名所在的向量全部转化为`numeric`，妙啊……
2. `gather()`: Gather takes multiple columns and collapses into key-value pairs, duplicating all other columns as needed.我感觉可以再也不用`reshape2::melt()`了……`gather()`把3:13的数据框列名转化为一列字符向量，向量名即为`year`，同理，值为`value`。
3. `janitor::clean_names()`:Resulting names are unique and consist only of the _ character, numbers, and letters. Capitalization preferences can be specified using the case parameter.这个函数直接净化列名为：`Country_Name`，不过还能有别的形式，还是挺有意思的。
4. 最后一行貌似最简单……哎，本来想学作图的，最后发现自己竟然这么菜。

```r
library(tidyverse)
library(gganimate)

gdp_tidy <- read_csv("./data/gdp_tidy.csv")


gdp_formatted <- gdp_tidy %>%
  group_by(year) %>%
  # The * 1 makes it possible to have non-integer ranks while sliding
  mutate(rank = rank(-value),
         Value_rel = value/value[rank==1],
         Value_lbl = paste0(" ",round(value/1e9))) %>%
  group_by(country_name) %>% 
  dplyr::filter(rank <=10) %>%
  ungroup()

# Animation


anim <- ggplot(gdp_formatted, aes(rank, group = country_name, 
                fill = as.factor(country_name), color = as.factor(country_name))) +
  geom_tile(aes(y = value/2,
                height = value,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(country_name, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=value,label = Value_lbl, hjust=0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
         axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
       plot.margin = margin(2,2, 2, 4, "cm")) +
  transition_states(year, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'GDP per Year : {closest_state}',  
       subtitle  =  "Top 10 Countries",
       caption  = "GDP in Billions USD | Data Source: World Bank Data") 

# For GIF

animate(anim, 200, fps = 20,  width = 1200, height = 1000, 
        renderer = gifski_renderer("gganim.gif")) 

# For MP4

animate(anim, 200, fps = 20,  width = 1200, height = 1000, 
        renderer = ffmpeg_renderer()) -> for_mp4

anim_save("animation.mp4", animation = for_mp4 )

```

注意`filter()`前一定要加`dplyr::`！