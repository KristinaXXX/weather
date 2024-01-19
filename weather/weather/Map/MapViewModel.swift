//
//  MapViewModel.swift
//  weather
//
//  Created by Kr Qqq on 19.12.2023.
//

import Foundation

class MapViewModel {
    
    private let coordinator: WeatherCoordinatorProtocol
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    public func addLocation(lat: Double, lon: Double, cityName: String) {
        coordinator.addLocationRequest(cityName: cityName) { [weak self] _ in
            _ = DownloadSaveService.takeCoord(lat: lat, lon: lon, cityName: cityName, userAdd: true)
            self?.coordinator.updatePages()
            self?.coordinator.closeTopViewController()
        }
    }
}
