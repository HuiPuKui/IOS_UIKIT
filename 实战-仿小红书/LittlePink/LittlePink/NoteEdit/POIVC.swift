//
//  POIVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/30.
//

import UIKit

class POIVC: UIViewController {

    private let locationManager = AMapLocationManager()
    private var pois = [["不显示位置", ""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationTimeout = 5
        self.locationManager.reGeocodeTimeout = 5
        
        self.locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                } else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                } else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let POIVC = self else { return }

            if let location = location {
                print("location:", location)
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
                
                let province = (reGeocode.province == reGeocode.city) ? "" : reGeocode.province!
                let currentPOI = [
                    reGeocode.poiName!,
                    "\(province)\(reGeocode.city ?? "")\(reGeocode.district ?? "")\(reGeocode.street ?? "")\(reGeocode.number ?? "")"
                ]
                POIVC.pois.append(currentPOI)
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension POIVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath)
        return cell
    }
    
}
//
//extension POIVC: UITableViewDelegate {
//    
//}
