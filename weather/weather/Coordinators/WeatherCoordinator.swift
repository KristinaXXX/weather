//
//  WeatherCoordinator.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import UIKit

protocol WeatherCoordinatorProtocol {
    var mainViewModelDelegate: MainViewModelDelegate? { get set }
    func weatherNowUpdated()
    func showError(_ text: String)
    func createForecasts(locations: [CoordRealm]) -> [UIViewController]
    func addLocationRequest(cityName: String, completion: @escaping ((_:UIAlertAction) -> Void))
    func showMap()
    func closeTopViewController()
    func updatePages()
}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    weak var mainViewModelDelegate: MainViewModelDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startApplication() {
        showMainPage()
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
    
    func showMainPage() {
        let controller = Builder.buildMainViewController(coordinator: self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func createForecasts(locations: [CoordRealm]) -> [UIViewController] {
        var result: [UIViewController] = []
        for item in locations {
            let controller = Builder.buildForecastViewController(coordinator: self, location: item)
            guard let forecastViewController = controller as? ForecastViewController else { continue }
            result.append(forecastViewController)
        }
        
        if result.isEmpty {
            let controller = Builder.buildAddLocationInfoViewController(coordinator: self)
            result.append(controller)
        }
        return result
    }
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func addLocationRequest(cityName: String, completion: @escaping ((_:UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "Добавить '\(cityName)' в список городов?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: completion))
        navigationController?.present(alert, animated: true)
    }
    
    func showMap() {
        let controller = Builder.buildMapViewController(coordinator: self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func closeTopViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func updatePages() {
        mainViewModelDelegate?.updatePages()        
    }
    
    func weatherNowUpdated() {
        
    }
}
