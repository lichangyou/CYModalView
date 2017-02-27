# CYModalView

仿淘宝详情界面弹出动画

#动画演示图：

![动画演示图](https://github.com/lichangyou/CYModalView/blob/master/%E5%8A%A8%E7%94%BB%E6%BC%94%E7%A4%BA%E5%9B%BE.gif)

#使用说明

将带有 .h 和 .m 的文件夹 CYModalView 拖入到项目中，然后在要使用的控制器中:

######1.导入CYModalView

```objc
 #import "CYModalView.h" 
```
######2.添加属性

```objc
@property (strong, nonatomic) CYModalView *modalView;
```
######3.初始化CYModalView

```objc    
self.modalView = [[CYModalView alloc] initWithHeight:300 andViewController:self.navigationController];
```
**注意**：如果当前控制器带有导航栏，需要传入self.navigationController，否则导航栏还会停留在原处。

######4.弹出视图

```objc
[self.modalView present];
```
######5.弹回视图，两个方法，根据弹回后有无操作选择

```objc
[self.modalView dismiss];
```

```objc
[self.modalView dismissWithCompletion:^{
    // 弹回后的操作，如跳转到下一个界面
}];

```
