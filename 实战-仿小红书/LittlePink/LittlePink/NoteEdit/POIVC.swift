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
    
    // 搜索周边 POI 请求
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(
            withLatitude: CGFloat(self.latitude),
            longitude: CGFloat(self.longitude)
        )
        request.types = kPOITypes
        request.showFieldsType = .all
        return request
    }()
    
    // 搜索关键字请求
    lazy var keywordsSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.types = kPOITypes
        request.showFieldsType = .all
        return request
    }()
    
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var keywords: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.requestLocation()
        
        self.mapSearch?.delegate = self
    }

}

extension POIVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.pois = self.aroundSearchedPOIs
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        self.keywords = searchText
        self.pois.removeAll()
        self.showLoadHUD()
        self.keywordsSearchRequest.keywords = self.keywords
        self.mapSearch?.aMapPOIKeywordsSearch(self.keywordsSearchRequest)
    }
    
}

// MARK: - 所有搜索 POI 的回调 - AMapSearchDelegate

extension POIVC: AMapSearchDelegate {
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        self.hideLoadHUD()
        
        print(response.count)
        
        if response.count == 0 {
            return
        }
        
        for poi in response.pois {
            let province = (poi.province == poi.city) ? "" : poi.province
            let address = (poi.district == poi.address) ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"
            ]
            
            self.pois.append(poi)
            
            if request is AMapPOIAroundSearchRequest {
                self.aroundSearchedPOIs.append(poi)
            }
        }
        
        self.tableView.reloadData()
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
