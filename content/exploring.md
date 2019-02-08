---
title: Exploring
author: Hoas
date: '2019-01-07'
slug: exploring
categories:
  - debugging
tags:
  - R
  - hugo
  - RMarkdown
lastmod: '2019-01-18T16:36:05+08:00'
toc: yes
comment: no
weight: 5
menu: "main"
keywords: [explore,hugo,R Markdown,website,R]
description: "Exploring for many problems occured in blogdown."
---
  <img src="http://www.makeraid.cn/wp-content/uploads/2017/09/36%E4%B8%AA%E9%AB%98%E9%A2%91%E9%97%AE%E9%A2%98-%E5%A4%A7%E5%9B%BE.jpg" alt="problem" width="100%" height="100%">
<!--more-->

# Keeping Exploring!

  How to...
  
  * add a web-fitted tabulate built by `.Rmd` file?
  
  * generate a [toc in a `.Rmd` file](https://github.com/olOwOlo/hugo-theme-even/issues/100)?
  
  * generate a normal tabulate(`.Rmd` file) just like `.md` and `Rmarkdown` file?
  
  * add abstract to one blog shaped by `.Rmd` file?
  
  * switch the different websites? For example, [Chinese&English web](http://dapengde.com/archives/15265)?
  
  * add [Strike-Type lines](https://blog.csdn.net/u012111465/article/details/81148353)?
  
  * create one site with multistyle?
  
  * use the icons in [iconfont](https://www.iconfont.cn/?spm=a313x.7781069.1998910419.d4d0a486a)?
  
  * Something may appear sometime somewhere...
  
# Continent Found!
  
  * Keeping navigating!
  
# Treasure

 * Too add [annotation](https://www.imooc.com/article/23400) in markdown, [underline](https://blog.olowolo.com/post/hugo-even-preview/index.md) in markdown and add [footnotes](http://www.ghostchina.com/markdown-guide/) in markdown.
 
 * Insert audios in website. See <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).
 
 * Add one [comment area](https://www.smslit.top/2018/07/08/hugo-valine/) in hugo.
 
 * If you changed any file under `/src/`, you need to rebuild.

```cmd
In cmd.exe:

C:\Users\Hoas>E:

E:\>cd E:\1R\website\themes\hugo-theme-even\src\css

yarn install

yarn build
```

* [Output Markdown format](https://blog.olowolo.com/post/hugo-quick-start/#%E7%BB%B4%E5%8C%85%E5%AD%90%E4%BB%80%E4%B9%88%E9%83%BD%E7%9F%A5%E9%81%93).

* Add [canvas-nest.js](https://github.com/hustcc/canvas-nest.js) in website. Create new folder `js/` in your `static/` file, copying the js file in `js/` and add one command in your `config.toml`:

```toml
  customJS = ['canvas-nest.mod.js']
  
  # Advice: if you change the color of the theme, you are supposed to modify the color of canvas-nest in `canvas-nest.mod.js` file.
```

* Add [comment.js add-in](https://blog.yuanbin.me/posts/2018-08/2018-08-19_16-59-31/) in [even](https://github.com/olOwOlo/hugo-theme-even).

* Change the style of cursor in website. In `/src/css/_partial/_post/_content.scss` file, add these in the file, but only the latter effects. More knowledge about cursor:https://css-tricks.com/almanac/properties/c/cursor/#browser-support ; http://www.w3school.com.cn/cssref/pr_class_cursor.asp.

```css
body {cursor: url(/cursor/cursor_7.png), auto;}
/** 链接指针样式**/
a:hover{cursor:url(/cursor/cursor_7.cur), pointer;}
```

* Change the type of scroll bars: https://blog.csdn.net/zh_rey/article/details/72473284 ; http://www.webhek.com/post/scrollbar.html.