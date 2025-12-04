//
//  POIVC-Config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/2.
//

import Foundation

extension POIVC {
    
    func config() {
        // 定位
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationTimeout = 5
        self.locationManager.reGeocodeTimeout = 5
        
        self.mapSearch?.delegate = self
        
        self.tableView.mj_footer = self.footer
    }
    
}
