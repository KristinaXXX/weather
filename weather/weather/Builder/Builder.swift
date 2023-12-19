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
    
    static func buildMainViewController(coordinator: WeatherCoordinatorProtocol) -> UIViewController {
        let viewModel = MainViewModel(coordinator: coordinator)
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

}
