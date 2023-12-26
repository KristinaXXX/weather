//
//  DetailsViewModel.swift
//  weather
//
//  Created by Kr Qqq on 22.12.2023.
//

import Foundation

class DetailsViewModel {
    private let coordinator: WeatherCoordinatorProtocol
    private let location: CoordRealm
    private var dataForecastHours: [ForecastWeatherRealm] = []
    
    init(coordinator: WeatherCoordinatorProtocol, location: CoordRealm) {
        self.coordinator = coordinator
        self.location = location
        dataForecastHours = DownloadSaveService.takeForecastHours(coord: location)
    }
    
    func countDetailsHour() -> Int {
        return dataForecastHours.count
    }
    
    func takeDetailHour(at index: Int) -> ForecastWeatherRealm {
        return dataForecastHours[index]
    }
}
