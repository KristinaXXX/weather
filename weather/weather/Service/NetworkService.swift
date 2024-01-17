//
//  NetworkService.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation
import Alamofire
import UIKit

typealias completionCurrentWeatherModel = (Result<CurrentWeatherModel, Error>) -> Void
typealias completionForecastModel = (Result<ForecastModel, Error>) -> Void

struct NetworkService {
    
    static func loadCurrentWeather(coordinates: Coord, unit: Units?, completion: @escaping completionCurrentWeatherModel)  {
        Task(priority: .userInitiated) {
            do {
                var parameters: [String: Any] = [:]
                parameters["lat"] = coordinates.lat
                parameters["lon"] = coordinates.lon
                parameters["appid"] = "01fe6c1ac12469d4fc119476e3979bb7"
                parameters["units"] = unit == .fahrenheit ? "imperial" : "metric"
                parameters["lang"] = "ru"
                let request = AF.request(APIConfiguration.currentWeatherData.rawValue, parameters: parameters)
                let value = try await request.serializingDecodable(CurrentWeatherModel.self).value
                completion(.success(value))
            } catch {
                completion(.failure(NetworkError.error(error.localizedDescription)))
            }
        }
    }
    
    static func loadForecast(coordinates: Coord, unit: Units?, completion: @escaping completionForecastModel)  {
        Task(priority: .userInitiated) {
            do {
                var parameters: [String: Any] = [:]
                parameters["lat"] = coordinates.lat
                parameters["lon"] = coordinates.lon
                parameters["appid"] = "01fe6c1ac12469d4fc119476e3979bb7"
                parameters["units"] = unit == .fahrenheit ? "imperial" : "metric"
                parameters["lang"] = "ru"
                let request = AF.request(APIConfiguration.forecast5Days.rawValue, parameters: parameters)
                let value = try await request.serializingDecodable(ForecastModel.self).value
                completion(.success(value))
            } catch {
                completion(.failure(NetworkError.error(error.localizedDescription)))
            }
        }
    }
}

enum APIConfiguration: String, CaseIterable {
    case currentWeatherData = "https://api.openweathermap.org/data/2.5/weather"
    case forecast5Days = "https://api.openweathermap.org/data/2.5/forecast"
    var url: URL? {
        URL(string: self.rawValue)
    }
}
