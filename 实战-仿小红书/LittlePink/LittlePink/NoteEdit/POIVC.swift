//
//  POIVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/30.
//

import UIKit

class POIVC: UIViewController {

    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(
            withLatitude: CGFloat(self.latitude),
            longitude: CGFloat(self.longitude)
        )
        return request
    }()
    
    var pois = [["不显示位置", ""]]
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.requestLocation()
        
        self.mapSearch?.delegate = self
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

extension POIVC: AMapSearchDelegate {
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0 {
            return
        }
        
        for poi in response.pois {
            let province = (poi.province == poi.city) ? "" : poi.province!
            let address = (poi.district == poi.address) ? "" : poi.address!
            
            let poi = [
                poi.name,
                "\(province)\(poi.city!)\(poi.district!)\(address)"
            ]
        }
    }
    
}

extension POIVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        
        let poi = self.pois[indexPath.row]
        cell.poi = poi
        
        return cell
    }
    
}
//
//extension POIVC: UITableViewDelegate {
//    
//}
