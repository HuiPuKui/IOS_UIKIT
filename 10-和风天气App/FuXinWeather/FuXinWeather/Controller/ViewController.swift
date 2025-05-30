//
//  ViewController.swift
//  FuXinWeather
//
//  Created by 惠蒲葵 on 2025/5/18.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

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

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        /*
        if segue.identifier == "QueryViewControllerSegue" {
            // 传值给下一个页面
            let vc: QueryViewController = segue.destination as! QueryViewController
            vc.currentCity = self.weather.city
        }
         */
        
        if let vc: QueryViewController = segue.destination as? QueryViewController {
            vc.currentCity = self.weather.city
            vc.delegate = self
        }
    }
}

