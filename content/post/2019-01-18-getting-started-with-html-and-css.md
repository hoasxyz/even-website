---
title: Getting Started with HTML and CSS
author: Hoas
date: '2019-01-18'
slug: getting-started-with-html-and-css
categories:
  - fragmentray
tags:
  - HTML
  - CSS
draft: false
keywords: []
description: ''
comment: yes
toc: yes
autoCollapseToc: true
postMetaInFooter: true
lastmod: '2019-01-22'
---

  It's learning abstract from [*Head First HTML and CSS, 2nd Edition*](http://file.allitebooks.com/20150518/Head%20First%20HTML%20and%20CSS,%202nd%20Edition.pdf).
<img src="/post/!image/HTML&CSS.png" alt="HTML&CSS" width="100%" height="100%">
<!--more-->
<center>
# Relative Path(HT)
</center>

  A relative path is a link that points to other files on your website relative to the web page you’re linking from. 
  
{{% admonition warning "warning" %}}
Blank space isn't permitted in the names of files and folders.
{{% /admonition %}}

## for `.html` file

```html
<a href="directions.html">detailed directions</a>
```

 * `href` means hypertextreference.
 
 * the `directions.html` file must be in the same parent file as the `.html` file.
 
 * use dot dot `..` to trace the parent file.

    * if you want to go up two folders, you’d type `../..` and so on.
    
    * the limit to how far up you can go -- the root of your website.
    
    * in web pages you always use `/` (forward slash). Don’t use `\` (backslash). 
    
 
```html
<a href="../lounge.html"> Back to the Lounge</a>
```
    
## for images

```html
<img src="drinks.gif">
```

{{% admonition warning "warning" %}}
In **blogdown**/hugo, the root file is `public`. And the posts are in `public/post`.
{{% /admonition %}}

<center>
# Web Page Construction
</center>

## citation/quotation

  Some browsers use double quotes as the default style of citation, some use italics, and some use nothing at all. The only way to really determine how they’ll look is to style them yourself.

### `<q>`

  * The difference between `<q>` and double quotation marks `""`.
  
  * `<q>` is applied in **inline** citation, as a part of one paragraph.
  
### `<blockquote>`

  * `<blockquote>` is applied in **block** citation, as another paragraph, which has the indent automatically.
  
  * `<q>` can be inserted in `<blockquote>`.
  
  * Linebreak elements `<br>`(or`<br/>`) can be used in `<blockquote>`.
  
## void element

  Elements that don’t have any content by design are called void elements. When you need to use a void element, like `<br>` or `<img>`, you only use an opening tag. This is a convenient shorthand that reduces the amount of markup in your HTML.
  
## list

  Put each **l**ist **i**tem in an `<li>` element. eg.
  
```html
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
```

### ordered list

  Enclose the list items with the `<ol>` element. eg.
  
```html
<ol>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>
```

<ol>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>

### unordered list

  Enclose the list items with the `<ul>` element.
  
```html
<ul>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ul>
```

<ul>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ul>

```html
<ul type="disc">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="circle">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="square">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  
```

<ul type="disc">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="circle">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="square">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul> 

### nested list

```html
<ul>
  <li>咖啡</li>
  <li>茶
    <ul>
    <li>红茶</li>
    <li>绿茶
      <ul>
      <li>中国茶</li>
      <li>非洲茶</li>
      </ul>
    </li>
    </ul>
  </li>
  <li>牛奶</li>
</ul>
```

<ul>
  <li>咖啡</li>
  <li>茶
    <ul>
    <li>红茶</li>
    <li>绿茶
      <ul>
      <li>中国茶</li>
      <li>非洲茶</li>
      </ul>
    </li>
    </ul>
  </li>
  <li>牛奶</li>
</ul>

```html
<ol>
 <li>Charge Segway</li>
 <li>Pack for trip
 <ul>
 <li>cell phone</li>
 <li>iPod</li>
 <li>digital camera</li>
 <li>a protein bar</li>
 </ul>
 </li>
 <li>Call mom</li>
</ol>
```

<ol>
 <li>Charge Segway</li>
 <li>Pack for trip
 <ul>
 <li>cell phone</li>
 <li>iPod</li>
 <li>digital camera</li>
 <li>a protein bar</li>
 </ul>
 </li>
 <li>Call mom</li>
</ol>

### definition list

  Each item in the list has definition terms `<dt>` and definition description `<dd>`.

```html
<dl>
 <dt>Burma Shave Signs</dt>
 <dd>Road signs common in the U.S. in
the 1920s and 1930s advertising shaving
products.</dd>
 <dt>Route 66</dt>
 <dd>Most famous road in the U.S. highway
system.</dd>
</dl>
```

<dl>
 <dt>Burma Shave Signs</dt>
 <dd>Road signs common in the U.S. in
the 1920s and 1930s advertising shaving
products.</dd>
 <dt>Route 66</dt>
 <dd>Most famous road in the U.S. highway
system.</dd>
</dl>

## character entity

  for any character that is considered “special” or that you’d like to use in your web page, but that may not be a typeable character in your editor (like a copyright symbol), you just look up the abbreviation and then type it into your HTML. For example, the > character’s abbreviation is `&gt;` and the < character’s is `&lt;`. 
  
  If you’d like to have an `&` in your HTML content, use the character entity `&amp;` instead of the `&` character itself.

```html
  The &lt;html&gt; element rocks. And &amp;.
```

  The &lt;html&gt; element rocks. And &amp;.
  
  And other common ones are available at: http://www.w3schools.com/tags/ref_entities.asp. Or, for a more exhaustive list, use this URL: http://www.unicode.org/charts/.

## id

  <a href="#relative-path-ht">Back to top(the same web page)</a>. And before this, you should know the id of each point you want to arrive.
  
  Insert audio in website? You can use the two kind of links:
  
```html
 <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> 
 or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).
```
  
  <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).
  
   If you give the name `_blank` to the targets in all your `<a>` elements, then each link will open in a new blank window. However, this is a good question because it brings up an important point: you don’t actually have to name your target `_blank`. If you give it another name, say, `coffee`, then all links with the target name `coffee` will open in the same window. The reason is that when you give your target a specific name, like `coffee`, you are really naming the new window that will be used to display the page at the link. `_blank` is a special case that tells the browser to always use a new window.

## image

  the `<img>` element is an inline element. To make links out of images, for example:

```html
<a href="https://www.bilibili.com/video/av26844990?from=search&seid=4942272683409810113">
 <img src="/post/!image/terrylin.jpg"
 alt="林志炫">
</a>
```

<a href="../terrylin/index.html#御龙将军">
 <img src="../!image/terrylin.jpg"
 alt="林志炫">
</a>

  In this example the link fails because [`fancybox = true`](https://github.com/fancyapps/fancybox).
  
  A width of less than 800 pixels is a good rule of thumb for the size of photo images in a web page. And more details of different formats of images(JPEG,GIF,PNG) are in the book.

<center>  
# Getting Serious with HTML
</center>

  When the browser sees: `<!doctype html>`, it assumes you’re using standard HTML. No more getting all hung up on version numbers or where the standard is located. If you insert the `<!doctype html>` in the `.html` file, this page will be updated to HTML5.
  
## backwards compatibility

  Backwards compatibility means that we can keep adding new stuff to HTML, and the browsers will (eventually) support this new stuff, but they’ll also keep supporting the old stuff. So the HTML pages you’re writing today will keep working, even after new features have been added later.
  
## the W3C validator

  There are three ways you can check your HTML/web by using [the W3C validator](https://validator.w3.org/): 

  * If your page is on the Web, then you can type in the URL here(Validate by URI) and click the Check button, and the service will retrieve your HTML and check it.
  
  * You can choose the second tab(Validate by File Upload), and upload a file from your computer. When you’ve selected the file, click Check, and the browser will upload the page for the service to check.
  
  * Or, choose the third tab(Validate by direct input), and copy and paste your
HTML into the form on that tab. Then click Check and the service will check your HTML.

## specify the character encoding

  Luckily, the world has now standardized on the Unicode character encoding. With Unicode, we can represent all languages with one type of encoding. But, given there are other encodings out there, we still need to tell the browser we’re using Unicode (or another encoding of your choice). To specify Unicode for your web pages, you’ll need a `<meta>` tag in your HTML that looks like this:
   
  `<meta charset="utf-8">`
  
  The `<meta>` tag belongs in the `<head>` element and you shoudl add this line above any other elements in the `<head>` element. And "utf-8" is the version we use for web pages.
  
## why do we need that alt attribute anyway?

  *  If your image is broken for some reason (say, your image server goes down, or your connection is really slow), the alt attribute will (in most browsers) show the alt text you’ve specified in place of the image.
  
  *  For vision-impaired users who are using a screen reader to read the page, the screen reader will read the alt text to the user, which helps them understand the page better.

<center>
# Adding a Little Style
</center>

  The basic construct of HTML is:
  
  <img src="../!image/HTMLconstruct.png" alt="HTML&CSS" width="100%" height="100%">
  
   there are lots of properties that can be set on elements, certainly more than you’d want to memorize, in any case. So you can refer to http://file.allitebooks.com/20180505/CSS%20Pocket%20Reference,%205th%20Edition.pdf.
   
## p {}

  `p {}` select all the paragraphs in the same HTML. But the style of `<q>` element in paragraphs is not changed. eg.
  
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Head First Lounge</title>
<style>
p {
 color: maroon;
}
</style>
</style>
</head>
...
</html>
```
  
## h1,h2 {}

  To write a rule for more than one element, just put commas between the selectors, like “h1, h2”.
  
```html
<style>
h1, h2 {
 font-family: sans-serif;
 color: gray;
 border-bottom: 1px solid black;
}
</style>
```
  
  Separate and specify an other rule just for `<h1>`:
  
```html
<style>
h1, h2 {
 font-family: sans-serif;
 color: gray;
}
h1 {
 border-bottom: 1px solid black;
}
<!--An `underline` is only shown under the text itself. -->
</style>
```

## CSS file

  CSS file only contains CSS.
  
```css
h1, h2 {
 font-family: sans-serif;
 color: gray;
 }
h1 {
 border-bottom: 1px solid black;
 }
p {
 color: maroon;
 }

```

  To link a CSS file in HTML file:
  
```html
<!doctype html>
<html>
 <head>
 <meta charset="utf-8">
 <title>Head First Lounge</title>
 <link type="text/css" rel="stylesheet" href="lounge.css">
 <!--<style> No need!
 </style>-->
 </head>
...
</html>
```
   To write a comment in your CSS, just enclose it between `/*` and `*/`.  eg.
   
```css
/* this rule will have no effect because it's in a comment:
p { color: blue; } */

```

## class

```css
p.greentea {
 color: green;
 }

/* If you want all elements that are in the greentea class to have one style.*/
.greentea {
 color: green;
 }
```

```html
<p class="greentea">
 <img src="../images/green.jpg" alt="Green Tea">
 Chock full of vitamins and minerals, this elixir combines the healthful benefits of green tea with a twist of chamomile blossoms and ginger root.
</p>

<!--Elements can be in more than one class.-->
<p class="greentea raspberry blueberry">
```

## `@font-face`

  This rule allows you to define the name and location of a font that can then be used in your page. And the actual format used to store the fonts isn’t quite yet a standard. There are some common format:
  
  * TrueType fonts: `.ttf`
  
  * OpenType fonts: `.otf`
  
  * Embedded OpenType fonts: `.eot`
  
  * SVG fonts: `.svg`
  
  * Web open font format: `.woff`

```css
@font-face {
	font-family: "Emblema One";
	src: url("http://wickedlysmart.com/hfhtmlcss/chapter8/journal/EmblemaOne-Regular.woff"), 
	     url("http://wickedlysmart.com/hfhtmlcss/chapter8/journal/EmblemaOne-Regular.ttf"); 
}
body {
  font-family:     Verdana, Geneva, Arial, sans-serif;
  font-size:       small;
}
h1, h2 {
  color:           #cc6600;
  border-bottom:   thin dotted #888888;
}
h1 {
  font-family:     "Emblema One", sans-serif;
  font-size:       220%;
}
h2 {
  font-size:       130%;
  font-weight:     normal;
}
blockquote {
  font-style:      italic;
}
```

## handling with fonts

  Font server recommendation: [FontSquirrel](http://www.fontsquirrel.com/).
  
  Adjusting font sizes:
  
  * px.
  
  * %.
  
  * em.

```css
body {
 font-size: 14px;
}

/*Here we’ve specified a body font size in pixels, and a level-one heading as 150%. */
h1 {
 font-size: 150%;
}

/*Your <h2> headings will be 1.2 times the font size of the parent element, which in this case is 1.2 times 14px, which is about 17px.*/
h2 {
 font-size: 1.2em;
}

/*More...
xx-small
x-small
small
medium
large
x-large
xx-large*/
body {
 font-size: small;
}
```

```css
h1 {
font-weight: bold;
font-style: italic;
}
h2 {
font-weight: normal;
font-style: oblique;
}
```

## web colors

  * Specify color by name.
  
```css
body {
 background-color: silver;
}
```

  * Specify color in red, green, and blue values.

```css
body {
 background-color: rgb(80%, 40%, 0%);
}
body {
 background-color: rgb(204, 102, 0);
}
```
  
  * Specify color using hexadecimal(hex) codes.
  
```css
body {
 background-color: #cc6600;
}
```

{{% admonition info "The two-minute guide to hex codes" %}}

Each set of two digits represents a number from 0 to 255.

<img src="/post/!image/hexrgb.png" alt="rgb" width="100%" height="100%">
<img src="/post/!image/hexfinger.png" alt="finger" width="100%" height="100%">
<img src="/post/!image/hexnumber.png" alt="number" width="100%" height="100%">
<img src="/post/!image/hexsamenumber.png" alt="same number" width="100%" height="100%">
{{% /admonition %}}

<center>
# Getting Intimate with Elements
</center>

## the box model

  The box model is how CSS sees elements. CSS treats every single element as if it were represented by a box. Let’s see what that means.
  
  <img src="/post/!image/boxmodel.png" alt="box model" width="100%" height="100%">
 
 The elements of the box model:
 
 * content,
 
 * padding,
 
 * border,
 
 * margin.
 
  <img src="/post/!image/boxmodelconstruct.png" alt="box model construct" width="100%" height="100%">
  
```css
 .guarantee {
 line-height: 1.9em;
 font-style: italic;
 font-family: Georgia, "Times New Roman", Times, serif;
 color: #444444;
 border-color: black;
 border-width: 1px;
 border-style: solid;
 background-color: #a7cece;
 padding: 25px;
 margin: 30px;
 background-image: url(images/background.gif);
 background-repeat: no-repeat;
 background-position: top left;
 }
```

  We refer to [*Head First HTML and CSS, 2nd Edition*](http://file.allitebooks.com/20150518/Head%20First%20HTML%20and%20CSS,%202nd%20Edition.pdf) for more settings of border.
  
## select by id

```html
<p id="footer">Please steal this page, it isn't copyrighted in any way</p> 
```

```css
/*This selects any element that has the id “footer”.*/
#footer {
 color: red;
}

/*This selects a <p> element if it has the id “footer”.*/
p#footer {
 color: red;
}
```

  The difference of naming rules of id and class: Class names should begin with a letter, but id names can start with a number or a letter. Both id and class names can contain letters and numbers as well as the _ character, but no spaces.
  
## out of browser

  If you want to tailor your page’s style to the type of device your page is being displayed on (desktops, laptops, tablets, smartphones, or even printed versions of your pages). 
  
```html
<!--Here our query specifies anything with a screen (as opposed to, say, a printer, or 3D glasses, or a braille reader) and any device that has a width of at most 480 pixels. -->
<link href="lounge-mobile.css" rel="stylesheet" media="screen and (max-device-width: 480px)">
```

  Likewise, we could create a query that matches the device if it is a printer, like this:
  
```html
<!--The lounge-print.css file is only going to be used if the media type is “print”, which means we’re viewing it on a printer. -->
<link href="lounge-print.css" rel="stylesheet" media="print">
```

  There are a variety of propeties you can use in your queries, like `mindevice-width`, `max-device-width` (which we just used), and the `orientation` of the display (landscape or portrait), to name just a few. And keep in mind you can add as many <link> tags to your HTML as necessary to cover all the devices you need to. 
  
  Add media queries right into your CSS:

```css
/*These rules will be used if the screen is wider than 480px*/
@media screen and (min-device-width: 481px) {
 #guarantee {
 margin-right: 250px;
 }
}

/*These rules will be used if the screen is 480px or less...*/
@media screen and (max-device-width: 480px) {
 #guarantee {
 margin-right: 30px;
 }
}
@media print {
 body {
 font-family: Times, "Times New Roman", serif;
 }
}
p.specials {
 color: red;
}
```
<center>
# Advanced Web Construction
</center>

## identifying the logical sections -- `<div>`

  Use, don’t abuse, `<div>`s in your pages. Add more structure where it helps you separate a page into logical sections for clarity and styling. Adding `<div>`s just for the sake of creating a lot of structure in your pages complicates them with no real benefit.

  <img src="/post/!image/divstyle.png" alt="div style" width="100%" height="100%">

  <img src="/post/!image/divaddsos.png" alt="adding structure on structure">
  
```html
<div id="elixirs">
...
</div> 
```

```css
#elixirs {
 border-width: thin;
 border-style: solid;
 border-color: #007e7e;
 width: 200px;
 padding-right: 20px;
 padding-bottom: 20px;
 padding-left: 20px;
 margin-left: 20px;
 text-align: center; /* `text-align` will align all the **inline content** in a block element.*/
 /* And the `text-align` property should be set on **block elements** only. */
 background-image: url(images/cocktail.gif);
 background-repeat: repeat-x;
}

}
```

## select descendants
  
```css
/*This rule says to select any `<h2>` that is a descendant of a `<div>`, with space.*/
div h2 {
 color: black;
}

/*This rule says to select any `<h2>` that is a descendant of an element with the id “elixirs”.*/
#elixirs h2 {
 color: black;
}
```

## shortcut

  <img src="/post/!image/shortcut1.png" alt="short cut2">

  <img src="/post/!image/shortcut2.png" alt="short cut2">
  
  For fonts:
  
  <img src="/post/!image/shortcut3.png" alt="short cut3">
  
  <img src="/post/!image/shortcut4.png" alt="short cut4">
  
## `<span>`

  `<span>` elements give you a way to logically separate inline content in the same way that `<div>`s allow you to create logical separation for block-level content. 
  
```html
<ul>
<li><span class="cd">Buddha Bar</span>, <span class="artist">Claude Challe</span></li>
<li>When It Falls, Zero 7</li>
<li>Earth 7, L.T.J. Bukem</li>
<li>Le Roi Est Mort, Vive Le Roi!, Enigma</li>
<li>Music for Airports, Brian Eno</li>
</ul>
```

```css
.cd {
 font-style: italic;
}

.artist {
 font-weight: bold;
}
```

## for `<a>`

```css
a:link {
 color: green;
}
a:visited {
 color: red;
}
a:hover {
 color: yellow;
}
```

  Add these rules to the bottom of your “lounge.css” file and then save and reload “lounge.html”. Play around with the links to see them in each state. Note that you might have to clear your browser history to see the unvisited color (green). 
  
## Pseudo-class

  

```css
/*On these two, we’re setting the color. For unvisited links, a nice aquamarine… */
#elixirs a:link {
 color: #007e7e;
}

/*…and for visited links we’re using a dark gray. */
#elixirs a:visited {
 color: #333333;
}

/*Now for the really interesting rule. When the user is hovering over the link, we’re changing the background to red. This makes the link loo highlighted when you pass the mouse over it. Give it a try*/
#elixirs a:hover {
 background: #f88396;
 color: #0d5353;
}
```

## the cascade

  Here’s just one last piece of information you need to understand the cascade. You already know about using multiple stylesheets to either better organize your styles or to support different types of devices. But there are actually some other stylesheets hanging around when your users visit your pages. Let’s take a look:
  
  <img src="/post/!image/cascade.png" alt="understanding for cascade" width="100%" height="100%">
  
   as the page authors, we can use multiple stylesheets with our HTML. And the user might also supply his own styles, and then the browser has its default styles, too. And on top of all that, we might have multiple selectors that apply to the same element. How do we figure out which styles an element gets?