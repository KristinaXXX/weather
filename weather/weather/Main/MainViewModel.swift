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
}

class MainViewModel {
    
    private var coordinator: WeatherCoordinatorProtocol
    private var locations: [CoordRealm] = []
    weak var mainViewControllerDelegate: MainViewControllerDelegate?
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
        self.coordinator.mainViewModelDelegate = self
        updateLocations()
    }
    
    public func updateLocations() {
        locations = DownloadSaveService.takeLocations()
        if let nowCoordRealm = LocationService.shared.nowLocation() {
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
}

extension MainViewModel: MainViewModelDelegate {
    func updatePages() {
        updateLocations()
        mainViewControllerDelegate?.updatePages()
    }
}
