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
        updateForecastDays()
    }
    
    func cityName() -> String {
        location.cityName
    }
    
    func loadCurrentWeather() {
        DownloadSaveService.loadSaveCurrentWeather(coordinates: coordinates) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.forecastViewControllerDelegate?.updateHeader()
                    self?.loadForecast()
                case .failure(let error):
                    self?.coordinator.showError("call network failure \(error)")
                    self?.forecastViewControllerDelegate?.cancelUpdate()
                }
            }
        }
    }
    
    func loadForecast() {
        DownloadSaveService.loadSaveForecast(coordinates: coordinates) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.updateForecastDays()
                    self?.forecastViewControllerDelegate?.updateForecast()
                case .failure(let error):
                    self?.coordinator.showError("call network failure \(error)")
                    self?.forecastViewControllerDelegate?.cancelUpdate()
                }
            }
        }
    }
    
    func takeCurrentWeather() -> CurrentWeatherRealm? {
        return DownloadSaveService.takeCurrentWeather(coordinates: coordinates)
    }
    
    func takeForecastHours() -> [ForecastWeatherRealm] {
        return DownloadSaveService.takeForecastHours(coord: location)
    }
    
    func updateForecastDays() {
        forecastDays = DownloadSaveService.takeForecastDays(coord: location)
    }
    
    func countForecastDays() -> Int {
        forecastDays.count
    }
    
    func takeForecastDay(at index: Int) -> ForecastWeatherRealm {
        return forecastDays[index]
    }
    
    func showDetails() {
        coordinator.showDetails(location: location)
    }
    
    func showDailyForecast(at index: Int) {
        let selectedDate = takeForecastDay(at: index).dateTimeForecast.startOfDay(location.timezone)
        coordinator.showDailyPages(location: location, selectedDay: selectedDate)
    }
}
