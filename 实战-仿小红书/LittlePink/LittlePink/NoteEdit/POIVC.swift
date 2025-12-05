//
//  POIVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/30.
//

import UIKit

class POIVC: UIViewController {
    
    var delegate: POIVCDelegate?

    lazy var locationManager = AMapLocationManager()
    lazy var mapSearch = AMapSearchAPI()
    
    // 搜索周边 POI 请求
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(
            withLatitude: CGFloat(self.latitude),
            longitude: CGFloat(self.longitude)
        )
        request.types = kPOITypes
        request.showFieldsType = .all
        request.offset = kPOIsOffset
        return request
    }()
    
    // 搜索关键字请求
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.types = kPOITypes
        request.showFieldsType = .all
        request.offset = kPOIsOffset
        return request
    }()
    
    lazy var footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter()
    
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var keywords: String = ""
    var currentAroundPage = 1
    var currentKeywordsPage = 1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.requestLocation()
    }

}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension POIVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        
        self.delegate?.updatePOIName(self.pois[indexPath.row][0])
        
        dismiss(animated: true)
    }
    
}
