//
//  ViewController.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/18.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

// delegate -- 代理/委托
// protocol -- 协议（optional 可选实现）

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    let locationManager: CLLocationManager = CLLocationManager()
    let weather: Weather = Weather()
    
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
        let lon: CLLocationDegrees = locations[0].coordinate.longitude // 经度
        let lat: CLLocationDegrees = locations[0].coordinate.latitude // 纬度
        print(lon)
        print(lat)

        AF.request("https://ny2tumxw93.re.qweatherapi.com/v7/weather/now?location=\(lon),\(lat)&key=e6499bcc50c6463abe0f972b897e2822").responseJSON { response in
            if let data = response.value {
                let weatherJson: JSON = JSON(data)
                
                self.weather.temp = "\(weatherJson["now", "temp"].stringValue)˚"
                self.weather.icon = "\(weatherJson["now", "icon"].stringValue)"
                
                self.tempLabel.text = self.weather.temp
                self.iconImageView.image = UIImage(named: self.weather.icon)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

