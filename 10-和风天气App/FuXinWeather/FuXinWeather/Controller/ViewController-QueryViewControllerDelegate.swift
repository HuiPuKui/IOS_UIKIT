//
//  ViewController-QueryViewControllerDelegate.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/22.
//

import Alamofire
import SwiftyJSON
import Foundation

extension ViewController: QueryViewControllerDelegate {
    
    // MARK: - QueryViewControllerDelegate
    
    func didChangeCity(city: String) {
        AF.request(kQWeatherCityPath, parameters: self.getParameters(city)).responseJSON { response in
            if let data = response.value {
                let cityJSON: JSON = JSON(data)
                self.showCity(cityJSON)
                
                let cityID: String = cityJSON["location", 0, "id"].stringValue
                AF.request(kQWeatherNowPath, parameters: self.getParameters(cityID)).responseJSON { response in
                    if let data = response.value {
                        let weatherJson: JSON = JSON(data)
                        self.showWeather(weatherJson)
                    }
                }
            }
        }
    }
}
