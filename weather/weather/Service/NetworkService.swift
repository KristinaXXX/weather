//
//  NetworkService.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation
import Alamofire
import UIKit

struct NetworkService {
    
    static func loadCurrentWeather(coordinates: Coord, unit: Units?) async throws -> CurrentWeatherModel  {
        let options = loadingOptions(coordinates: coordinates, unit: unit)
        do {
            let request = AF.request(APIConfiguration.currentWeatherData.rawValue, parameters: options)
            let value = try await request.serializingDecodable(CurrentWeatherModel.self).value
            return value
        } catch {
            throw error
        }
    }
    
    static func loadForecast(coordinates: Coord, unit: Units?) async throws -> ForecastModel {
        let options = loadingOptions(coordinates: coordinates, unit: unit)
        do {
            let request = AF.request(APIConfiguration.forecast5Days.rawValue, parameters: options)
            let value = try await request.serializingDecodable(ForecastModel.self).value
            return value
        } catch {
            throw error
        }
    }
    
    static func loadingOptions(coordinates: Coord, unit: Units?) -> [String: Any] {
        var options: [String: Any] = [:]
        options["lat"] = coordinates.lat
        options["lon"] = coordinates.lon
        options["appid"] = "01fe6c1ac12469d4fc119476e3979bb7"
        options["units"] = unit == .fahrenheit ? "imperial" : "metric"
        options["lang"] = "ru"
        return options
    }
}

enum APIConfiguration: String, CaseIterable {
    case currentWeatherData = "https://api.openweathermap.org/data/2.5/weather"
    case forecast5Days = "https://api.openweathermap.org/data/2.5/forecast"
    var url: URL? {
        URL(string: self.rawValue)
    }
}

let u = "https://api.openweathermap.org/data/2.5/forecast?lat=51.46&lon=55.06&appid=01fe6c1ac12469d4fc119476e3979bb7&units=metric&lang=ru"
let c = "https://api.openweathermap.org/data/2.5/weather?lat=51.46&lon=55.06&appid=01fe6c1ac12469d4fc119476e3979bb7&units=metric&lang=ru"
