import UIKit
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //人脸和世界追踪为本项目的主要功能，若软硬件不支持(iOS13+前置原深感相机)的话则显示‘设备不支持’页面
        
        if !ARWorldTrackingConfiguration.supportsUserFaceTracking {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "unsupportedDeviceMessage")
        }
        return true
    }
}

