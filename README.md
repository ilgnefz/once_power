<div align=center><img alt="OncePower" src="doc/logo.png"></div>

 简体中文 | [English](./README-EN.md)

OncePower 是一个批量重命名文件或文件夹的工具。集免安装、傻瓜式、快速上手于一身，功能清晰明了，学习成本低。

## 语言支持

- 中文
- 英语

## 平台支持

- **Windows**
- **macOS**（需要自己打包）
- **Linux**

## 快速上手

本教程只会涉及一些技巧。

添加要重命名的文件或文件夹可以直接拖到软件上（如果没有选中**添加文件夹**的话，拖动文件夹会自动获取所有子文件），也可以通过底部按钮。双击文件名可以快速的将文件名称添加到输入框。

![1](https://github.com/ilgnefz/once_power/blob/master/doc/1.gif)

本软件一共分为3种模式：默认模式、保留模式、长度模式。

### 默认模式

在默认模式下，匹配的内容将会被删除。

在**修改为**的输入框中输入的内容将会替代匹配的内容。

![2](https://github.com/ilgnefz/once_power/blob/master/doc/2.gif)

### 保留模式

保留模式下匹配的内容会保留，其他内容删除。

也可以通过选项选择不同的类型保留。

![12](https://github.com/ilgnefz/once_power/blob/master/doc/12.gif)

选择**以创建日期命名**会将匹配的内容更改为创建日期。可以选择不同的日期命名。如果选择了**拍摄日期**（只有携带 exif 信息的图片才有）而图片没有的话，会使用几个日期里最早的日期。

![3](https://github.com/ilgnefz/once_power/blob/master/doc/3.gif)

### 长度模式

长度模式下可以随机输入一个长度的字符串，或者使用 ***数字**，就会保留（选择了删除指定长度会删除）和随机字符串一样长或指定数字的前几位名称。

![4](https://github.com/ilgnefz/once_power/blob/master/doc/4.gif)

如果想要获取中间一部分的内容，可以输入两次 ***数字**，例如输入`*8*12`，将会截取第8个开始的字符到第12个开始的字符。

![13](https://github.com/ilgnefz/once_power/blob/master/doc/13.gif)

### 前缀和后缀

**前缀**和**后缀**可以直接输入内容，选择的文件都会在原始名称前或后添加好内容。

![5](https://github.com/ilgnefz/once_power/blob/master/doc/5.gif)

在**前缀**和**后缀**的输入框后有一个上传按钮，可以上传一个 **.txt** 文件，上传的文件内容必须以**空格**或者**换行**隔开。例如：

```txt
January 一月
February 二月
March
April

```

注意，上面的结尾有一个空行，这会占一个前缀或后缀的位置。

![6](https://github.com/ilgnefz/once_power/blob/master/doc/6.gif)

在**后缀**的下面有一个**循环文件内容**的选项，可以用来控制当上传的文件内容比选择要重命名的文件少时，是否循环内容作为前缀或后缀。

当我们选择上传前缀后缀文件时，想在他们之间再添加点空格或者横杠什么的，可以直接在文件名前后添加。

![7](https://github.com/ilgnefz/once_power/blob/master/doc/7.gif)

### 前缀和后缀数字递增

在**前缀数字递增**和**后缀数字递增**中输入的任何内容都会只去其长度，作为递增的数字的长度。如果想要添加空格之类的需要在**前缀**和**后缀**中添加。

![8](https://github.com/ilgnefz/once_power/blob/master/doc/8.gif)

**交换递增数字位置**可以把前缀放在递增数字前，或后缀放在递增数字后。

### 追加模式

默认情况下再添加新的文件会替代前面已经存在的文件，选择**追加模式**可以直接在后面添加。

### 添加文件夹

**添加文件夹**可以用来选择文件夹，更改文件夹的名称。

### 整理文件

整理文件功能在左下角菜单里。

主要是用来移动嵌套文件夹里的文件。比如我有一下文件夹，第一层和最里面一层各有一个同名的文件。

![20230331114922](https://github.com/ilgnefz/once_power/blob/master/doc/20230331114922.png)

我们可以选择最外面的父文件夹，然后进行整理：

![9](https://github.com/ilgnefz/once_power/blob/master/doc/9.gif)

点击**删除空文件夹**可以删除无用的嵌套空文件夹。

## 打包

该项目只在 Win10 和 Ubuntu 测试过，macOS 需要自行测试，不出意外应该不用特别配置某个第三方库。

因为使用了 [flutter_distributor](https://distributor.leanflutter.org/zh/docs/getting-started)，打包的配置文件已经配置好了。想打包的要依次执行一下命令：

```
dart pub global activate flutter_distributor
```

```
npm install -g appdmg
```

```
flutter_distributor package --platform macos --targets dmg
```

## LICENSE

[GPL 2.0 License](https://github.com/ilgnefz/once_power/blob/master/LICENSE)
