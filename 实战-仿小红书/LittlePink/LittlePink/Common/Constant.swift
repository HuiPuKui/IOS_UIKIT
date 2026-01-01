//
//  Constant.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/5.
//

import UIKit

// MARK: storyboardID
let kFollowVCID = "FollowVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kNearByVCID = "NearByVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"
let kChannelTableVCID = "ChannelTableVCID"
let kLoginNaviID = "LoginNaviID"
let kLoginVCID = "LoginVCID"
let kMeVCID = "MeVCID"

// MARK: Cell相关ID
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"

// MARK: - 资源文件相关
let mainColor = UIColor(named: "main")!
let mainLightColor = UIColor(named: "main-light")!
let blueColor = UIColor(named: "blue")!
let imagePH = UIImage(named: "imagePH")!

// MARK: - UserDefaults 的 Key
let kNameFromAppleID = "nameFromAppleID"
let kEmailFromAppleID = "emailFromAppleID"

// MARK: - CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext()

// MARK: - UI 布局
let screenRect = UIScreen.main.bounds

// MARK: - 业务逻辑相关
// 瀑布流
let kWaterfallPadding: CGFloat = 4
let kDraftNoteWaterfallCellBottomViewH: CGFloat = 84

let kChannels = ["推荐", "旅行", "娱乐", "才艺", "美妆", "白富美", "美食", "萌宠"]

// YPImagePicker
let kMaxPhotoCount = 9
let kMinPhotoCount = 1
let kNumberOfPhotosInRow = 4
let kSpacingBetweenPhotos = 2.0
let kMaxCameraZoomFactor = 5.0

// 笔记
let kMaxNoteTitleCount = 20
let kMaxNoteTextCount = 1000

// 话题
let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]

// 高德
let kAMapApiKey = "03dcda3dbeaadc4d5f33673f977dda69"
let kNoPOIPH = "未知地点"
let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOIsInitArr = [["不显示位置", ""]]
let kPOIsOffset = 20

// 极光
let kJAppKey = "bae0208e3c6af1ab8eaa9a32"

// 支付宝
let kAliPayAppID = "2021002125697028"
let kAliPayPID = "2088002401295380"
let kAlipayPrivateKey = "支付宝后台上传的公钥对应的私钥"
let kAppScheme = "LittlePink"


// 正则表达式
let kPhoneRegEx = "^1\\d{10}$"
let kAuthCodeRegEx = "^\\d{6}$"

// MARK: - LeanCloud
// 配置相关
let kLCAppID = "1Vm29vO6ghufiv5tLwcPJ2Bv-gzGzoHsz"
let kLCAppKey = "Y2x0cYI7xX9snaAKVxDc7c0F"
let kLCServerURL = "https://1vm29vo6.lc-cn-n1-shared.com"

// User 表
let kNickNameCol = "nickName"
let kAvatarCol = "avatar"
let kGenderCol = "gender"
let kIntroCol = "intro"
