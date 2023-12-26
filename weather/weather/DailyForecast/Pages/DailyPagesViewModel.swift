//
//  DailyPagesViewModel.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import Foundation
import UIKit

class DailyPagesViewModel {
    private var coordinator: WeatherCoordinatorProtocol
    private var days: [Date] = []
    private let location: CoordRealm
    private var selectedDay: Date
    
    init(coordinator: WeatherCoordinatorProtocol, location: CoordRealm, selectedDay: Date) {
        self.coordinator = coordinator
        self.location = location
        self.selectedDay = selectedDay
        updateDates()
    }
    
    public func updateDates() {
        days = DownloadSaveService.takeForecastDates(coord: location)
    }
    
    func takeDay(at index: Int) -> Date {
        days[index]
    }
    
    func dayText(at index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: location.timezone)
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: days[index])
    }
    
    func createPages() -> [DailyForecastViewController] {
        coordinator.createForecastsDays(location: location, days: days)
    }
    
    func isSelectDate(at index: Int) -> Bool {
        selectedDay == days[index]
    }
}
