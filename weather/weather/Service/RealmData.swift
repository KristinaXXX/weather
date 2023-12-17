//
//  RealmData.swift
//  weather
//
//  Created by Kr Qqq on 11.12.2023.
//

import Foundation
import RealmSwift

class CurrentWeatherRealm: Object {
    @Persisted var createdAt: Date
    @Persisted var coord: CoordRealm?
    @Persisted var temp: Double
    @Persisted var clouds: Int
    @Persisted var tempMin: Double
    @Persisted var tempMax: Double
    @Persisted var humidity: Int
    @Persisted var windSpeed: Double
    @Persisted var sunset: Date?
    @Persisted var sunrise: Date?
    @Persisted var descriptionWeather: String?
    @Persisted var mainWeather: String?
}

class CoordRealm: Object {
    @Persisted var lon: Double
    @Persisted var lat: Double
    @Persisted var cityName: String
}

class ForecastWeatherRealm: Object {
    @Persisted var createdAt: Date
    @Persisted var coord: CoordRealm?
    @Persisted var dateTimeForecast: Date
    @Persisted var feelsLike: Double
    @Persisted var temp: Double
    @Persisted var clouds: Int
    @Persisted var humidity: Int
    @Persisted var windSpeed: Double
    @Persisted var windDeg: Int
    @Persisted var sunset: Date?
    @Persisted var sunrise: Date?
    @Persisted var descriptionWeather: String?
    @Persisted var mainWeather: String?
    @Persisted var tempMin: Double
    @Persisted var tempMax: Double
}
