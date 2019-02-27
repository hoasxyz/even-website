---
title: Learning C# 4 - 面向对象编程进阶
author: Hoas
date: '2019-02-27'
slug: learning-cs-4
categories:
  - course
tags:
  - C#
lastmod: '2019-02-27T13:59:29+08:00'
keywords: [C#,面向对象编程进阶]
description: 'C#面向对象编程进阶'
draft: true
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

这一章给我的感觉就是我根本不知道具体为什么会用到那些东西——换句话说就是我不知道它们被创造出来的原因，因此我是懵逼的……
<!--more-->

# 类的继承和多态

任何类都可以从另外一个类中继承，也就是说，这个类拥有它继承的类的所有成员（？）。C#中一次只能允许继承一个类。

## 继承

- 继承基类的派生类可以继承、增加基类中原有的属性和方法，也可以改写基类的方法。用`:`表示两个类的继承关系，用`protected`提供可访问性——只有子类才能访问`protected`成员。

- `base`关键字用来从子类中访问基类的成员，在[静态方法](https://hoas.xyz/post/learning-cs-3/#%E9%9D%99%E6%80%81%E6%96%B9%E6%B3%95%E5%92%8C%E5%AE%9E%E4%BE%8B%E6%96%B9%E6%B3%95)中使用基类是错误的！

- 继承中的构造函数的执行顺序是从基类到一级子类、二级子类……而析构函数相反

## 多态

类的多态是通过在派生类中重写基类的方法实现的。

- 虚方法`virtual`的重写（覆盖，`override`）。

- 抽象类，加上`abstract`关键字。类中只要有一个方法声明为抽象方法，那么这个类也必须被声明为抽象类。

- 密封类，`sealed`关键字，密封方法只能实现基类的虚方法。

# 结构和接口

## 结构

一个结构不能从另一个结构或内中继承。

## 接口

通过接口可以实现多重继承。一个类可以继承任意接口，接口也可以数组化。接口中成员默认为公共，不允许加修饰符。多重继承中要继承的接口用`,`分割。

如果多个接口具有相同签名（不知道是啥没关系，就认为他们都一样）的时候，可以用显式接口实现接口成员。

## 抽象类和接口

共同点：

- 都包含可以由子类继承的成员，它们都不能直接实例化，但可以声明它们的变量。

- 它们的子类只能继承一个基类，即只能继承一个抽象类，但可以继承任意多个接口。

不同点：

- 抽象类可以定义成员的实现，接口不可以。

- 抽象类可以是私有的。

- 抽象类可以包含字段、构造函数、析构函数、静态成员或常量等。

# 异常处理

- `try...catch(...finally)`

- `throw`

# 委托和匿名方法

委托（delegate）是方法的引用，一旦为委托分配了方法，委托将具有与该方法相同的行为。

## 委托

在委托对象中存放的不是对数据的引用，而是存放对方法的引用。即在委托的内部包含一个指向某个方法的指针。

## 匿名方法

简化委托引用方法的过程，似乎没有引用方法，自己就是一个方法……（要不然为啥叫匿名方法……）

# 事件

C#中的事件就是你在学习C#的时候遇到的一些脑阔疼的事情，我觉得我的这个解释比书上的直观明了多了……

# 作业

只有一个：参照立4-11表写一个委托，在主函数中调用类方法实现加、减、乘、除和求余运算。

```csharp
    class Program
    {
        public delegate double Compute(double x, double y);
        static void Main(string[] args)
        {
            Operation p = new Operation();
            Compute ca = p.Add;
            Compute cmi = p.Minus;
            Compute cmu = p.Multiply;
            Compute cd = p.Division;
            Compute cr = p.Remainder;
            while (true)
            {
                Console.WriteLine("请输入两个数，用逗号隔开:");
                string str = Console.ReadLine();
                string[] arr = str.Split(',');
                double x = Convert.ToDouble(arr[0]);
                double y = Convert.ToDouble(arr[1]);
                double add = ca(x, y);
                double minus = cmi(x, y);
                double multiply = cmu(x, y);
                double division = cd(x, y);
                double remainder = cr(x, y);
                Console.WriteLine("运算结果是：");
                Console.WriteLine("求和：" + add);
                Console.WriteLine("相减：" + minus);
                Console.WriteLine("相乘：" + multiply);
                Console.WriteLine("相除：" + division);
                Console.WriteLine("求余：" + remainder);
                Console.WriteLine("\r");
            }
        }
    }
    public class Operation
    {
        public double Add(double x, double y)
        {
            return (x + y);
        }
        public double Minus(double x, double y)
        {
            return (x - y);
        }
        public double Multiply(double x, double y)
        {
            return (x * y);
        }
        public double Division(double x, double y)
        {
            return (x / y);
        }
        public double Remainder(double x, double y)
        {
            return (x % y);
        }
    }
```

