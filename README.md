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


机器学习的分类:

1. 有监督学习--准确，但费时间
给机器一个对应关系（指着桌上的手机--告诉机器它叫手机） ---训练（给训练数据贴标签label）
指着桌上的手机问机器它是什么 ---输入input
告诉我们它是手机 ---输出output

2. 无监督学习
不给出对应关系，只是仍一堆东西给机器，机器最终只能辨别出哪些东西属于一类，哪些不是一类，仅此而已。

3. 半监督学习

4. 增强学习
