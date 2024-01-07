//
//  DownloadSaveService.swift
//  weather
//
//  Created by Kr Qqq on 11.12.2023.
//

import Foundation
import RealmSwift

final class DownloadSaveService {
    
    private static let settingsService = SettingsService()
    
    static func loadSaveCurrentWeather(coordinates: Coord, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let unit = settingsService.getSetting(typeSetting: .temperature)
        NetworkService.loadCurrentWeather(coordinates: coordinates, unit: unit) { result in
            switch result {
            case .success(let currentWeatherResponse):
                createCurrentWeather(currentWeatherResponse: currentWeatherResponse, unit: unit)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func loadSaveForecast(coordinates: Coord, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let unit = settingsService.getSetting(typeSetting: .temperature)
        NetworkService.loadForecast(coordinates: coordinates, unit: unit) { result in
            switch result {
            case .success(let forecastResponse):
                createForecast(forecastResponse: forecastResponse, unit: unit)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func createForecast(forecastResponse: ForecastResponse, unit: Units?) {
        guard let realm = try? RealmService.getRealm() else { return }
        guard let city = forecastResponse.city, let coord = city.coord else { return }
        guard let coordRealm = takeCoord(lat: coord.lat, lon: coord.lon, cityName: city.name, timezone: city.timezone) else { return }
        
        let createdAt = Date()
        
        for itemList in forecastResponse.list {
            let forecastWeatherRealm = ForecastWeatherRealm()
            
            forecastWeatherRealm.coord = coordRealm
            if let dateTime = itemList.dt {
                forecastWeatherRealm.dateTimeForecast = NSDate(timeIntervalSince1970: TimeInterval(dateTime)) as Date
            }
        
            forecastWeatherRealm.createdAt = createdAt
            forecastWeatherRealm.feelsLike = itemList.main.feelsLike ?? 0
            forecastWeatherRealm.temp = itemList.main.temp ?? 0
            forecastWeatherRealm.clouds = itemList.clouds.all ?? 0
            forecastWeatherRealm.humidity = itemList.main.humidity ?? 0
            forecastWeatherRealm.pop = Int((itemList.pop ?? 0) * 100)
            forecastWeatherRealm.windSpeed = itemList.wind.speed ?? 0
            forecastWeatherRealm.windDeg = itemList.wind.deg ?? 0
            forecastWeatherRealm.tempMin = itemList.main.tempMin ?? 0
            forecastWeatherRealm.tempMax = itemList.main.tempMax ?? 0

            forecastWeatherRealm.descriptionWeather = itemList.weather.first?.description ?? ""
            forecastWeatherRealm.mainWeather = itemList.weather.first?.main ?? ""
            
            forecastWeatherRealm.unit = unit?.rawValue ?? Units.celsius.rawValue
            
            do {
                try realm.write {
                    realm.add(forecastWeatherRealm)
                }
                deleteOldForecastWeather(coord: coordRealm)
            } catch {
                print(error)
            }
        }
    }
    
    private static func createCurrentWeather(currentWeatherResponse: CurrentWeatherResponse, unit: Units?) {
        guard let realm = try? RealmService.getRealm() else { return }
        guard let coord = currentWeatherResponse.coord else { return }
        
        guard let coordRealm = takeCoord(lat: coord.lat, lon: coord.lon, cityName: currentWeatherResponse.name, timezone: currentWeatherResponse.timezone) else { return }
        
        let currentWeatherRealm = CurrentWeatherRealm()
        let createdAt = Date()
        
        currentWeatherRealm.createdAt = createdAt
        currentWeatherRealm.coord = coordRealm
        currentWeatherRealm.temp = currentWeatherResponse.main.temp ?? 0
        currentWeatherRealm.clouds = currentWeatherResponse.clouds.all ?? 0
        currentWeatherRealm.tempMin = currentWeatherResponse.main.tempMin ?? 0
        currentWeatherRealm.tempMax = currentWeatherResponse.main.tempMax ?? 0
        currentWeatherRealm.humidity = currentWeatherResponse.main.humidity ?? 0
        currentWeatherRealm.windSpeed = currentWeatherResponse.wind.speed ?? 0
        if let sunset = currentWeatherResponse.sys.sunset {
            currentWeatherRealm.sunset = NSDate(timeIntervalSince1970: TimeInterval(sunset)) as Date
        }
        if let sunrise = currentWeatherResponse.sys.sunrise {
            currentWeatherRealm.sunrise = NSDate(timeIntervalSince1970: TimeInterval(sunrise)) as Date
        }
        currentWeatherRealm.descriptionWeather = currentWeatherResponse.weather.first?.description ?? ""
        currentWeatherRealm.mainWeather = currentWeatherResponse.weather.first?.main ?? ""
        
        currentWeatherRealm.unit = unit?.rawValue ?? Units.celsius.rawValue
        
        do {
            try realm.write {
                realm.add(currentWeatherRealm)
            }
            deleteCurrentWeather(to: createdAt, coord: coordRealm)
        } catch {
            print(error)
        }
    }
    
    static func takeCoord(lat: Double, lon: Double, cityName: String? = nil, userAdd: Bool = false, timezone: Int? = nil) -> CoordRealm? {
        
        guard let realm = try? RealmService.getRealm() else { return nil }
        let cityName = cityName ?? ""
        let timezone = timezone ?? 0
        
        let latt = lat.roundTwoChar()
        let lonn = lon.roundTwoChar()
        let coordsRealm = realm.objects(CoordRealm.self).filter("lat == %lat AND lon == %lon", latt, lonn)
        if coordsRealm.isEmpty {
            let coordRealm = CoordRealm()
            coordRealm.lat = latt
            coordRealm.lon = lonn
            coordRealm.cityName = cityName
            coordRealm.userAdd = userAdd
            coordRealm.timezone = timezone
            do {
                try realm.write {
                    realm.add(coordRealm)
                }
            } catch {
                print(error)
            }
            return coordRealm
        } else {
            let coordRealm = coordsRealm.first!
            if (coordRealm.cityName.isEmpty && !cityName.isEmpty) || (coordRealm.timezone == 0 && timezone != 0) {
                do {
                    try realm.write {
                        coordRealm.cityName = cityName
                        coordRealm.timezone = timezone
                        realm.add(coordRealm)
                    }
                } catch {
                    print(error)
                }
            }
            return coordRealm
        }
    }
    
    static func takeCurrentWeather(coordinates: Coord) -> CurrentWeatherRealm? {
        guard let realm = try? RealmService.getRealm() else { return nil }
        guard let coord = takeCoord(lat: coordinates.lat, lon: coordinates.lon) else { return nil }
        let currentsWeatherRealm = realm.objects(CurrentWeatherRealm.self).filter("coord == %@", coord)
        return currentsWeatherRealm.last
    }
    
    static func takeLocations() -> [CoordRealm] {
        guard let realm = try? RealmService.getRealm() else { return [] }
        let coordsRealm = realm.objects(CoordRealm.self).filter("userAdd == %@", true)
        var array: [CoordRealm] = []
        for item in coordsRealm {
            array.append(item)
        }
        return array
    }
    
    static private func lastCreated(coord: CoordRealm) -> Date? {
        guard let realm = try? RealmService.getRealm() else { return nil }
        let objects = realm.objects(ForecastWeatherRealm.self).filter("coord == %@", coord)
        return objects.last?.createdAt
    }
    
    static func takeForecastHours(coord: CoordRealm, date: Date = Date()) -> [ForecastWeatherRealm] {
        guard let lastForecastWeatherRealm = lastCreated(coord: coord) else { return [] }
        guard let realm = try? RealmService.getRealm() else { return [] }
        let dateTo = date + TimeInterval(86400) //12 hours
        let forecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND createdAt == %cratedAt AND dateTimeForecast < %dateTo", coord, lastForecastWeatherRealm, dateTo)
        
        var array: [ForecastWeatherRealm] = []
        for item in forecastWeatherRealm {
            array.append(item)
        }
        return array
    }
    
    static func takeForecastDays(coord: CoordRealm, date: Date = Date()) -> [ForecastWeatherRealm] {
        guard let lastForecastWeatherRealm = lastCreated(coord: coord) else { return [] }
        guard let realm = try? RealmService.getRealm() else { return [] }
        let forecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND createdAt == %cratedAt AND dateTimeForecast >= %dateFrom", coord, lastForecastWeatherRealm, date.startOfDay(coord.timezone))
        
        var array: [ForecastWeatherRealm] = []
        for item in forecastWeatherRealm {
            let hourInTimeZone = item.dateTimeForecast.hourInTimeZone(coord.timezone)
            if hourInTimeZone >= 12 && hourInTimeZone < 15 {
                array.append(item)
            }
        }
        return array
    }
    
    static func takeForecastDayNight(coord: CoordRealm, date: Date) -> [ForecastWeatherRealm] {
        guard let lastForecastWeatherRealm = lastCreated(coord: coord) else { return [] }
        guard let realm = try? RealmService.getRealm() else { return [] }
        let forecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND createdAt == %cratedAt AND dateTimeForecast >= %dateFrom AND dateTimeForecast < %dateTo", coord, lastForecastWeatherRealm, date.startOfDay(coord.timezone), date.endOfDay(coord.timezone))
        
        var array: [ForecastWeatherRealm] = []
        for item in forecastWeatherRealm {
            let hourInTimeZone = item.dateTimeForecast.hourInTimeZone(coord.timezone)
            if hourInTimeZone >= 12 && hourInTimeZone < 15 {
                array.append(item)
            } else if hourInTimeZone >= 0 && hourInTimeZone < 3 {
                array.append(item)
            }
        }
        return array
    }
    
    static func takeForecastDates(coord: CoordRealm) -> [Date] {
        let forecastDates = takeForecastDays(coord: coord)
        guard !forecastDates.isEmpty else { return [] }
        var resultDays: [Date] = []
        for item in forecastDates {
            resultDays.append(item.dateTimeForecast.startOfDay(coord.timezone))
        }
        return resultDays
    }
    
    private static func deleteCurrentWeather(to date: Date, coord: CoordRealm) {
        guard let realm = try? RealmService.getRealm() else { return }
        do {
            try realm.write {
                let currentsWeatherRealm = realm.objects(CurrentWeatherRealm.self).filter("coord == %coord AND createdAt < %date", coord, date)
                realm.delete(currentsWeatherRealm)
            }
        } catch {
            print(error)
        }
    }
    
    private static func deleteOldForecastWeather(coord: CoordRealm) {
        guard let realm = try? RealmService.getRealm() else { return }
        do {
            try realm.write {
                let forecastsWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND dateTimeForecast < %date", coord, Date().startOfDay(coord.timezone))
                realm.delete(forecastsWeatherRealm)
            }
        } catch {
            print(error)
        }
    }
}
