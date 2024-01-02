//
//  NetworkService.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation
import Alamofire
import UIKit

typealias completionCurrentWeatherResponse = (Result<CurrentWeatherResponse, Error>) -> Void
typealias completionForecastResponse = (Result<ForecastResponse, Error>) -> Void

struct NetworkService {
    
    static func loadCurrentWeather(coordinates: Coord, unit: Units?, completion: @escaping completionCurrentWeatherResponse)  {
        Task(priority: .userInitiated) {
            do {
                var parameters: [String: Any] = [:]
                parameters["lat"] = coordinates.lat
                parameters["lon"] = coordinates.lon
                parameters["appid"] = "01fe6c1ac12469d4fc119476e3979bb7"
                parameters["units"] = unit == .fahrenheit ? "imperial" : "metric"
                parameters["lang"] = "ru"
                let request = AF.request(AppConfiguration.currentWeatherData.rawValue, parameters: parameters)
                let value = try await request.serializingDecodable(CurrentWeatherResponse.self).value
                completion(.success(value))
            } catch {
                completion(.failure(NetworkError.error(error.localizedDescription)))
            }
        }
    }
    
    static func loadForecast(coordinates: Coord, unit: Units?, completion: @escaping completionForecastResponse)  {
        Task(priority: .userInitiated) {
            do {
                var parameters: [String: Any] = [:]
                parameters["lat"] = coordinates.lat
                parameters["lon"] = coordinates.lon
                parameters["appid"] = "01fe6c1ac12469d4fc119476e3979bb7"
                parameters["units"] = unit == .fahrenheit ? "imperial" : "metric"
                parameters["lang"] = "ru"
                let request = AF.request(AppConfiguration.forecast5Days.rawValue, parameters: parameters)
                let value = try await request.serializingDecodable(ForecastResponse.self).value
                completion(.success(value))
            } catch {
                completion(.failure(NetworkError.error(error.localizedDescription)))
            }
        }
    }
}

enum AppConfiguration: String, CaseIterable {
    case currentWeatherData = "https://api.openweathermap.org/data/2.5/weather"
    case forecast5Days = "https://api.openweathermap.org/data/2.5/forecast"
    var url: URL? {
        URL(string: self.rawValue)
    }
}

let u = "https://api.openweathermap.org/data/2.5/forecast?lat=51.46&lon=55.06&appid=01fe6c1ac12469d4fc119476e3979bb7&units=metric&lang=ru"
let c = "https://api.openweathermap.org/data/2.5/weather?lat=51.46&lon=55.06&appid=01fe6c1ac12469d4fc119476e3979bb7&units=metric&lang=ru"
