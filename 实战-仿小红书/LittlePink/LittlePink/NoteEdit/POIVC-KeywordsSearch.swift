//
//  POIVC-KeywordsSearch.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/5.
//

// MARK: - UISearchBarDelegate

extension POIVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.pois = self.aroundSearchedPOIs
            self.setAroundSearchFooter()
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        self.keywords = searchText
        
        self.pois.removeAll()
        self.currentKeywordsPage = 1
        
        self.setKeywordsSearchFooter()
        
        self.showLoadHUD()
        self.makeKeywordsSearch(self.keywords)
    }
    
}

// MARK: - 所有搜索 POI 的回调 - AMapSearchDelegate

extension POIVC: AMapSearchDelegate {
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        self.hideLoadHUD()
        
        if response.count == 0 {
            self.footer.endRefreshingWithNoMoreData()
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
        
        self.footer.endRefreshing()
        
        self.tableView.reloadData()
    }
    
}

extension POIVC {
    
    private func makeKeywordsSearch(_ keywords: String, _ page: Int = 1) {
        self.keywordsSearchRequest.keywords = keywords
        self.keywordsSearchRequest.page = page
        self.mapSearch?.aMapPOIKeywordsSearch(self.keywordsSearchRequest)
    }
    
    private func setKeywordsSearchFooter() {
        self.footer.resetNoMoreData()
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
    
}

extension POIVC {
    
    @objc private func keywordsSearchPullToRefresh() {
        self.currentKeywordsPage += 1
        self.makeKeywordsSearch(self.keywords, self.currentKeywordsPage)
    }
    
}
