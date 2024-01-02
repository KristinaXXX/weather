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
    private var currentWeatherRealm: CurrentWeatherRealm?
    
    init(coordinator: WeatherCoordinatorProtocol, location: CoordRealm, date: Date) {
        self.coordinator = coordinator
        self.location = location
        self.date = date
        updateDay()
    }
    
    func updateDay() {
        forecastDayNight = DownloadSaveService.takeForecastDayNight(coord: location, date: date)
        currentWeatherRealm = DownloadSaveService.takeCurrentWeather(coordinates: Coord(lon: location.lon, lat: location.lat))
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
    
    func sunDetails() -> SunDetails {
        var details = SunDetails()
        guard let dataSun = currentWeatherRealm else { return details }
        
        let timezone = dataSun.coord?.timezone ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        
        guard let sunrise = dataSun.sunrise, let sunset = dataSun.sunset else {
            details.sunrise = "-:-"
            details.sunset = "-:-"
            return details
        }
        
        details.sunrise = dateFormatter.string(from: dataSun.sunrise!)
        details.sunset = dateFormatter.string(from: dataSun.sunset!)
        
        let timeInterval = sunrise.distance(to: sunset)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter1.dateFormat = "Hч mmмин"
        details.sunLife = dateFormatter1.string(from: Date(timeIntervalSince1970: timeInterval))
        
        return details
    }
}

struct SunDetails {
    var sunrise: String?
    var sunset: String?
    var sunLife: String?
}
