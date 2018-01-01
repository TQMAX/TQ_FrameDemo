# TQ_FrameDemo
常见的TabBar框架+多Tap处理的小Demo

## （2018年的第一天，算是献给自己的新年礼物吧O(∩_∩)O~~）

### 效果具体看图吧，内容详见Demo，如有其它想法，欢迎与我交流~

![](https://github.com/TQMAX/Markdown-Res/blob/master/Res/%20001.gif?raw=true)

### 1、整个框架效果

![](https://github.com/TQMAX/Markdown-Res/blob/master/Res/%20002.gif?raw=true)

### 2、按钮分tap，内容不是堆在同一个controller里面，而是在ScrollView上添加其他的controller内容

![](https://github.com/TQMAX/Markdown-Res/blob/master/Res/%20003.gif?raw=true)

### 3、和图2显示效果差不多，但是方法不同，封装了一下，tap的数量由数组定义，并且添加了和ScrollView不冲突的滑动返回手势！（其实是引用了搭档的手势🤣，详见 [原手势demo](https://github.com/xingtianwuganqi/PopGestureRecognizer)）
