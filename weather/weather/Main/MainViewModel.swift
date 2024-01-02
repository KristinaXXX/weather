//
//  MainViewModel.swift
//  weather
//
//  Created by Kr Qqq on 19.12.2023.
//

import Foundation
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func updatePages()
    func updateTitleCurrentPage(title: String)
}

class MainViewModel {
    
    private var coordinator: WeatherCoordinatorProtocol
    private var locations: [CoordRealm] = []
    weak var mainViewControllerDelegate: MainViewControllerDelegate?
    private let locationService: LocationService
    
    init(coordinator: WeatherCoordinatorProtocol, locationService: LocationService) {
        self.coordinator = coordinator
        self.locationService = locationService
        self.coordinator.mainViewModelDelegate = self        
        updateLocations()
    }
    
    public func updateLocations() {
        locations = DownloadSaveService.takeLocations()
        if let nowCoordRealm = locationService.nowLocation() {
            locations.insert(nowCoordRealm, at: 0)
        }
    }
    
    func takeLocation(at index: Int) -> CoordRealm {
        return locations[index]
    }
    
    func createPages() -> [UIViewController] {
        coordinator.createForecasts(locations: locations)
    }
    
    func showMap() {
        coordinator.showMap()
    }
    
    func showSettings() {
        coordinator.showSettings()
    }
}

extension MainViewModel: MainViewModelDelegate {
    func updatePages() {
        updateLocations()
        mainViewControllerDelegate?.updatePages()
    }
    
    func updateTitleCurrentPage(title: String) {
        mainViewControllerDelegate?.updateTitleCurrentPage(title: title)
    }
}
