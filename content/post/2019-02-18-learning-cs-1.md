---
title: Learning C# 1 - .NET与C#基础
author: Hoas
date: '2019-02-18'
slug: learning-cs-1
categories:
  - course
tags:
  - C#
  - 中文
lastmod: '2019-02-18T18:32:14+08:00'
keywords: [C#]
description: '.NET与C#基础'
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

我为什么要把学习C#的~~惨痛~~历程写在这里：

- 没有指针hiahiahia！

- C#支持绝大多数web标准！
<!--more-->

# .NET开发平台

## .NET Framework

.NET框架是微软公司开发的完全面向对象的软件开发与运行平台。它有两个组件：
  
- 公共语言运行时(common language runtime,CLR)。负责管理和执行由.NET编译器编译产生的中间代码。

  - 公共语言规范(CLS)。它是许多运用程序需要的一套基本语言功能。
  
  - 通用类型系统(CTS)。定义了可以在中间语言使用的预定义数据类型。

- 类库。里面有很多已经编译好的类（相当于R里面的base package吧），可以直接使用。

## VS的集成开发环境

和RStudio一样作为一个变成环境、开发工具。
  
# Windows控制台应用（Program.cs）

{{% admonition warning warning %}}
注意，`.png`里用`#`符号引用会失效！不知为何……
{{% /admonition %}}

![基本结构](/post/!image/Csc1-1.png)

## 命名空间（namespace）

起组成程序的作用，一般新建项目后C#会自动生成一个和项目名称名相同的命名空间。既用作程序的“内部”组织系统又用作向“外部”公开的组织系统（一种向其他程序公开自己拥有的程序元素的方法）。如果要调用某个命名空间中的类或者别的东西比如方法，需要用`using`指令在开头引入命名空间，这样的话就可以直接使用，这就像R中的`library()`函数。

今天看yihui的[xaringan](http://slides.yihui.name/xaringan/zh-CN.html)后：
```r
if (!requireNamespace("xaringan"))
  devtools::install_github("yihui/xaringan")
```
  
## 类（class）

类是C#的核心和基本构成模块，主要功能的代码都在类中完成，类是一种可以封装数据成员、方法成员和其他的类。也可以这样理解：类封装函数，然后可以在另外一个类中调用这个函数（类）。

- 成员变量，在类中申请的变量。

- 成员函数，在类中声明的函数。
  
## 关键字

即已经被赋予特定意义的一些单词。C＃关键字的完整列表：

```cs
abstract     do        in            protected     true 
as           double    int           public        try 
base         else      interface     readonly      typeof 
bool         enum      internal      ref           uint 
break        event     is            return        ulong 
byte         explicit  lock          sbyte         unchecked 
case         extern    long          sealed        unsafe 
catch        false     namespace     short         ushort 
char         finally   new           sizeof        using 
checked      fixed     null          stackalloc    virtual 
class        float     object        static        void 
const        for       operator      string        volatile 
continue     foreach   out           struct        while 
decimal      goto      override      switch 
default      if        params        this 
delegate     implicit  private       throw 
```

一些关键字是上下文关联的，它们可以用作标识符，而不使用`@`符号：

```cs
add          ascending            async         dynamic 
equals       from                 in            into 
join         partial              remove        select 
where        yield                await         get 
let          set                  by            global 
on           value                descending    group 
orderby      var 
```

## 标识符

由任意顺序的字母、下划线和数字组成，而且第一个字符不能使数字。标识符不能是关键字，注意还要区分大小写。

{{% admonition tip tip %}}
要使用关键字作为标识符，请使用`@`前缀限定。
```cs
class class {...} // Illegal 

class @class {...} // Legal
```
{{% /admonition %}}

## Main方法

类体的主方法，也是激活整个程序的开关。`static`和`void`分别是Main方法的静态修饰符和返回值修饰符，C#中的Main方法必须声明`static`，一般是自动生成的，如果需要修改：

- Main方法在类或结构内声明，必须是`static`，而不是`public`。

- Main的返回类型有两种：`void`和`int`。

- Main方法可以包含命令行参数`string[] args`，也可以不包括。

## 一个例子

Windows控制台应用中，关于循坏输出绝对值的代码：
```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            //output content
            Console.WriteLine("Hello World!");
            Console.WriteLine("请输入一个数，程序将输出其绝对值：");
            while (true)
            {
                string ra = Console.ReadLine(); //输入字符型变量
                int ia = Convert.ToInt32(ra);   //转换为整型变量
                if (ia < 0)
                    ia = -ia;
                Console.WriteLine("{0}的绝对值为{1}", ra, ia);
            }
            Console.ReadLine();
        }
    }
}
```

{{% admonition tip tip %}}
`ctrl+A`, `ctrl+K`, `ctrl+D`自动整理代码。
{{% /admonition %}}

# Windows窗体应用程序

## button

在工具箱中添加`button`。右键可见属性和代码：

```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace helloworld.win
{
    public partial class H1 : Form
    {
        public H1()
        {
            InitializeComponent();
        }

        private void terrylin_Click(object sender, EventArgs e)
        {
            MessageBox.Show("睡觉觉啦！");
        }

        private void H1_Load(object sender, EventArgs e)
        {

        }
    }
}
```

{{% admonition tip tip %}}
- `public`中的`H1`实际上是窗体应用程序属性中`(Name)`中的内容。

- `public`后面跟随的`xxxx()`是函数。

- 单/双引号的区别就是表达所定义的是字符/字符串。
```cs
char c='a';
string s="sfsdf";
```
{{% /admonition %}}

<img src="/post/!image/Csc1-2.png" alt="睡觉觉啦1" width="60%">

`Ctrl+F5`后，

<img src="/post/!image/Csc1-3.png" alt="睡觉觉啦2" width="60%">

# 作业

## 排序

输入三个整数，按从小到大的顺序输出：

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _C1_HW2
{
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("请输入三个或者多个连续的整数，并用空格隔开：");
                string s = Console.ReadLine();
                string[] arr = s.Split(' ');
                int x;
                x = arr.Length;
                int[] arr1 = new int[x];
                int temp = 0;
                for (int i = 0; i < x; i++)
                {
                    arr1[i] = Convert.ToInt32(arr[i]);
                }
                for (int i = 0; i < x - 1; i++)
                {
                    for (int j = i + 1; j < x; j++)
                    {
                        if (arr1[i] < arr1[j])
                        {
                            temp = arr1[i];
                            arr1[i] = arr1[j];
                            arr1[j] = temp;
                        }
                    }
                }
                Console.WriteLine("输入的整数从大到小排序为：");
                for (int k = 0; k < x; k++)
                {
                    Console.WriteLine("{0}", arr1[k]);
                }
            }
        }
    }
}
```

## 乘法口诀

输出9*9乘法口诀：

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _C1_HW3
{
    class Program
    {
        static void Main(string[] args)
        {
            //矩形
            Console.WriteLine("九九乘法表-矩形");
            for (int i = 1; i <= 9; i++)
            {
                for (int j = 1; j <= 9; j++)
                {
                    Console.Write("{1}*{0}={2,2} ", i, j, i * j);
                }
                Console.WriteLine();
            }
            Console.WriteLine("\r\n");
            
            //正三角形
            Console.WriteLine("九九乘法表-正三角形");
            for (int i = 1; i <= 9; i++)
            {
                for (int j = 1; j <= i; j++)
                {
                    Console.Write("{1}*{0}={2,-2} ", i, j, i * j);
                }
                Console.WriteLine();
            }
            Console.WriteLine("\r\n");
            
            //倒三角形
            Console.WriteLine("九九乘法表-倒三角形");
            for (int i = 1; i <= 9; i++)
            {
                for (int k = 0; k < i - 1; k++)
                {
                    Console.Write("       ");
                }
                for (int j = i; j <= 9; j++)
                {
                    Console.Write("{1}*{0}={2,2} ", i, j, i * j);
                }
                Console.WriteLine();
            }
            Console.ReadLine();
        }
    }
}

```