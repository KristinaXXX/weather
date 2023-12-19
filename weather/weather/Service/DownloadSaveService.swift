//
//  DownloadSaveService.swift
//  weather
//
//  Created by Kr Qqq on 11.12.2023.
//

import Foundation
import RealmSwift

final class DownloadSaveService {
    
    static func loadSaveCurrentWeather(coordinates: Coord, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkService.loadCurrentWeather(coordinates: coordinates) { result in
            switch result {
            case .success(let currentWeatherResponse):
                createCurrentWeather(currentWeatherResponse: currentWeatherResponse)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func loadSaveForecast(coordinates: Coord, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkService.loadForecast(coordinates: coordinates) { result in
            switch result {
            case .success(let forecastResponse):
                createForecast(forecastResponse: forecastResponse)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func createForecast(forecastResponse: ForecastResponse) {
        guard let realm = try? RealmService.getRealm() else { return }
        guard let city = forecastResponse.city, let coord = city.coord else { return }
        guard let coordRealm = takeCoord(lat: coord.lat, lon: coord.lon, cityName: city.name) else { return }
        
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
            forecastWeatherRealm.windSpeed = itemList.wind.speed ?? 0
            forecastWeatherRealm.windDeg = itemList.wind.deg ?? 0
            forecastWeatherRealm.tempMin = itemList.main.tempMin ?? 0
            forecastWeatherRealm.tempMax = itemList.main.tempMax ?? 0

            forecastWeatherRealm.descriptionWeather = itemList.weather.first?.description ?? ""
            forecastWeatherRealm.mainWeather = itemList.weather.first?.main ?? ""
            
            do {
                try realm.write {
                    realm.add(forecastWeatherRealm)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private static func createCurrentWeather(currentWeatherResponse: CurrentWeatherResponse) {
        guard let realm = try? RealmService.getRealm() else { return }
        guard let coord = currentWeatherResponse.coord else { return }
        
        guard let coordRealm = takeCoord(lat: coord.lat, lon: coord.lon, cityName: currentWeatherResponse.name) else { return }
        
        let currentWeatherRealm = CurrentWeatherRealm()
        currentWeatherRealm.createdAt = Date()
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
        
        do {
            try realm.write {
                realm.add(currentWeatherRealm)
            }
        } catch {
            print(error)
        }
    }
    
    static func takeCoord(lat: Double, lon: Double, cityName: String? = nil, userAdd: Bool = false) -> CoordRealm? {
        
        guard let realm = try? RealmService.getRealm() else { return nil }
        let cityName = cityName ?? ""
        
        let latt = lat.roundTwoChar()
        let lonn = lon.roundTwoChar()
        let coordsRealm = realm.objects(CoordRealm.self).filter("lat == %lat AND lon == %lon", latt, lonn)
        if coordsRealm.isEmpty {
            let coordRealm = CoordRealm()
            coordRealm.lat = latt
            coordRealm.lon = lonn
            coordRealm.cityName = cityName
            coordRealm.userAdd = userAdd
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
            if coordRealm.cityName.isEmpty && !cityName.isEmpty {
                do {
                    try realm.write {
                        coordRealm.cityName = cityName
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
    
    static func takeForecastHours(coordinates: Coord, date: Date = Date()) -> [ForecastWeatherRealm] {
        guard let realm = try? RealmService.getRealm() else { return [] }
        guard let coord = takeCoord(lat: coordinates.lat, lon: coordinates.lon) else { return [] }
        
        guard let lastForecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).last else { return [] }
        let dateFrom = date - TimeInterval(144000) //4 hours
        let dateTo = date + TimeInterval(86400) //12 hours
        let forecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND createdAt == %cratedAt AND dateTimeForecast > %dateFrom AND dateTimeForecast < %dateTo", coord, lastForecastWeatherRealm.createdAt, dateFrom, dateTo)
        
        var array: [ForecastWeatherRealm] = []
        for item in forecastWeatherRealm {
            array.append(item)
        }
        return array
    }
    
    static func takeForecastDays(coordinates: Coord, date: Date = Date()) -> [ForecastWeatherRealm] {
        guard let realm = try? RealmService.getRealm() else { return [] }
        guard let coord = takeCoord(lat: coordinates.lat, lon: coordinates.lon) else { return [] }
        guard let lastForecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).last else { return [] }
        
        let dateFrom = Calendar.current.startOfDay(for: date)
        let forecastWeatherRealm = realm.objects(ForecastWeatherRealm.self).filter("coord == %coord AND createdAt == %cratedAt AND dateTimeForecast > %dateFrom", coord, lastForecastWeatherRealm.createdAt, dateFrom)
        
        var array: [ForecastWeatherRealm] = []
        for item in forecastWeatherRealm {
            if Calendar.current.component(.hour, from: item.dateTimeForecast) >= 12 && Calendar.current.component(.hour, from: item.dateTimeForecast) < 15 {
                array.append(item)
            }
        }
        return array
    }
}
