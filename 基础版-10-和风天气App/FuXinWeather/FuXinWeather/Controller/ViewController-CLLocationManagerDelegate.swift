//
//  ViewController-CLLocationManagerDelegate.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/22.
//

import Alamofire
import SwiftyJSON
import Foundation
import CoreLocation

// 扩展
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon: CLLocationDegrees = locations[0].coordinate.longitude // 经度
        let lat: CLLocationDegrees = locations[0].coordinate.latitude // 纬度
        print(lon)
        print(lat)

        AF.request(kQWeatherNowPath, parameters: self.getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value {
                let weatherJson: JSON = JSON(data)
                self.showWeather(weatherJson)
            }
        }
        
        AF.request(kQWeatherCityPath, parameters: self.getParameters("\(lon),\(lat)")).responseJSON { response in
            if let data = response.value {
                let cityJSON: JSON = JSON(data)
                self.showCity(cityJSON)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
        self.cityLabel.text = "获取位置失败"
    }
}
