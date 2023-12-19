//
//  ForecastService.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import Foundation

final class ForecastViewModel {
    
    private let coordinator: WeatherCoordinatorProtocol
    weak var forecastViewControllerDelegate: ForecastViewControllerDelegate?
    private let coordinates: Coord
    private let location: CoordRealm
    private var forecastDays: [ForecastWeatherRealm] = []
    
    init(coordinator: WeatherCoordinatorProtocol, location: CoordRealm) {
        self.coordinator = coordinator
        self.location = location
        coordinates = Coord(lon: location.lon, lat: location.lat)
        //updateLocation()
        updateForecastDays()
    }
    
    func cityName() -> String {
        location.cityName
    }
    
    func loadCurrentWeather() {
       // guard let coordinates = coordinates else { return }
        DownloadSaveService.loadSaveCurrentWeather(coordinates: coordinates) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.forecastViewControllerDelegate?.updateHeader()
                    self?.loadForecast()
                case .failure(let error):
                    self?.coordinator.showError("call network failure \(error)")
                }
            }
        }
    }
    
    func loadForecast() {
       // guard let coordinates = coordinates else { return }
        DownloadSaveService.loadSaveForecast(coordinates: coordinates) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.updateForecastDays()
                    self?.forecastViewControllerDelegate?.updateForecast()
                case .failure(let error):
                    self?.coordinator.showError("call network failure \(error)")
                }
            }
        }
    }
    
    func takeCurrentWeather() -> CurrentWeatherRealm? {
       //guard let coordinates = coordinates else { return nil }
        return DownloadSaveService.takeCurrentWeather(coordinates: coordinates)
    }
    
    func takeForecastHours() -> [ForecastWeatherRealm] {
       // guard let coordinates = coordinates else { return [] }
        return DownloadSaveService.takeForecastHours(coordinates: coordinates)
    }
    
    func updateForecastDays() {
       // guard let coordinates = coordinates else { return }
        forecastDays = DownloadSaveService.takeForecastDays(coordinates: coordinates)
    }
    
    func countForecastDays() -> Int {
        forecastDays.count
    }
    
    func takeForecastDay(at index: Int) -> ForecastWeatherRealm {
        return forecastDays[index]
    }
    
//    func updateLocation() {
//        coordinates = LocationService.shared.nowLocation()
//    }
}
