//
//  Builder.swift
//  weather
//
//  Created by Kr Qqq on 01.12.2023.
//

import UIKit

final class Builder {
    
    static func addNavigationController(to viewController: UIViewController, with title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        return navigationController
    }
    
    static func buildLocationPermissionViewController(_ onSelectPermission: ((Bool) -> Void)?) -> UIViewController {
        let viewController = LocationPermissionViewController()
        viewController.onSelectPermission = onSelectPermission
        return viewController
    }
    
    static func buildForecastViewController(coordinator: WeatherCoordinatorProtocol, location: CoordRealm) -> UIViewController {
        let viewModel = ForecastViewModel(coordinator: coordinator, location: location)
        let viewController = ForecastViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildMainViewController(coordinator: WeatherCoordinatorProtocol, locationService: LocationService) -> UIViewController {
        let viewModel = MainViewModel(coordinator: coordinator, locationService: locationService)
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildMapViewController(coordinator: WeatherCoordinatorProtocol) -> UIViewController {
        let viewModel = MapViewModel(coordinator: coordinator)
        let viewController = MapViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildAddLocationInfoViewController(coordinator: WeatherCoordinatorProtocol) -> UIViewController {
        let viewController = AddLocationInfoViewController()
        return viewController
    }
    
    static func buildDetailsViewController(coordinator: WeatherCoordinatorProtocol, location: CoordRealm) -> UIViewController {
        let viewModel = DetailsViewModel(coordinator: coordinator, location: location)
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildDailyForecastViewController(coordinator: WeatherCoordinatorProtocol, location: CoordRealm, date: Date) -> UIViewController {
        let viewModel = DailyForecastViewModel(coordinator: coordinator, location: location, date: date)
        let viewController = DailyForecastViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildDailyPagesViewController(coordinator: WeatherCoordinatorProtocol, location: CoordRealm, selectedDay: Date) -> UIViewController {
        let viewModel = DailyPagesViewModel(coordinator: coordinator, location: location, selectedDay: selectedDay)
        let viewController = DailyPagesViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildSettingsViewController(coordinator: WeatherCoordinatorProtocol) -> UIViewController {
        let viewModel = SettingsViewModel(coordinator: coordinator)
        let viewController = SettingsViewController(viewModel: viewModel)
        return viewController
    }

}
