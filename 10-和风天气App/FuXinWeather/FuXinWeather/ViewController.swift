//
//  ViewController.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/18.
//

import UIKit
import CoreLocation

// delegate -- 代理/委托
// protocol -- 协议（optional 可选实现）

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 请求授权获取当前位置
        self.locationManager.requestWhenInUseAuthorization()
        
        // 设置代理为当前类
        self.locationManager.delegate = self;
        
        // 设置请求精度为三千米
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

