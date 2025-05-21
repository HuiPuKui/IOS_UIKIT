//
//  ViewController-Helper.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/22.
//

import SwiftyJSON
import Foundation

extension ViewController {
    
    func showWeather(_ weatherJson: JSON) -> Void {
        // 数据
        self.weather.temp = "\(weatherJson["now", "temp"].stringValue)˚"
        self.weather.icon = "\(weatherJson["now", "icon"].stringValue)"
        
        // UI
        self.tempLabel.text = self.weather.temp
        self.iconImageView.image = UIImage(named: self.weather.icon)
    }
    
    func showCity(_ cityJSON: JSON) -> Void {
        // 数据
        self.weather.city = cityJSON["location", 0, "name"].stringValue
        
        // UI
        self.cityLabel.text = self.weather.city
    }
    
    func getParameters(_ location: String) -> [String: String] {
        return ["location": location, "key": kQWeatherWebKey]
    }
    
}
