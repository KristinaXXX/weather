//
//  Settings.swift
//  weather
//
//  Created by Kr Qqq on 30.12.2023.
//

import Foundation

enum TypeSettings: String, Codable {
    case temperature = "temperature"
    case windSpeed = "windSpeed"
    case formatTime = "formatTime"
}

struct Settings: Codable {
    let typeSetting: String
    var value: String
    let title: String
}

enum Units: String, Codable {
    case celsius = "C"
    case fahrenheit = "F"
    case miles = "мл"
    case kilometers = "км"
    case hours12 = "12"
    case hours24 = "24"
}

extension Settings {
    static func make() -> [Settings] {
        var settingsArray: [Settings] = []
        settingsArray.append(Settings(typeSetting: TypeSettings.temperature.rawValue, value: Units.celsius.rawValue, title: "Температура"))
        //settingsArray.append(Settings(typeSetting: TypeSettings.windSpeed.rawValue, value: Units.kilometers.rawValue, title: "Скорость ветра"))
        settingsArray.append(Settings(typeSetting: TypeSettings.formatTime.rawValue, value: Units.hours24.rawValue, title: "Формат времени"))
        return settingsArray
    }
}
