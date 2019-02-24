---
title: R语言网络爬虫
author: Hoas
date: '2019-02-15'
slug: web-crawler-in-r
categories:
  - plain
tags:
  - R
  - 中文
lastmod: '2019-02-15T19:11:15+08:00'
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
参考[这篇文章](https://mp.weixin.qq.com/s?__biz=MzIwNjU2NDcyMg==&mid=2247483918&idx=1&sn=c5edfea2a59c698359c202d50bfbb16c&chksm=971efe13a0697705745b847bdd285eb36da01a2c103a86c402631305c8680ee556e2e1b834b4&scene=21#wechat_redirect)。
<!--more-->
 
## 使用 __rvest__ 爬取文章

```r
library(rvest)
url<-'https://hoas.xyz/post/%E7%94%A8github%E5%81%9A%E5%9B%BE%E5%BA%8A%E7%9A%84%E5%B0%9D%E8%AF%95/'
web<-read_html(url,encoding="utf-8") #读取数据，规定编码
position<-web %>% html_nodes("div.highlight") %>% html_text()
```
虽然不知道爬取的是什么……

```r
> position
[1] "\n\n 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n\n\nE:\\1R\\mdphotos>echo \"# MarkdownPhotos\" >> README.md\n\nE:\\1R\\mdphotos>git init\nInitialized empty Git repository in E:/1R/mdphotos/.git/\n\nE:\\1R\\mdphotos>git add README.md\n\nE:\\1R\\mdphotos>git commit -m \"first commit\"\n[master (root-commit) d675236] first commit\n 1 file changed, 1 insertion(+)\n create mode 100644 README.md\n\nE:\\1R\\mdphotos>git remote add origin https://github.com/hoasxyz/MarkdownPhotos.git\n\nE:\\1R\\mdphotos>git push -u origin master\nfatal: unable to access 'https://github.com/hoasxyz/MarkdownPhotos.git/': error setting certificate verify locations:\n  CAfile: E:/!Learning_R_is_awesome!/Git/mingw64/ssl/certs/ca-bundle.crt\n  CApath: none\n"
[2] "\n\n 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n\n\nE:\\1R\\mdphotos>git config --system http.sslcainfo \"E:\\1R\\Git\\mingw64\\ssl\\certs\\ca-bundle.crt\"\n\nE:\\1R\\mdphotos>git push -u origin master\nEnumerating objects: 6, done.\nCounting objects: 100% (6/6), done.\nDelta compression using up to 4 threads\nCompressing objects: 100% (2/2), done.\nWriting objects: 100% (6/6), 457 bytes | 228.00 KiB/s, done.\nTotal 6 (delta 0), reused 0 (delta 0)\nTo https://github.com/hoasxyz/MarkdownPhotos.git\n * [new branch]      master -> master\nBranch 'master' set up to track remote branch 'master' from 'origin'.\n" 
```
- web: 存储网页信息的变量

- html_nodes(): 函数获取网页里的相应节点

- html_text(): 函数获取标签内的文本信息

## 使用 __jiebaR__ 进行分词，统计词频

```r
library(jiebaR)
engine_s<-worker(stop_word = "stopwords.txt")#初始化分词引擎并加载停用词。
seg<-segment(position,engine_s)#分词
f<-freq(seg) #统计词频
f<-f[order(f[2],decreasing=TRUE),] #根据词频降序排列
```
![效果图](http://mmbiz.qpic.cn/mmbiz_png/gCNQ1sBAAibmQOyyYg698ImDVpvz58N94c1UrKajGrfokZz9eVhCgpSI1N3CYEaREkV0feichaxztdEic1bksBGIg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## __wordcloud2__

```r
library(wordcloud2)#加载包
f2<-f2[1:150,]     #总共有2000多个词，为了显示效果，我只提取前150个字
wordcloud2(f2, size = 0.8 ,shape='star')    #形状设置为一颗五角星
```

```r
path<-"D://dang.png"#图片路径
wordcloud2(f2,size = 1.3,figPath =path)#绘图，如果词云形状和图片形状不太像时，可以调节size值
```

```r
letterCloud(f2, word="党",size = 1)  #Word参数用于设置绘制词云形状为“党”这个字。
```

```r
path3<-"D://3.png"
f3<-f[1:1000,]  #因为图片面积比较大，所以这次选前1000个词 
wordcloud2(f3,size = 1.7,figPath =path3,background='black') #background用于设置背景颜色，为了便于观察我设置为黑色
```