import UIKit
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("""
                ARKit在此设备上不可用。
                1.在AR为核心功能的应用程序中，请在Info.plist的“UIRequiredDeviceCapabilities”键中使用“arkit”键，以阻止不支持的设备安装该应用程序。
                （如果无法安装该应用程序，则不会在生产场景中触发此错误。）
                2.在AR为附加功能的应用程序中，请在程序中使用“ isSupported”来确定是否显示用于启动AR体验的UI。
                """)
        }

        return true
    }
}
