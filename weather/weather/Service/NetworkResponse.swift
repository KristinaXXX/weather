//
//  NetworkRequest.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation
import Alamofire

// MARK: - CurrentWeatherResponse

struct CurrentWeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: Int?
    let sys: Sys
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City?
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord?
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double?
    let sys: System
    let dtTxt: String?
    let rain, snow: Precipitation?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Precipitation: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct System: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
