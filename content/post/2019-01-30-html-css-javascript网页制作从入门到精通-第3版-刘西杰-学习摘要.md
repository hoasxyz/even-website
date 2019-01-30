---
title: 《HTML、CSS、JavaScript网页制作从入门到精通 第3版 (刘西杰)》学习摘要
author: Hoas
date: '2019-01-30'
slug: html-css-javascript网页制作从入门到精通-第3版-刘西杰-学习摘要
categories:
  - fragmentray
tags:
  - HTML
  - CSS
  - JavaScript
  - 中文
lastmod: '2019-01-30T14:05:26+08:00'
keywords: []
description: ''
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
flowchartDiagrams:
  enable: no
  options: ''
sequenceDiagrams:
  enable: no
  options: ''
---
[《HTML、CSS、JavaScript网页制作从入门到精通 第3版 (刘西杰)》](https://www.jianshu.com/p/0b7542f5c1fe)学习摘要，也是对head first中学习的补充。
<img src="https://www.juicymedia.co.uk/application/files/4615/1838/4923/html_css_js.png" alt="HTML&CSS&JS" width="100%" height="100%">
<!--more-->

<center>
# HTML基本标记
</center>

## meta

  这个元素可以设置页面关键字、页面说明、定义编辑工具、添加作者信息、设置网页文字及语言、设置网页的定时跳转等，需要放在头标记中。
  
```html
<head>
<meta name=" " content=" " http-equiv=" ">
<title> </title>
</head>
```
name | content | title | http-equiv
:---:|:-------:|:-----:|:---------:
keywords | 插入关键字 | 插入关键字 |
description | 设置页面说明 | 设置页面说明 |
generator | FrontPage | 设置编辑工具 |
author | Hoas | 添加作者信息 |
       | text/html;charset = 字符集类型 | Document | content-type
       | 跳转时间;URL="跳转到的地址" | 网页的定时跳转 | refresh
       
## 水平线

  同`---`，你可能会发现两者线条粗细长短不一，这应该是样式设定吧，如果同时用两个`---`或者`<hr>`两个样式的分割线会交替出现。
```html
<hr>
```

<hr>

```markdown
---
---
```
---

---

<center>
# 添加多媒体
</center>

## 滚动

```html
  <marquee direction="down"> 嘿嘿嘿~
    
只要跑得够快，知音的催专就赶不上我！ 
     
  </marquee>
  
  <marquee behavior="alternate"> 呜呜呜~
    
林志炫你快点发新专！ 
       
  </marquee>
```

  <marquee direction="down"> 嘿嘿嘿~
    
只要跑得够快，知音的催专就赶不上我！ 
     
  </marquee>
  
  <marquee behavior="alternate"> 呜呜呜~
    
林志炫你快点发新专！ 
       
  </marquee>
  
## 音频&视频

http://saili.science/2017/05/30/music/?tdsourcetag=s_pctim_aiomsg

 - 酷我音乐外链+`<audio>`（音频）

```html
  <center>
<audio autoplay="autoplay" controls="controls" loop="loop" playsinline="" webkit-playsinline="">  
<source src="http://other.web.rd01.sycdn.kuwo.cn/resource/n3/26/92/189145508.mp3" type="audio/mpeg">  </audio>
  </center>
```

《爱+不要爱我》 林志炫：

  <center>
<audio  controls="controls" loop="loop" playsinline="" webkit-playsinline="">  
<source src="http://other.web.rd01.sycdn.kuwo.cn/resource/n3/26/92/189145508.mp3" type="audio/mpeg">  </audio>
  </center>

 - `<video>`

```html
<video id="video" controls="" preload="none" poster="http://media.w3.org/2010/05/sintel/poster.png" width=100%>
      <source id="mp4" src="http://media.w3.org/2010/05/sintel/trailer.mp4" type="video/mp4">
      <source id="webm" src="http://media.w3.org/2010/05/sintel/trailer.webm" type="video/webm">
      <source id="ogv" src="http://media.w3.org/2010/05/sintel/trailer.ogv" type="video/ogg">
      <p>Your user agent does not support the HTML5 Video element.</p>
</video>
```

<video id="video" controls="" preload="none" poster="http://media.w3.org/2010/05/sintel/poster.png" width=100%>
      <source id="mp4" src="http://media.w3.org/2010/05/sintel/trailer.mp4" type="video/mp4">
      <source id="webm" src="http://media.w3.org/2010/05/sintel/trailer.webm" type="video/webm">
      <source id="ogv" src="http://media.w3.org/2010/05/sintel/trailer.ogv" type="video/ogg">
      <p>Your user agent does not support the HTML5 Video element.</p>
</video>

 - `<embed>`元素

```html
<embed src="http://player.youku.com/player.php/sid/XNzQxMjU2ODI0/v.swf" allowFullScreen="true" quality="high" width="100%" height="100" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
```

<embed src="http://player.youku.com/player.php/sid/XNzQxMjU2ODI0/v.swf" allowFullScreen="true" quality="high" width="100%" height="100" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>

<center>
# HTML5开发
</center>

## 地理定位

```js
<p id="demo">点击这个按钮，获得您的位置：</p>
<button onclick="getLocation()">试一下</button>
<div id="mapholder"></div>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
var x=document.getElementById("demo");
function getLocation()
  {
  if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition,showError);
    }
  else{x.innerHTML="Geolocation is not supported by this browser.";}
  }

function showPosition(position)
  {
  lat=position.coords.latitude;
  lon=position.coords.longitude;
  latlon=new google.maps.LatLng(lat, lon)
  mapholder=document.getElementById('mapholder')
  mapholder.style.height='250px';
  mapholder.style.width='500px';

  var myOptions={
  center:latlon,zoom:14,
  mapTypeId:google.maps.MapTypeId.ROADMAP,
  mapTypeControl:false,
  navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
  };
  var map=new google.maps.Map(document.getElementById("mapholder"),myOptions);
  var marker=new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
  }

function showError(error)
  {
  switch(error.code) 
    {
    case error.PERMISSION_DENIED:
      x.innerHTML="User denied the request for Geolocation."
      break;
    case error.POSITION_UNAVAILABLE:
      x.innerHTML="Location information is unavailable."
      break;
    case error.TIMEOUT:
      x.innerHTML="The request to get user location timed out."
      break;
    case error.UNKNOWN_ERROR:
      x.innerHTML="An unknown error occurred."
      break;
    }
  }
</script>
```

<p id="demo">点击这个按钮，获得您的位置：</p>
<button onclick="getLocation()">试一下</button>
<div id="mapholder"></div>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
var x=document.getElementById("demo");
function getLocation()
  {
  if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition,showError);
    }
  else{x.innerHTML="Geolocation is not supported by this browser.";}
  }

function showPosition(position)
  {
  lat=position.coords.latitude;
  lon=position.coords.longitude;
  latlon=new google.maps.LatLng(lat, lon)
  mapholder=document.getElementById('mapholder')
  mapholder.style.height='250px';
  mapholder.style.width='500px';

  var myOptions={
  center:latlon,zoom:14,
  mapTypeId:google.maps.MapTypeId.ROADMAP,
  mapTypeControl:false,
  navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
  };
  var map=new google.maps.Map(document.getElementById("mapholder"),myOptions);
  var marker=new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
  }

function showError(error)
  {
  switch(error.code) 
    {
    case error.PERMISSION_DENIED:
      x.innerHTML="User denied the request for Geolocation."
      break;
    case error.POSITION_UNAVAILABLE:
      x.innerHTML="Location information is unavailable."
      break;
    case error.TIMEOUT:
      x.innerHTML="The request to get user location timed out."
      break;
    case error.UNKNOWN_ERROR:
      x.innerHTML="An unknown error occurred."
      break;
    }
  }
</script>

## 显示当前时间

```js
<script language="javascript">
var t=null;
   t=setTimeout(time,1000);   //设置定时器，一秒刷新一次
   function time(){
       clearTimeout(t);  //清楚定时器
       dt=new Date();
       var y=dt.getYear()+1900;
       var m=dt.getMonth()+1;
       var d=dt.getDate();
       var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
       var day=dt.getDay();
       var h=dt.getHours();
       var min=dt.getMinutes();
       var s=dt.getSeconds();
       if(h<10){
           h="0"+h;
       }
       if(min<10){
           min="0"+min;
       }
       if(s<10){
           s="0"+s;
       }
       document.getElementById("timeShow").innerHTML="当前时间：" + y + " 年 " + m + " 月 " + d + " 日 " + weekday[day] + " " + h + " : " + min + " : " + s + "";
       t = setTimeout(time, 1000);
   }
   </script>
```

<div id="timeShow">
<script language="javascript">
var t=null;
   t=setTimeout(time,1000);   //设置定时器，一秒刷新一次
   function time(){
       clearTimeout(t);  //清楚定时器
       dt=new Date();
       var y=dt.getYear()+1900;
       var m=dt.getMonth()+1;
       var d=dt.getDate();
       var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
       var day=dt.getDay();
       var h=dt.getHours();
       var min=dt.getMinutes();
       var s=dt.getSeconds();
       if(h<10){
           h="0"+h;
       }
       if(min<10){
           min="0"+min;
       }
       if(s<10){
           s="0"+s;
       }
       document.getElementById("timeShow").innerHTML="当前时间：" + y + " 年 " + m + " 月 " + d + " 日 " + weekday[day] + " " + h + " : " + min + " : " + s + "";
       t = setTimeout(time, 1000);
   }
   </script>
   </div>
   
## 触击式线条

<script language="javascript">
  function() {
    function n(n, e, t) {
        return n.getAttribute(e) || t
    }
    function e(n) {
        return document.getElementsByTagName(n)
    }
    function t() {
        var t = e("script"),
        o = t.length,
        i = t[o - 1];
        return {
            l: o,
            z: n(i, "zIndex", -1),
            o: n(i, "opacity", .5),
            c: n(i, "color", "0,0,0"),
            n: n(i, "count", 99)
        }
    }
    function o() {
        a = m.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
        c = m.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
    }
    function i() {
        r.clearRect(0, 0, a, c);
        var n, e, t, o, m, l;
        s.forEach(function(i, x) {
            for (i.x += i.xa, i.y += i.ya, i.xa *= i.x > a || i.x < 0 ? -1 : 1, i.ya *= i.y > c || i.y < 0 ? -1 : 1, r.fillRect(i.x - .5, i.y - .5, 1, 1), e = x + 1; e < u.length; e++) n = u[e],
            null !== n.x && null !== n.y && (o = i.x - n.x, m = i.y - n.y, l = o * o + m * m, l < n.max && (n === y && l >= n.max / 2 && (i.x -= .03 * o, i.y -= .03 * m), t = (n.max - l) / n.max, r.beginPath(), r.lineWidth = t / 2, r.strokeStyle = "rgba(" + d.c + "," + (t + .2) + ")", r.moveTo(i.x, i.y), r.lineTo(n.x, n.y), r.stroke()))
        }),
        x(i)
    }
    var a, c, u, m = document.createElement("canvas"),
    d = t(),
    l = "c_n" + d.l,
    r = m.getContext("2d"),
    x = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
    function(n) {
        window.setTimeout(n, 1e3 / 45)
    },
    w = Math.random,
    y = {
        x: null,
        y: null,
        max: 2e4
    };
    m.id = l,
    m.style.cssText = "position:fixed;top:0;left:0;z-index:" + d.z + ";opacity:" + d.o,
    e("body")[0].appendChild(m),
    o(),
    window.onresize = o,
    window.onmousemove = function(n) {
        n = n || window.event,
        y.x = n.clientX,
        y.y = n.clientY
    },
    window.onmouseout = function() {
        y.x = null,
        y.y = null
    };
    for (var s = [], f = 0; d.n > f; f++) {
        var h = w() * a,
        g = w() * c,
        v = 2 * w() - 1,
        p = 2 * w() - 1;
        s.push({
            x: h,
            y: g,
            xa: v,
            ya: p,
            max: 6e3
        })
    }
    u = s.concat([y]),
    setTimeout(function() {
        i()
    },
    100)
} ();
<script>