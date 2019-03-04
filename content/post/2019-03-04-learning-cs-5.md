---
title: Learning C# 5 - Windows应用程序开发
author: Hoas
date: '2019-03-04'
slug: learning-cs-5
categories:
  - course
tags:
  - C#
lastmod: '2019-03-04T14:10:18+08:00'
keywords: [C#,Windows应用程序开发]
description: 'C# Windows应用程序开发'
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
# 课堂案例

`Program.cs`:
```cs
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
```
<!--more-->

`Form1.cs`:
```cs
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //设置窗体显示的方法
            Form2 f2 = new Form2();
            f2.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //加载窗体之前初始化
            button1.Text = "我的按钮";
        }

        private void label1_Click(object sender, EventArgs e)
        {
        }
    }
```

`Form2.cs`:
```cs
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {
        }
        bool kg = false;
        private void button1_Click(object sender, EventArgs e)
        {
            //定义标签文字是否可见
            kg = !kg;
            label1.Visible = kg;
            //if (label1.Visible == false)
            //    label1.Visible = true;
            //else
            //    label1.Visible = false;
        }

        public int a, b, sum;

        private void Form2_Load(object sender, EventArgs e)
        {
            Random rd = new Random();
            a = rd.Next(1,100);
            textBox1.Text = a.ToString();
            b = rd.Next(10,20);
            textBox2.Text = b.ToString();
            label1.Visible = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            int rst = Convert.ToInt32(textBox3.Text);
            sum = a + b;
            if (rst == sum)
                label1.Text = "小朋友真厉害~";
            else
                label1.Text = "你怎么这么笨？";
            //textBox3.Text = sum.ToString();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox3.Text = "";
            Random rd = new Random();
            a = rd.Next(1, 100);
            textBox1.Text = a.ToString();
            b = rd.Next(10, 20);
            textBox2.Text = b.ToString();
        }
        bool mm = false;
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            //设置密码形式
            mm = !mm;
            if (checkBox1.Checked == true)
                textBox3.PasswordChar = '*';
            else
                textBox3.PasswordChar = new char();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
```

效果图：

<img src="/post/!image/Csc4-1.png" alt="主窗体">

<img src="/post/!image/Csc4-2.png" alt="Form2答错了">

<img src="/post/!image/Csc4-3.png" alt="Form2答对了+*">

# Windows 控件

## control基类

control类派生的控件。

## label控件

用于标识对象，显示用户不能编辑的文本，可显示和隐藏。

## button控件

单击显示某个操作。

## textbox控件

文本框控件，主要用于获取用户输入的数据或者显示的文本，通常用于可编辑文本。

关于textbox中的密码设置，可以使用`UseSystemPasswordChar = true`来实现，或者用`textBox3.PasswordChar = new char()`也行~

另外`label`可以对`textBox`的数据改变做出响应。

## CheckBox控件

复选框控件。

## radiobutton控件

单选按钮控件。

## richtextbox控件

有格式文本框控件，主要用于显示、输入和操作带有格式的文本。

