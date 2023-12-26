//
//  DailyForecastViewModel.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import Foundation

class DailyForecastViewModel {
    
    private let coordinator: WeatherCoordinatorProtocol
    private let location: CoordRealm
    private let date: Date
    private var forecastDayNight: [ForecastWeatherRealm] = []
    
    init(coordinator: WeatherCoordinatorProtocol, location: CoordRealm, date: Date) {
        self.coordinator = coordinator
        self.location = location
        self.date = date
        updateDay()
    }
    
    func updateDay() {
        forecastDayNight = DownloadSaveService.takeForecastDayNight(coord: location, date: date)
    }
    
    func cityName() -> String {
        location.cityName
    }
    
    func countParts() -> Int {
        forecastDayNight.count
    }
    
    func takeDayPart(at index: Int) -> ForecastWeatherRealm {
        forecastDayNight[index]
    }
    
    func sunDetails() -> String {
        ""
        
    }
    
}
