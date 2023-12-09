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
    
    static func buildForecastViewController(coordinator: WeatherCoordinatorProtocol) -> UIViewController {
        let viewModel = ForecastViewModel(coordinator: coordinator)
        let viewController = ForecastViewController(viewModel: viewModel)
        return viewController
    }

}
