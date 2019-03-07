---
title: Learning C# 2 - C#语言基础
author: Hoas
date: '2019-02-20'
slug: learning-cs-2
categories:
  - course
tags:
  - C
  - 中文
lastmod: '2019-02-20T14:33:11+08:00'
keywords: [C#]
description: 'C#语言基础'
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
先给一个计算素数的例子：
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
            int num = 1;
            while (num < 101)
            {
                //Console.WriteLine("请输入一个数：");
                //string str = Console.ReadLine();
                //num = Convert.ToInt32(str);
                if (num == 1)
                {
                    Console.WriteLine("{0}不是素数！", num);
                }
                else if (num == 2)
                    Console.WriteLine("{0}是素数！", num);
                for (int i = 2; i < num; i++)
                {
                    if (num % i == 0)
                    {
                        Console.WriteLine("{0}不是素数！", num);
                        break;
                    }
                    if (i == num - 1)
                        Console.WriteLine("{0}是素数！", num);
                }
                num++;
            }
            Console.ReadKey();
        }
    }
}
```
<!--more-->
# 基本数据类型

## 值类型

- integer

- float

- boolean

- character

 - `char`
 
 - `string`
 
## 引用类型

# 常量和变量

## 常量

- 字面常量

- 符号常量

## 变量

变量名规则同标识符。变量名建议：

```cs
int myScore = 59;
```

# 表达式与运算符

## 运算符

- 按操作数：

  - 单目运算符

  - 双目运算符

  - 三目运算符`?:`

- 算术运算符

- 自增/减运算符

- 赋值运算符

- 关系运算符

- 逻辑运算符

```cs
if((year%4==0)&&(year%100!=0)||(year%400==0))
  Console.WriteLine("闰年");
```

- 条件运算符

## 运算符优先级

## 表达式中类型转换

- 显式（强制）类型转换

 - `（类型名）表达式`

 - `Convert.To类型名（表达式）`
 
 - `类型名.Parse（表达式）`

- 隐式类型转换

# 选择语句

## if语句

- `if`

- `if...else`

- `if...else if...else`

## switch语句

```cs
switch(score)
{
  case A:
  /*"输出优秀"*/
  break;
  
  defaul:
  /*""*/
  break;
}
```

## while语句

- `do...while`

- `while`

## for语句

## 跳转语句

- `break`

- `continue`.直接跳过接下来的语句然后跳转到`for()`第三个语句然后执行。

- `goto`.添加标签，然后跳转，改变代码执行顺序。

# 数组

- 一维数组

- 多维数组

- 不规则数组（~~我怕是看到了R禁止不规则数组表达的原因...~~）

## foreach语句遍历数组

# 作业

- 分别用for、while、do...while循环实现1--100的累加和

```cs
        static void Main(string[] args)
        {
            //for循环
            Console.WriteLine("for循环运行结果：");
            int sum1 = 0;
            for(int i = 1; i < 101; i++)
            {
                sum1 += i;
            }
            Console.WriteLine("{0}", sum1);

            //while循坏
            Console.WriteLine("while循环运行结果：");
            int sum2 = 0;
            int j = 1;
            while(j < 101){
                sum2 += j;
                j++;
            }
            Console.WriteLine("{0}", sum2);

            //do...while循环
            Console.WriteLine("do...while循环运行结果：");
            int sum3 = 0;
            int k = 1;
            do
            {
                sum3 += k;
                k++;
            } while (k < 101);
            Console.WriteLine("{0}", sum3);
        }
```

- 编写输入年份是否为闰年的程序，直到道按`q`退出

```cs
        static void Main(string[] args)
        {
            Console.WriteLine("若想退出该程序，可在程序提示输入年份的地方键入`q`并回车。");
            Console.WriteLine("\r");
            while (true) {
                Random ran = new Random();
                int n = ran.Next(1900, 2050);
                Console.WriteLine("请输入一个年份，如{0}：",n);
                string str = Console.ReadLine();
                if (str == "q")
                {
                    return;
                }
                int y = Convert.ToInt32(str);
                if ((y % 4 == 0) && (y % 100 != 0) || (y % 400 == 0))
                {
                    Console.WriteLine("{0}是闰年", y);
                }
                else
                {
                    Console.WriteLine("{0}不是闰年", y);
                }
                Console.WriteLine("\r");
            }
        }
```

- 找出所有的水仙花数

```cs
        static void Main(string[] args)
        {
            while (true)
            {
                Console.Write("请输入一个三位数：\r\n");
                string str = Console.ReadLine();
                double n = Convert.ToInt32(str);
                double a = Math.Truncate(n / 100);
                double b = Math.Truncate((n - 100 * a) / 10);
                double c = n - 100 * a - 10 * b;
                double s = Math.Pow(a,3) + Math.Pow(b, 3) + Math.Pow(c, 3);
                if (s == n)
                {
                    Console.Write("{0}是水仙花数。", n);
                }
                else
                {
                    Console.Write("{0}不是水仙花数。", n);
                }
                Console.WriteLine("\r\n");
                //Console.WriteLine("{0},{1},{2},{3}", a, b, c, s);
            }
        }
```

- 上机指导--制作一个简单的客车售票系统

```cs
        static void Main()//入口方法
        {
            Console.Title = "简单客车售票系统";//设置控制台标题
            string[,] zuo = new string[9, 4];//定义二维数组
            for (int i = 0; i < 9; i++)//for循环开始
            {
                for (int j = 0; j < 4; j++)//for循环开始
                {
                    zuo[i, j] = "【有票】";//初始化二维数组
                }
            }
            string s = string.Empty;//定义字符串变量
            while (true)//开始售票
            {
                System.Console.Clear();//清空控制台信息
                Console.WriteLine("\n        简单客车售票系统" + "\n");//输出字符串
                int a=-1, b=-1;
                for (int i = 0; i < 9; i++)
                {
                    for (int j = 0; j < 4; j++)
                    {
                        System.Console.Write(zuo[i, j]);//输出售票信息
                        if(zuo[i, j]== "【已售】")
                        {
                            a = i;
                            b = j;
                        }
                    }
                    System.Console.WriteLine();//输出换行符
                }
                //提示用户输入信息
                if (a >= 0)
                {
                    Console.Write("座次（{0},{1}）已经被占啦hiahiahiahia！\r\n", a, b);
                }
                System.Console.Write("\r\n请输入坐位行号和列号(如：0,2)输入q键退出：");
                s = System.Console.ReadLine();//售票信息输入
                if (s == "q") break;//输入字符串"q"退出系统
                string[] ss = s.Split(',');//拆分字符串
                int one = int.Parse(ss[0]);//得到坐位行数
                int two = int.Parse(ss[1]);//得到坐位列数

                //这个亦或是下面被注释的那个都是在输入信息且出结果后刷屏了，
                //因为只有下面的【已售】改变了原来的静态输出，
                //所以下面的语句不会在控制台中出现
                //另外上面的占座提醒也是，只能改变静态的输出，每次只会在本身上更新
                if (one == a && two == b)
                {
                    Console.Write("你来晚了座次（{0},{1}）没有啦！hiahiahia！\r\n", a, b);
                }
                //if (zuo[one, two] == "【已售】")
                //{
                //    Console.WriteLine("\r\n你来晚了hiahiahia！");
                //}
                //else
                zuo[one, two] = "【已售】";//标记售出票状态
            }
        }

```