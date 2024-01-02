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
    func createForecastsDays(location: CoordRealm, days: [Date]) -> [DailyForecastViewController]
    func addLocationRequest(cityName: String, completion: @escaping ((_:UIAlertAction) -> Void))
    func showMap()
    func showSettings()
    func closeTopViewController()
    func updatePages()
    func showDetails(location: CoordRealm)
    func showDailyPages(location: CoordRealm, selectedDay: Date)
}

final class WeatherCoordinator: WeatherCoordinatorProtocol {
    
    private weak var navigationController: UINavigationController?
    weak var mainViewModelDelegate: MainViewModelDelegate?
    private let settingsService = SettingsService()
    //private let locationService = LocationService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startApplication() {
        showMainPage()
        if !settingsService.getDeterminedPermissionLocation() && LocationService.shared.authorizationStatus() == .notDetermined {
            showLocationPermission()
        }
    }
    
    private func showLocationPermission() {
        settingsService.updateDeterminedPermissionLocation(value: true)
        let controller = Builder.buildLocationPermissionViewController { [weak self] permission in
            if permission {
                LocationService.shared.requestAuthorization()
                self?.mainViewModelDelegate?.updatePages()
            }
            self?.navigationController?.popViewController(animated: false)
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
    
    func createForecastsDays(location: CoordRealm, days: [Date]) -> [DailyForecastViewController] {
        var result: [DailyForecastViewController] = []
        for item in days {
            let controller = Builder.buildDailyForecastViewController(coordinator: self, location: location, date: item)
            guard let dailyForecastViewController = controller as? DailyForecastViewController else { continue }
            result.append(dailyForecastViewController)
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
    
    func showSettings() {
        let controller = Builder.buildSettingsViewController(coordinator: self)
       // navigationController?.pushViewController(controller, animated: true)
        navigationController?.present(controller, animated: true)
    }
    
    func closeTopViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func updatePages() {
        mainViewModelDelegate?.updatePages()        
    }
    
    func weatherNowUpdated() {
        
    }
    
    func showDetails(location: CoordRealm) {
        let controller = Builder.buildDetailsViewController(coordinator: self, location: location)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showDailyPages(location: CoordRealm, selectedDay: Date) {
        let controller = Builder.buildDailyPagesViewController(coordinator: self, location: location, selectedDay: selectedDay)
        navigationController?.pushViewController(controller, animated: true)
    }
}
