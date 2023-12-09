//
//  WeatherCoordinator.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import UIKit

protocol WeatherCoordinatorProtocol {

}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startApplication() {
        showForecast()
        if LocationService.shared.authorizationStatus() == .notDetermined {
            showLocationPermission()
        }
    }
    
    private func showLocationPermission() {
        let controller = Builder.buildLocationPermissionViewController { permission in
            if permission {
                LocationService.shared.requestAuthorization()
            }
            self.navigationController?.popViewController(animated: false)
        }
        navigationController?.pushViewController(controller, animated: false)
    }
    
    private func showForecast() {
        let controller = Builder.buildForecastViewController(coordinator: self)
        navigationController?.pushViewController(controller, animated: true)
    }
}
