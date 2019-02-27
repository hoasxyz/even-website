---
title: Learning C# 3 - 面向对象的编程基础
author: Hoas
date: '2019-02-25'
slug: learning-cs-3
categories:
  - course
tags:
  - C#
lastmod: '2019-02-25T14:14:03+08:00'
keywords: [C#]
description: 'C#面向对象的编程基础'
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
这章内容感觉最重要的就是掌握C#里面的结构，特别是对对象、类、方法等的理解。我觉得书上的例子挺不错的：

- 对象就是一个个实体，具有一定的属性和动作（行为）；

- 类就是一个抽象的大类，包含着对象的属性和方法；

- 属性就是对实体特征的抽象，而继承性也主要利用特定对象之间的共有属性；

- 方法就是实体的行为，可以根据实体们不同的属性进行重载。

而面向对象的程序设计最重要的就是多态，多态的实现不依赖于抽象类，而是依赖于抽象类和接口。多态机制中将抽象类定义为接口，由抽象方法组成的集合就是接口。

另外发现类成员之一属性用得也比较多，虽然还是不知道get访问器和set访问器有啥用。
<!--more-->

# 三大原则

- 封装

- 继承：将有用的类保存下来，遇到同样的问题的时候再拿来复用

- 多态：父类对象应用于子类，比如图形绘制系统的引用

# 类

  类是一种__数据结构__，它可以包含数据成员（常量和域）、函数成员（方法、属性、事件、索引器、运算符、构造函数和析构函数）和嵌套类型。

  类（class）实际上是对某种类型的对象定义变量和方法的原型,它表示__对现实生活中一类具有共同特征的事物的抽象__，是面向对象编程的基础。

  C#的构造函数：

```cs
struct str{
int no;
string name;
int age
}

stu st1,st2,st3

st1.no = 1001;
st1.name = hoas;
...
```

- 类的声明

```cs
//类修饰符 class 类名
//{
//}


public class Car
{
    public int number;
    public string color;
    private string brand;	
}

```

- 类的成员

  - 字段
  
  - 属性。属性是对现实实体对象的抽象，提供对类或对象的访问。属性名的第一个字母通常都大写。属性的主要作用是限制外部类对类中成员的访问权限。
  
      1. `get访问器`（可读属性）：相当于一个具有属性类型返回值的无参数方法，它除了作为赋值的目标外，当在表达式中引用属性时，将调用该属性的`get访问器`计算属性的值。`get访问器`必须用`return`语句来返回。
      
      2. `set访问器`（可写属性）：相当于一个具有单个属性类型值参数和void返回类型的方法。
  
  - 枚举
  
  ```cs
    enum 枚举名
{
   list1=value1,
   list2=value2,
   list3=value3,
   …
   listN=valueN,
}    
  ```
  
- 构造函数和析构函数

  - 构造函数。构造函数是在创建给定类型的对象时执行的类方法，构造函数具有与类相同的名称，它通常初始化新对象的数据成员。

  - 析构函数。析构函数是以类名加`~`来命名的。.NET Framework 类库有垃圾回收功能，当某个类的实例被认为是不再有效，并符合析构条件时，.NET Framework 类库的垃圾回收功能就会调用该类的析构函数实现垃圾回收。

# 对象

## 对象的创建及使用

`Object obj = new Object();`

`this`关键字。C#语言中可以使用`this`关键字来代表本类对象的引用，`this`关键字被隐式地用于引用对象的成员变量和方法。

```cs
private void setName(String name)
 { 	
         this.name=name; 
}
```

可以使用`对象.类成员`来获取对象的属性和行为。

# 方法

## 声明

```cs
修饰符 返回值类型 方法名(参数列表)
{
      //方法的具体实现；
}

public void ShowGoods()
{
      Console.WriteLine("库存商品名称：");
      Console.WriteLine(FullName);
}
```

## 参数

- 值参数。值参数就是在声明时不加修饰的参数，它表明实参与形参之间按值传递。由于是值类型的传递方式，所以，在方法中对形参的修改并不会影响实参。

```cs
private int Add(int x, int y)
{
    x = x + y; 
    return x;										//返回x
}
```

- `ref`参数使形参按引用传递，其效果是：在方法中对形参所做的任何更改都将反映在实参中。如果要使用 ref 参数，则方法声明和方法调用都必须显式使用 ref 关键字。

```cs
private int Add(ref int x, int y)	
{
    x = x + y; 
    return x;											//返回x
}
```
- `out`.关键字用来定义输出参数，它会导致参数通过引用来传递，使用 out 关键字定义的参数，不用进行赋值即可使用。如果要使用 out 参数，则方法声明和方法调用都必须显式使用 out 关键字。

```cs
private int Add(int x, int y,out int z)
{
    z = x + y; 
    return z;											//返回z
}
```

- `params`.声明方法时，如果有多个相同类型的参数，可以定义为 params 参数。 params 参数是一个一维数组，主要用来指定在参数数目可变时所采用的方法参数。

```cs
private int Add(params int[] x)
{
    int result = 0; 
    for (int i = 0; i < x.Length; i++)
    {
        result += x[i]; 
    }
    return result;
}
```

## 静态方法和实例方法

- 静态方法。静态方法不对特定实例进行操作，在静态方法中引用 this 会导致编译错误，调用静态方法时，使用类名直接调用，因为没有实例。


```cs
public static int Add(int x, int y)
    {
        return x + y;
    }
    static void Main(string[] args)
    {
        Console.WriteLine("{0}+{1}={2}", 23, 34, Program.Add(23, 34));
        Console.ReadLine();
    }
```

- 实例方法。实例方法是对类的某个给定的实例进行操作，使用实例方法时，需要使用类的对象调用，而且可以用 this 来访问该方法，有实例。

```cs
public int Add(int x, int y)
    {
        return x + y;
    }
    static void Main(string[] args)
    {
        Program pro = new Program();
       Console.WriteLine("{0}+{1}={2}", 23, 34, pro.Add(23, 34)); 
        Console.ReadLine();
    }
```

## 重载

方法重载是指方法名相同，但参数的数据类型、个数或顺序不同的方法。

```cs
public static int Add(int x, int y) 
    {
        return x + y;
    }
public double Add(int x, double y)
    {
        return x + y;
    }
    public int Add(int x, int y, int z)
 {
        return x + y + z;
    }

```

# 作业

- 建立一个类圆，可实现求圆的周长和面积

```cs
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Circle r = new Circle();
                Console.WriteLine("请输入一个数作为圆的半径：");
                double radius = Convert.ToDouble(Console.ReadLine());
                r.Peri(radius);
                r.Area(radius);
                Console.WriteLine("\r");
            }
        }
    }
    class Circle
    {
        public void Peri(double radius)
        {
            Console.WriteLine("该圆的周长为：{0}", radius * 2 * Math.PI);
        }
        public void Area(double radius)
        {
            Console.WriteLine("该圆的面积为：{0}", Math.Pow(radius, 2) * Math.PI);
        }
    }
```

- 建立一个动物类，实现吃和叫的行为

```cs
    class Program
    {
        static void Main(string[] args)
        {
            Animal cat = new Animal();
            cat.Eat();
            Console.WriteLine("\r");
            cat.Roar();
            Console.WriteLine("\r");
            Tigger tigger = new Tigger();
            tigger.Eat();
            Console.WriteLine("\r");
            tigger.Roar();
        }
    }
    class Animal
    {
        public virtual void Eat()
        {
            Console.WriteLine("吃");
        }
        public virtual void Roar()
        {
            Console.WriteLine("叫");
        }
    }
    //子类的运用
    class Tigger:Animal
    {
        public override void Eat()
        {
            Console.WriteLine("老虎吃肉");
        }
        public override void Roar()
        {
            Console.WriteLine("嗷呜！");
        }
    }
```

- 建立重载函数，实现参数的屏幕输出

```cs
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("请输入两个数,用空格分开：");
                string str = Console.ReadLine();
                string[] arr = str.Split(' ');
                double x = Convert.ToDouble(arr[0]);
                double y = Convert.ToDouble(arr[1]);
                int x2 = Convert.ToInt32(x);
                int y2 = Convert.ToInt32(y);
                double z = (x2 + y2) / 2;
                Program i = new Program();
                Console.WriteLine("(" + x + "+" + y + ") / 2 = " + Program.Mean(x, y));
                Console.WriteLine("(" + x + "+" + y + "+" + z + ") / 3 = " + i.Mean(ref x, y, z));
                Console.WriteLine("(" + x + "+" + y + ") / 2 = " + i.Mean(ref x, y));
                Console.WriteLine("(" + x2 + "+" + y2 + ") / 2 = " + i.Mean(x2, y2));
                Console.WriteLine("\r");
            }
        }
        public static double Mean(double x, double y)
        {
            x = (x + y) / 2;
            return x;
        }
        public double Mean(ref double x, double y, double z)
        {
            x = (x + y + z) / 3;
            return x;
        }
        public double Mean(ref double x, double y)
        {
            x = (x + y) / 2;
            return x;
        }
        public int Mean(int x, int y)
        {
            x = (x + y) / 2;
            return x;
        }
    }

```

{{% admonition warning warning %}}
C#中的数组是从0开始的！！
{{% /admonition %}}

- 课堂实例，虽然不知道在干什么

```cs
    class Program
    {
        static void Main(string[] args)
        {
            A a1 = new A();
            A a2 = new A(5, 4);
            a2.Show();
            Console.ReadLine();
        }
    }
    class A
    {
        int a, b;
        public A()
        {
            a = 0;
            b = 0;
        }
        public A(int ca)
        {
            a = ca;
            b = 0;
        }
        public A(int ca, int cb)
        {
            a = ca;
            b = cb;
        }
        public void SetA(int sa)
        {
            a = sa;
        }
        public void SetB(int sb)
        {
            b = sb;
        }
        public int ADD()
        {
            return a + b;
        }
        public void Show()
        {
            Console.WriteLine("{0}+{1}={2}", a, b, ADD());
        }

    }
}
```