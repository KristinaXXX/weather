//
//  ForecastService.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import Foundation

final class ForecastViewModel {
    
    private let coordinator: WeatherCoordinatorProtocol
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}
