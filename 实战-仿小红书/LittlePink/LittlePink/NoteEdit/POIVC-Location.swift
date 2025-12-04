//
//  POIVC-Location.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/2.
//

import Foundation

extension POIVC {
    
    func requestLocation() {
        // MARK: - 定位
        
        self.showLoadHUD()
        
        self.locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                } else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                } else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let POIVC = self else { return }

            if let location = location {
                print("location:", location)
                POIVC.latitude = location.coordinate.latitude
                POIVC.longitude = location.coordinate.longitude
                
                // MARK: 检索周边 POI
                POIVC.footer.setRefreshingTarget(POIVC, refreshingAction: #selector(POIVC.aroundSearchPullToRefresh))
                POIVC.makeAroundSearch()
            }
            
            if let reGeocode = reGeocode {
                
                print("reGeocode:", reGeocode)
                
                //几个常用场景的说明:
                //1.直辖市的province和city是一样的
                //2.偏远乡镇的street等小范围的东西都可能是nil
                //3.用户在海上或海外,若未开通‘海外LBS服务’,则都返回nil
                
                guard
                    let formattedAddress = reGeocode.formattedAddress,
                    !formattedAddress.isEmpty
                else {
                    return
                }
                
                let province = (reGeocode.province == reGeocode.city) ? "" : reGeocode.province
                let currentPOI = [
                    reGeocode.poiName ?? kNoPOIPH,
                    "\(province.unwrappedText)\(reGeocode.city.unwrappedText)\(reGeocode.district.unwrappedText)\(reGeocode.street.unwrappedText)\(reGeocode.number.unwrappedText)"
                ]
                
                POIVC.pois.append(currentPOI)
                POIVC.aroundSearchedPOIs.append(currentPOI)
                
                DispatchQueue.main.async {
                    POIVC.tableView.reloadData()
                }
            }
        })
    }
    
}

// MARK: - 一般函数

extension POIVC {
        
    func makeAroundSearch(_ page: Int = 1) {
        self.aroundSearchRequest.page = page
        self.mapSearch?.aMapPOIAroundSearch(self.aroundSearchRequest)
    }
    
}

// MARK: - 监听

extension POIVC {
    
    @objc private func aroundSearchPullToRefresh() {
        self.currentAroundPage += 1
        self.makeAroundSearch(self.currentAroundPage)
    }
    
}
