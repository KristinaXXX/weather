//
//  WeatherCoordinator.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import UIKit

protocol WeatherCoordinatorProtocol {
    func weatherNowUpdated()
    func showError(_ text: String)

}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    func weatherNowUpdated() {
        
    }
    
    
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
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
