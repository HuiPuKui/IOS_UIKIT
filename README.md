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

Xcode 展开所有文件: `⌥ + 左键`

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

## 7-自动布局AutoLayout
iOS中，坐标原点 (0, 0) 在左上角，x 轴向右，y 轴向下

UI 控件对应的坐标为 UI 控件的左上角，原点为父视图的左上角

* 约束不仅要定水平和垂直，还有宽高的约束也要定
* 像 Label、Button 等本身有内容的控件，自带宽高约束

苹果有推荐边距: Constrain to margins

align 中 First Baselines 是文本对齐，比如 Button 和 Label 中文本的最下面对齐

stack view 中的控件除了宽高约束，其它的都会自动消失

显示当前位置所有控件: `shift + 右键`

* Content Hugging Priority 抗拉伸优先级
* Content Compression Resistance Priority 抗压缩优先级

## 8-益智App-趣味问答App

Alert
```swift 
let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .actionSheet)
alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
    NSLog("The \"OK\" alert occured.")
}))
self.present(alert, animated: true, completion: nil)


.alert 中间弹出
.actionSheet 底部弹出

.default 正常操作
.cancel 取消操作
.destructive 破坏性操作
```

虽然 NSLayoutConstraint 的 multiplier 是只读的，但是可以使用 Constant 来计算大小.

## 9-Swift语言-渐入佳境
便利构造器: 关键字 `convenience`

## 10-和风天气App
SF Symbodls 网站链接: `https://developer.apple.com/sf-symbols/`

获取位置
```swift
import CoreLocation

let locationManager: CLLocationManager = CLLocationManager() // 需要使用 CLLocationManager

// 需要设置代理 -- CLLocationManagerDelegate
// 获取成功
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
}

// 获取失败
func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    print(error)
}
```

一个 class 只能继承一个 class，但是可以遵循很多协议

如何让光标聚焦到 TextField:
```swift 
// 弹出软键盘
self.cityTextField.becomeFirstResponder()

// 收起软键盘
self.cityTextField.resignFirstResponder()
```

扩展的关键字: `extension`

## 11-待办事项App

TableViewController
* 适合做整体页面都是 TableView 的情况
* 勾选 is initial view controller 可以作为首页

TableView
* Cell 有重用机制：上面滑走的 cell 会被弥补到最下面，避免重新渲染，可以大大提升性能
* Cell 已经有标题、副标题、Image 等控件，可以直接赋值
* tableView.reloadData() 同样背后也会优化，不会将所有的都刷新

根据 MVC 原则，一定要先改数据，再根据数据修改视图

如果做局部 TableView 的时候只需要设置 Data Source 和 Delegate 为 self，其余的就和 TableViewController 一样

给 按钮 添加点击事件 addTarget ，响应的函数前面要加上 `@objc` 关键字
```swift
checkBoxBtn.addTarget(self, action: #selector(toggleCheck), for: UIControl.Event.touchUpInside)
        
@objc func toggleCheck() -> Void {
        
}
```