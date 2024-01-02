//
//  SettingsViewModel.swift
//  weather
//
//  Created by Kr Qqq on 31.12.2023.
//

import Foundation

class SettingsViewModel {
    
    private let coordinator: WeatherCoordinatorProtocol
    private let settingsService = SettingsService()
    private var settings: [Settings]
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
        settings = settingsService.getSettings()
    }
    
    func countSettings() -> Int {
        return settings.count
    }
    
    func setting(at index: Int) -> Settings {
        return settings[index]
    }
    
    func updateSetting(_ setting: Settings) {
        if let i = settings.firstIndex(where: {$0.typeSetting == setting.typeSetting}) {
            settings[i].value = setting.value
        }
        settingsService.updateSettings(settings: settings)
    }
}
