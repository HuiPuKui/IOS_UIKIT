# 系统学习 iOS 开发 - IOS_UIKIT 基础版
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

## 12-本地存储
UserDefaults
* 存放于沙盒（SandBox）中，每个 App 都有自己的沙盒
* `NSHomeDirectory()` 沙盒路径
```swift
UserDefaults.standard.set(value: Any?, forKey: String)
UserDefaults.standard.data(forKey: String)
```

遵循 Encodable 协议的数据才能被编码

遵循 Decodable 协议的数据才能被解码

遵循 Codable 协议的数据才能被编码和解码

AppDelegate 管理 App 的生命周期

Core Data 持久化数据存储: 连接代码和 sqlite 的桥梁
```swift
let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
let todo: Todo = Todo(context: context)
todo.name = name
todo.checked = false
appDelegate.saveContext()

// 获取数据
let todos = try? context.fetch(Todo.fetchRequest())
```

DB Browser for SQLite: `https://sqlitebrowser.org/dl/`

## 13-在AppStore上架App

# 系统学习 iOS 开发 - IOS_UIKIT 进阶版
## 1-课程简介

## 2-外卖App点菜页
```swift
didSet: 传值的时候会触发

var menu: Menu? {
    didSet {
        
    }
}
```
判断向上/下滚动
```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let tableView: UITableView = scrollView as! UITableView
    if tableView == self.menuTableView {
        self.menuTableViewGoDown = self.menuTableViewCurrentContentOffsetY < tableView.contentOffset.y
        self.menuTableViewCurrentContentOffsetY = tableView.contentOffset.y
    }
}
```

## 3-Swift语言进阶
计算属性
```swift
struct Rect {
    ...
    var center: Point {
        get {
            ...
        }
        set(newCenter) {
            ...
        }
    }
}
```
属性观察者
```swift
class Product {
    var price: Double = 0.0 {
        willSet {
            
        }
        didSet {
            
        }
    }
}
```
类型属性
```swift
struct User {
    var name: String = "张三"
    static let standard = User()
}


// 类型属性: 静态属性（static前缀）+ 类属性（class前缀）
// static 虽然可以在类、结构体、或者枚举中使用，且可以修饰存储属性、计算属性和方法，非常通用，但它修饰的计算属性不能被重写
// class 虽然只能在类中使用，却只顾被曝光修饰类中的计算属性和方法，但修饰的计算属性和方法可以被重写（如Bundle的main属性，UserDefault的standard属性）

// 总结: 如无重写需求，则统一使用static，性能更高
```
访问权限

* private: 只能在自己的作用域中使用，不可以跨文件
* fileprivate: 可以在同一个文件中使用
* internal: 默认权限，可以在同一个 Module 中使用
* public: 可以在不同的 Module 中使用，public 的修饰内容在外部无法被继承或者重写
* open: 可以在不同的 Module 中使用，open 的修饰内容在外部可以被继承或者重写，只能用来修饰 class，和 class 中的属性和方法

## 4-UICollectionView

Using the Flow Layout 文档: `https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html#//apple_ref/doc/uid/TP40012334-CH3-SW1`

## 5-瀑布流布局
* `AnyObject` 是Swift的一个特殊协议，用来表示所有引用类型的对象
* 重写父类的属性都要写成计算属性

## 6-手势
handling UIKit gestures: `https://developer.apple.com/documentation/uikit/handling-uikit-gestures`

* 点击
* 捏合
* 旋转
* 轻滑
* 拖拽
* 边缘拖拽
* 长按
* 自定义

离散型手势、持续型手势

弧度: `https://www.zhihu.com/question/40759023`

矩阵的本质: `https://www.zhihu.com/question/22047061`

* 3.1415926... 弧度 = 180度

## 7-UIScrollView
ScrollView下面有两个 Guide
* Content Layout Guide 内容布局
* Frame Layout Guide 相框布局

frame / bounds 区别: 
* frame 在父视图坐标体系中的位置和大小
* bounds 在自身坐标体系中的位置和大小

## 8-App引导页
还可以使用 pdf 图片，因为是矢量图，可以自动处理成 1x 2x 3x

不好的地方是打包的容量会变大，如果很多的话推荐使用 png

Page Control
* Tint Color: 未选中时的颜色
* Current Page: 被选中时的颜色

## 9-TabBarController

TabBarItem 中的图片需要明确指定大小的，大约 20 ～ 30，如果太大就会超出

图片渲染模式：
* Template Image: 颜色会随着父视图的改变而改变
* Original Image: 颜色不会随着父视图的改变而改变

在代码中调节 selectedImageTintColor 这个已经被废弃了，应该使用 tintColor
```swift
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .systemRed
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
```

默认效果：
* 以前的版本中默认效果是毛玻璃效果
* 现在默认是透明的
* 子 VC 中是 Scroll View 时，Scroll View 和 Tab Bar 重叠的时候，会由透明变为毛玻璃，否则为透明

Tab Bar Controller 中的 Tab Bar Item 会把 Safe Area 往上推

Tab 最多放 5 个，如果超过了会变成 More

## 10-解析 JSON 数据

遵循 Decodable 才能被解码

可以自动遵循 Decodable 协议的类型
```swift
Int         Data
String      Array
Double      Dictionary
Float       URL
Bool        Date
```

## 11-用纯代码写一个小项目
从文件中读取
```swift
func loadData() {
    if let coursesJSONURL: URL = Bundle.main.url(forResource: "courses", withExtension: ".json") {
        if let coursesJSONData: Data = try? Data(contentsOf: coursesJSONURL) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            ...
        } else {
            print("url 转 Data 失败")
        }
    } else {
        print("从 courses.json 文件中取 url 失败，检查拼写等")
    }
}
````

懒加载的属性必须定义成 var
```swift
// lazy: 只有使用到这个 UI 控件的时候才会调用这个代码
private lazy var tableView: UITableView = {
    let tableView: UITableView = UITableView()
    
    // 设置属性
    tableView.translatesAutoresizingMaskIntoConstraints = false // 用约束来指定布局
    tableView.dataSource = self
    tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    
    return tableView
}()
```

## 12-自定义转场动画
Customizing the Transition Animations | 自定义转场动画官方讲解: `https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html`

View Controller Transitions | 自定义转场动画的一些协议: `https://developer.apple.com/documentation/uikit/view-controller-transitions`

六个维度：
* Modally 转场
    
    * Non-Interactive Transitions 非交互转场
    * Interactive Transitions 交互转场

* Navigation Controller

    * Non-Interactive Transitions 非交互转场
    * Interactive Transitions 交互转场

* Tabbar Controller

    * Non-Interactive Transitions 非交互转场
    * Interactive Transitions 交互转场

自定义转场机制：在动画完成之后会自动从 containerView 中把原来的 View 移除掉

在动画里使用了 transform 属性，就一定要在完成时置空

## 13-物联网核心-蓝牙开发
Bluetooth: `https://developer.apple.com/bluetooth/`

Core Bluetooth: `https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/AboutCoreBluetooth/Introduction.html`

蓝牙模拟器: `LightBlue`

## 14-Container View
* 用AVPlayerViewController创建一个简单播放器 | 官方文档: `https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/GettingStarted/GettingStarted.html`
* 自定义Container View Controller - 官方文档: `https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html`
* AVPlayer - AVFoundation | 官方文档: `https://developer.apple.com/documentation/avfoundation/avplayer`
* AVPlayerViewController - AVKit | 官方文档: `https://developer.apple.com/documentation/avkit/avplayerviewcontroller`

容器视图就是：View 里面放了个 Controller View

`childVC.didMove(toParent: self)`意思是 —— 通知子控制器“你已经有了一个父控制器”。这样，UIKit 的生命周期事件（比如 viewWillAppear / viewDidAppear）才能正确传递到子控制器。

## 15-WKWebView
WKWebView | 官方文档: `https://developer.apple.com/documentation/webkit/wkwebview`

## 16-git+github+版本控制

`git add` 把工作区的修改（新增、修改、删除的文件）放到 暂存区

`git commit -m ""` 把暂存区里的内容保存到 本地仓库

`git acm ""` add & commit

`git status` 查看当前仓库的状态

`git log` 查看历史提交记录

`git diff` 查看修改

`git checkout 路径` 检出

`.gitignore` 忽略配置

`fork` 复制到自己账号里了，不是本地

## 17-应用内购买IAP

需要开发者账号！！！

## 18-AI机器学习-CoreML2

机器学习: `https://developer.apple.com/cn/machine-learning/`

coremltools: `https://apple.github.io/coremltools/`

Model Zoo | 训练好的Caffe模型库: `https://github.com/BVLC/caffe/wiki/Model-Zoo`

自制一个图像识别的mlmodel: `https://developer.apple.com/documentation/createml/creating-an-image-classifier-model`

awesomedata大数据集: `https://github.com/awesomedata/awesome-public-datasets`

Kaggle大数据集: `https://www.kaggle.com/datasets`

中文情感分析语料库大全 - DataScience: `https://mlln.cn/2018/10/11/%E4%B8%AD%E6%96%87%E6%83%85%E6%84%9F%E5%88%86%E6%9E%90%E8%AF%AD%E6%96%99%E5%BA%93%E5%A4%A7%E5%85%A8-%E5%B8%A6%E4%B8%8B%E8%BD%BD%E5%9C%B0%E5%9D%80/`

自制自然语言处理的mlmodel | 官方文档: `https://developer.apple.com/documentation/createml/creating_a_text_classifier_model`

awesomedata大数据集: `https://github.com/awesomedata/awesome-public-datasets`

Google 表格 - 在线创建和编辑电子表格: `https://workspace.google.com/products/sheets/`

Kaggle大数据集: `https://www.kaggle.com/datasets`


机器学习的分类:

1. 有监督学习--准确，但费时间
给机器一个对应关系（指着桌上的手机--告诉机器它叫手机） ---训练（给训练数据贴标签label）
指着桌上的手机问机器它是什么 ---输入input
告诉我们它是手机 ---输出output

2. 无监督学习
不给出对应关系，只是仍一堆东西给机器，机器最终只能辨别出哪些东西属于一类，哪些不是一类，仅此而已。

3. 半监督学习

4. 增强学习

## 19-AI机器学习-CoreML3

机器学习: `https://developer.apple.com/machine-learning/`

Vision | Apple Developer Documentation: `https://developer.apple.com/documentation/vision`

## 20-AR黑科技和ARKit2

ARKit - Apple Developer: `https://developer.apple.com/cn/augmented-reality/arkit/`

ARKit | 官方文档: `https://developer.apple.com/documentation/arkit`

Solar Textures | 3D星球贴纸: `https://www.solarsystemscope.com/textures/`

ARKit - 支持usdz文件: `https://developer.apple.com/cn/arkit/`

blender.org - 制作3D模型工具（了解）: `https://www.blender.org/`

SCNSceneSource - 支持dae文件: `https://developer.apple.com/documentation/scenekit/scnscenesource`

TurboSquid - 现成的3D模型: `https://www.turbosquid.com/`

.obj 转 usdz : `xcrun usdz_converter /path/to/xxx.obj /path/to/xxx.usdz`

ARHitTestResult | 命中测试: `https://developer.apple.com/documentation/arkit/arhittestresult`

3D Pokemon Models | 口袋妖怪3D模型: `https://roestudios.co.uk/project/3d-pokemon-models/`

宝可梦列表 - 神奇宝贝百科: `https://wiki.52poke.com/zh-hans/%E5%AE%9D%E5%8F%AF%E6%A2%A6%E5%88%97%E8%A1%A8%EF%BC%88%E6%8C%89%E5%85%A8%E5%9B%BD%E5%9B%BE%E9%89%B4%E7%BC%96%E5%8F%B7%EF%BC%89`

Detecting Images in an AR Experience | AR中的图片检测: `https://developer.apple.com/documentation/arkit/detecting_images_in_an_ar_experience`

Print Proxy cards – 口袋妖怪卡片: `https://limitlesstcg.com/tools/proxies`

## 21-AR新功能-ARKit3

人物遮挡 | Apple Developer Documentation: `https://developer.apple.com/documentation/arkit/occluding_virtual_content_with_people`

AR - Apple Developer: `https://developer.apple.com/augmented-reality/`

Loading Entities from a File | Apple Developer Documentation: `https://developer.apple.com/documentation/realitykit/loading-entities-from-a-file`

Creating a Collaborative Session | Apple Developer Documentation: `https://developer.apple.com/documentation/arkit/creating-a-collaborative-session`

Creating 3D Content with Reality Composer | Apple Developer Documentation: `https://developer.apple.com/documentation/realitykit/creating-3d-content-with-reality-composer`

Scanning and Detecting 3D Objects | Apple Developer Documentation: `https://developer.apple.com/documentation/arkit/scanning-and-detecting-3d-objects`

Quick Look Gallery - Augmented Reality - Apple Developer: `https://developer.apple.com/augmented-reality/quick-look/`

Previewing a Model with AR Quick Look | Apple Developer Documentation: `https://developer.apple.com/documentation/arkit/previewing-a-model-with-ar-quick-look`

QuickLook | Apple Developer Documentation: `https://developer.apple.com/documentation/quicklook`

Sketchfab - Publish & find 3D models online: `https://sketchfab.com/`

# 系统学习 iOS 开发 - iOS+Swift5仿小红书实战
## 1-仿小红书实战教程简介

项目介绍、演示

**Lebus 的个人主页 - 文章 - 掘金:** `https://juejin.cn/user/3421335917428990/posts`

**M1芯片的Mac在开发iOS项目时遇到的问题汇总（模拟器无法运行，Cocoapods错误等） - 掘金:** `https://juejin.cn/post/7074968283367079972`

## 2-版本控制

**Github:** `https://github.com/`

**Git - Book:** `https://git-scm.com/book/zh/v2`

**Git教程 - 廖雪峰的官方网站:** `https://liaoxuefeng.com/books/git/introduction/index.html`

**Git - 安装命令行工具:** `https://git-scm.com/install/mac`

## 3-项目整体设计

**SF Symbols - Apple Developer:** `https://developer.apple.com/sf-symbols/`

**iOS-Xcode-重构复杂的Storyboard--Storyboard Reference:** `juejin.im/post/6844904126128750606`

**App Icon Generator:** `https://www.appicon.co/`

**Canva可画--目前字体不收费透明背景收费-一年300:** `https://www.canva.cn/`

**Figma - 由阿悦同学提供的设计网站:** `https://www.figma.com/`

**Figma Mac App(需白名单或全局代理才能访问) - 由Licardo同学提供设计类Mac客户端:** `https://figmac.com/`

**Fotor懒设计--基本都收费-有活动时三年300:** `https://www.fotor.com.cn/`

**适配深色模式（色彩+图片等）:** `https://www.fivestars.blog/articles/ios-dark-mode-how-to/`

**Dark Mode - Visual Design - iOS - Human Interface Guidelines - Apple Developer:** `https://developer.apple.com/design/human-interface-guidelines/dark-mode`

**Supporting Dark Mode in Your Interface | Apple Developer Documentation:** `https://developer.apple.com/documentation/uikit/supporting-dark-mode-in-your-interface`

**如何把 View Controller embed 进 Tab Bar Controller**

* 按住 Ctrl + 拖拽

* 右侧选项拖拽

* 全选 + 右下选项

Bar 的高度是 44 point， Custom offset -16 文字居中

**如何改变 Tab Bar Item 的顺序**

* 直接在 StoryBoard 拖拽即可

可以在 File Inspector 修改全局主题色: Global Tint （只会应用到控件上）

在 `Info.plist` 中，可以通过设置 `Appearance` 的 `Value` 为 `Light/Dark`，强制设置为 浅色/深色 模式

## 4-Cocoapods

**用UIScrollView做启动翻页 | Medium:** `https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92`

**vsouza/awesome-ios- A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects:** `https://github.com/vsouza/awesome-ios`

**xmartlabs/XLPagerTabStrip- Android PagerTabStrip for iOS.:** `https://github.com/xmartlabs/XLPagerTabStrip`

**iOS安装cocoapods时failed to build gem native extension cocoapods错误:** `https://juejin.cn/post/6898287392471318535/`

**终端HTTP代理命令 - 掘金:** `https://juejin.cn/post/6990889009798971406`

**苹果芯片M1的MacBook在pod install时的错误：ruby 2.6.3p62 [universal.arm64e-darwin20]:** `https://juejin.cn/post/6980640757199667208`

**CocoaPods Guides - 总页面:** `https://guides.cocoapods.org/`

**CocoaPods Guides - platform:** `https://guides.cocoapods.org/syntax/podfile.html#platform`

**Swift中的#available和@available--iOS、macOS等向下兼容的解决方案:** `https://juejin.cn/post/6844904090762215437`

**CocoaPods Guides - The Podfile（主要讲里面的版本号）:** `https://guides.cocoapods.org/using/the-podfile.html`

**CocoaPods Guides - Using CocoaPods（主要讲里面的Podfile.lock）:** `https://guides.cocoapods.org/using/using-cocoapods.html`

**CocoaPods Guides - pod install vs. pod update:** `https://guides.cocoapods.org/using/pod-install-vs-update.html`

**pod 常用命令**

* `pod install`: 安装包

* `pod outdated`： 列出可更新列表

* `pod update`： 更新，受 Podfile 限制

## 5-横滑Tab布局

**xmartlabs/XLPagerTabStrip- Android PagerTabStrip for iOS.:** `https://github.com/xmartlabs/XLPagerTabStrip`

**浅析collectionView的item间距 - 简书:** `https://www.jianshu.com/p/1e12a2b8f53c`

## 6-瀑布流布局

**chiahsien/CHTCollectionViewWaterfallLayout- The waterfall (i.e., Pinterest-like) layout for UICollectionView.:** `https://github.com/chiahsien/CHTCollectionViewWaterfallLayout`

## 7-本地化和国际化

**Localization - Apple Developer:** `https://developer.apple.com/localization/`

**Flinesoft/BartyCrouch- Localization/I18n- Incrementally update/translate your Strings files from .swift, .h, .m(m), .storyboard or .xib files.:** `https://github.com/Flinesoft/BartyCrouch`

**macOS 开发之 storyboard 或 xib 本地化 - 知乎:** `https://zhuanlan.zhihu.com/p/57117270`

添加支持的语言和区域（目的: ）

* 让某些系统空间或权限弹框自动本地化

* 本地化操作的第一步

`Project -- info -- Localizations -- Add -- Finish`

 命令行导出本地化文件: `genstrings -o zh-Hans.lproj path/*.swift`

 App 名称本地化: 创建 InfoPlist.strings, 添加语言，设置 `CFBundleDisplayName = "xxx";`

 图片 本地化: 打开 Assets.scassets, 选择图片 -- `Show the Attributes Inspector` -- `Localization`

 ## 8-选取照片和视频

 **Yummypets/YPImagePicker- 📸 Instagram-like image picker & filters for iOS:** `https://github.com/Yummypets/YPImagePicker`

 **申请访问照片的权限| Apple Developer Documentation:** `https://developer.apple.com/documentation/photokit/delivering-an-enhanced-privacy-experience-in-your-photos-app`

 ## 9-Swift高级

 **闭包Closures - Swift官方文档:** `https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/`

 **閉包(Closures) | 彼得潘的 Swift iOS App 開發教室 | Medium:** `https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/%E7%B0%A1%E6%98%93%E8%AA%AA%E6%98%8Eswift-4-closures-77351c3bf775`

 **ARC和循环引用 - Swift官方文档:** `https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/`

 **枚举 - Swift官方文档:** `https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/`

 ## 10-CollectionView

 **iOS13-Xcode11-UIScrollView的新功能-在storyboard上即可设置ContentSize-更高效的布局:** `https://juejin.cn/post/6844904133040979976`

 **真机调试时iPhone解锁后Xcode仍出现“Unlock iPhone to Continue”弹框 的解决方案:** `https://juejin.cn/post/6844904012949487623`

 **给tableview的每个section添加Headers和Footers  | Apple官方文档:** `https://developer.apple.com/documentation/uikit/adding-headers-and-footers-to-table-sections`

 **UICollectionView | Apple官方文档:** `https://developer.apple.com/documentation/uikit/uicollectionview`

 **第三方透明指示器MBProgressHUD使用详解:** `https://www.hangge.com/blog/cache/detail_2031.html`

 **Importing Objective-C into Swift | Apple官方文档:** `https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_objective-c_into_swift`

 **jdg/MBProgressHUD - 加载进度框/提示框/指示器:** `https://github.com/jdg/MBProgressHUD`

 **suzuki-0000/SKPhotoBrowser- 图片浏览器:** `https://github.com/suzuki-0000/SKPhotoBrowser`

 **AVPlayer和AVPlayerViewController的使用:** `https://www.hangge.com/blog/cache/detail_1107.html`

 **Supporting Drag and Drop in Collection Views | Apple官方文档:** `https://developer.apple.com/documentation/uikit/supporting-drag-and-drop-in-collection-views`

 ## 11-UITextField

 **UITextField | Apple官方文档:** `https://developer.apple.com/documentation/uikit/uitextfield`

 **UIControl.Event | Apple官方文档:** `https://developer.apple.com/documentation/uikit/uicontrol/event`

 **UITextView | Apple官方文档:** `https://developer.apple.com/documentation/uikit/uitextview`

 **MoZhouqi/KMPlaceholderTextView - 给textview加placeholder:** `https://github.com/MoZhouqi/KMPlaceholderTextView`

 **lineHeightMultiple和lineSpacing的区别 - Stack Overflow:** `https://stackoverflow.com/questions/48793470/when-should-you-use-lineheightmultiple-vs-linespacing`

 ## 12-参与话题功能
 
 ## 13-高德地图SDK

 **高德开放平台 | 高德地图API:** `https://lbs.amap.com/`

 **IDFA是什么 - 知乎:** `https://www.zhihu.com/question/38856446`

 **该选择哪种位置权限 | Apple官方文档:** `https://developer.apple.com/documentation/corelocation/choosing_the_location_services_authorization_to_request`

 **请求位置权限 | Apple官方文档:** `https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services`

 **什么是逆地理编码？ - 知乎:** `https://zhuanlan.zhihu.com/p/30887917`

 **重要： SDK合规使用方案 | 高德地图API:** `https://lbs.amap.com/compliance-center/check-and-reference/sdkhgsy`

 **M1的MacBook在集成了高德SDK后无法在模拟器上运行的解决方案:** `https://juejin.cn/post/6920218654013407246`

 **POI和AOI - 知乎:** `https://zhuanlan.zhihu.com/p/111256406`

 **requestWhenInUseAuthorization() | Apple官方文档:** `https://developer.apple.com/documentation/corelocation/cllocationmanager/1620562-requestwheninuseauthorization`

 **高德海外LBS解决方案 | 高德地图API:** `https://lbs.amap.com/solution/abroad`

 **CoderMJLee/MJRefresh- An easy way to use pull-to-refresh.:** `https://github.com/CoderMJLee/MJRefresh`

 **Swift - MJRefresh库的使用详解1（配置，及库自带的下拉刷新组件） - 云+社区 - 腾讯云:** `https://cloud.tencent.com/developer/article/1330735`

 **M芯片电脑加载高德地图后模拟器会遇到报错:**

 ```swift
the specified architecture 'arm64-*-*' is not compatible with 'x86_64-apple-ios14.1.0-simulator' in...

解决方式: 模拟器换成 Rosetta 后缀
 ```

 **查找 searchBar 中 cancelButton 的方法**
 ```swift
if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
    cancelButton .isEnabled = true
}
 ```

 ## 14-本地存储CoreData

 **CoreData中以KVC方式的CRUD(仅参考)  | Medium:** `https://medium.com/@aliakhtar_16369/mastering-in-coredata-part-3-coding-crud-in-core-data-b7a278436c3`

 **NSHomeDirectory() | Apple官方文档:** `https://developer.apple.com/documentation/foundation/1413045-nshomedirectory`

 **NSSearchPathForDirectoriesInDomains(_-_-_-) | Apple官方文档:** `https://developer.apple.com/documentation/foundation/nssearchpathfordirectoriesindomains(_:_:_:)`

 **urls(for-in-) | Apple官方文档:** `https://developer.apple.com/documentation/foundation/filemanager/urls(for:in:)`

 **DB Browser for SQLite - 需开启白名单或全局代理:** `https://sqlitebrowser.org/dl/`

 **轻量迁移 | Apple官方文档:** `https://developer.apple.com/documentation/coredata/migrating-your-data-model-automatically`

 **Date转化为String-DateFormatter:** `https://juejin.cn/post/6844903841855438862`

 **GitHub - MatthewYork/DateTools- Dates and times made easy in iOS:** `https://github.com/MatthewYork/DateTools`

 ## 15-本机号码一键登录

 **一键登录了解一下？:** `https://juejin.cn/post/6844903877733515277`

 **极光认证 - 极光文档:** `https://docs.jiguang.cn/jverification/guideline/intro`

 **开发助手简介 - 支付宝开放平台:** `https://opendocs.alipay.com/open/291/introduce`

 **理解公钥与私钥 | 神奕的博客:** `https://songlee24.github.io/2015/05/03/public-key-and-private-key/`

 **在线RSA加密解密,RSA2加密解密(SHA256WithRSA)-BeJSON.com:** `https://www.bejson.com/enc/rsa/`

 **REST 架构该怎么生动地理解？ - 知乎:** `https://www.zhihu.com/question/27785028`

 **GitHub - Alamofire/Alamofire- Elegant HTTP Networking in Swift:** `https://github.com/Alamofire/Alamofire`

 ## 16-支付宝登录

 **视觉资源下载 - 支付宝开放平台:** `https://opendocs.alipay.com/open/54/103284`

 **整合各类第三方登录的服务商-友盟:** `https://www.umeng.com/u-verify?spm=a213m0.13887608.0.0.3cb275efO6YUQR&acm=lb-zebra-577134-7502775.1003.4.6889757&scm=1003.4.lb-zebra-577134-7502775.OTHER_15820732724753_6889757`

 **整合各类第三方登录的服务商-ShareSDK:** `https://mob.com/mobService/sharesdk`

 **支付宝开放平台:** `https://open.alipay.com/`

 **URL Schemes 使用详解 - 少数派:** `https://sspai.com/post/31500`

 ## 17-苹果登录

 **Apple Design Resources - Apple官方文档 - 注意图片有内间距:** `https://developer.apple.com/design/resources/`

 **Sign in with Apple - Apple官方文档:** `https://developer.apple.com/sign-in-with-apple/`

 **Authentication Services | Apple官方文档:** `https://developer.apple.com/documentation/authenticationservices`

 **JSON Web Tokens - jwt.io:** `https://www.jwt.io/`

 ## 18-手机验证码登录

 **LeanCloud:** `https://www.leancloud.cn/`

 **正则表达式 – 教程 | 菜鸟教程:** `https://www.runoob.com/regexp/regexp-tutorial.html`

 **TinyPNG – 压缩PNG图片的同时保留透明度:** `https://tinify.cn/`

 ## 19-登录和退出登录

 **前端应该知道的web登录 - 知乎:** `https://zhuanlan.zhihu.com/p/62336927`

 **#if和#endif — Swift 官方文档:** `https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/`

 ## 20-发布笔记至云端

 **Orderella/PopupDialog- A simple, customizable popup dialog for iOS written in Swift. Replaces UIAlertController alert style.:** `https://github.com/Orderella/PopupDialog`

 **huri000/SwiftEntryKit- SwiftEntryKit is a presentation library for iOS. It can be used to easily display overlays within your iOS apps.:** `https://github.com/huri000/SwiftEntryKit`

 ## 21-笔记详情页UI

 **Adding Headers and Footers to Table Sections | Apple Developer Documentation:** `https://developer.apple.com/documentation/uikit/adding-headers-and-footers-to-table-sections`

 **janselv/fave-button- FaveButton is an iOS cute animated like button written in Swift.:** `https://github.com/janselv/fave-button`

 **zvonicek/ImageSlideshow- Swift image slideshow with circular scrolling, timer and full screen viewer:** `https://github.com/zvonicek/ImageSlideshow`

 ## 22-从云端取出笔记

 **GitHub - onevcat/Kingfisher- A lightweight, pure-Swift library for downloading and caching images from the web.:** `https://github.com/onevcat/Kingfisher`

 **Kingfisher的基本使用 - 简书:** `https://www.jianshu.com/p/e025cec4197a`

 ## 23-点赞和收藏

 **给老婆讲懂数据库系列之原子性Atomicity – Mars的笔记 – Software Developer@PingCAP:** `https://marsishandsome.github.io/2019/04/%E7%BB%99%E8%80%81%E5%A9%86%E8%AE%B2%E6%87%82%E6%95%B0%E6%8D%AE%E5%BA%93%E7%B3%BB%E5%88%97%E4%B9%8B%E5%8E%9F%E5%AD%90%E6%80%A7Atomicity`

 ## 24-笔记的删除和编辑

 ## 25-笔记的评论

 **GitHub - KennethTsang/GrowingTextView- An UITextView in Swift. Support auto growing, placeholder and length limit.:** `https://github.com/KennethTsang/GrowingTextView`

 **iOS13-Swift5-UIScrollView中的keyboard适配-如何在弹出软键盘时把view向上移动键盘的高度:** `https://juejin.cn/post/6844904134093570056`

 **Adding Headers and Footers to Table Sections | 苹果官方文档:** `https://developer.apple.com/documentation/uikit/adding-headers-and-footers-to-table-sections`

 **estimatedSectionHeaderHeight | 苹果官方文档:** `https://developer.apple.com/documentation/uikit/uitableview/estimatedsectionheaderheight`

 **iOS13-Swift5富文本NSAttributedString和NSMutableAttributedString的使用:** `https://juejin.cn/post/6844904196358012936/`

 **Swift - UIPasteboard剪贴板的使用详解（复制、粘贴文字和图片）:** `https://www.hangge.com/blog/cache/detail_1085.html`

 ## 26-笔记评论的回复

 ## 27-笔记详情页的优化及bug处理

 ## 28-个人页面

 **多层 UIScrollView 嵌套滚动解决方案:** `https://juejin.cn/post/6844903776130695175`

 **GitHub - Jiar/SegementSlide- Multi-tier UIScrollView nested scrolling solution. 😋😋😋:** `https://github.com/Jiar/SegementSlide`

 ## 29-编辑资料

 **GitHub - skywinder/ActionSheetPicker-3.0- Quickly reproduce the dropdown UIPickerView / ActionSheet functionality on iOS.:** `https://github.com/skywinder/ActionSheetPicker-3.0`

 ## 30-个人设置

 **iOS-Swift5.1-用代码动态实现页面跳转（performSegue）的用法:** `https://juejin.cn/post/6844903928979521543`

 ## 31-推送

 **UIAlertController 教程：讓你輕鬆在 UIViewController 以外的地方呈現警告:** `https://www.appcoda.com.tw/uialertcontroller/`

 **Generating a Remote Notification | Apple Developer Documentation:** `https://developer.apple.com/documentation/usernotifications/generating-a-remote-notification`

 ## 32-转场动画

 **GitHub - HeroTransitions/Hero- Elegant transition library for iOS & tvOS:** `https://github.com/HeroTransitions/Hero`

 ## 33-内测

 **蒲公英-免费的苹果ios应用app内测分发托管|android安卓app内测分发托管:** `https://www.pgyer.com/`

 **分发您的 App 进行 Beta 测试和发布 - 简体中文文档 - Apple Developer:** `https://developer.apple.com/cn/documentation/xcode/distributing_your_app_for_beta_testing_and_releases/`