# 系统学习 iOS 开发 - IOS_UIKIT
## 1-课程简介

## 2-iOS开发准备和Xcode
Xcode 偏好设置: `⌘ + ,`

代码字号放大: `⌘ + +`

代码字号缩小: `⌘ + -`

Xcode 编译项目: `⌘ + B`

Xcode 运行项目: `⌘ + R`

Xcode 停止项目: `⌘ + .`

Xcode 控件库: `⌘ + ⇧ + L`

## 3-人生第一个App-赏月App
取色网站: https://flatuicolors.com/

App图标生成/1x2x3x图片生成网站: https://www.appicon.co/

设计网站: https://www.canva.cn

## 4-游戏App-摇骰子App

storyboard 右上角的 adjust Editor Options（五条横线）可以展示对应的代码区

按住 ctrl 点击控件并拖拽可以将控件与代码区进行连线

* @IBOutlet: 代表着 storyboard 上的控件
* @IBAction: 代表着控件上的事件
* IB -> Interface Builder

```
可以通过右键 storyboard - Open As - Interface Builder - Storyboard 展示可视化界面 
                               |- Source Code 展示 xml
```
```
常见错误：连接问题
*** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Dice.ViewController 0x103b0c2a0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key diceImageView.'
```

## 5-Swift语言-入门

## 6-音乐App-木琴App
可以通过 Tag 属性来区分 @IBAction 相同的不同控件

```swift 
import AVFoundation // 音视频功能包

AVAudioPlayer(contentsOf: url) // 音视频播放器

// swift 异常捕获
do {
    try AVAudioPlayer(contentsOf: url)
} catch {
    print(error)
}
```

## 自动布局AutoLayout
iOS中，坐标原点 (0, 0) 在左上角，x 轴向右，y 轴向下

UI 控件对应的坐标为 UI 控件的左上角，原点为父视图的左上角

* 约束不仅要定水平和垂直，还有宽高的约束也要定
* 像 Label、Button 等本身有内容的控件，自带宽高约束

苹果有推荐边距: Constrain to margins

align 中 First Baselines 是文本对齐，比如 Button 和 Label 中文本的最下面对齐

stack view 中的控件除了宽高约束，其它的都会自动消失