//
//  SettingsService.swift
//  weather
//
//  Created by Kr Qqq on 30.12.2023.
//

import Foundation

final class SettingsService {
   
    private let keyUnit = "settingsUnit"
    private let keyPermissionLocation = "settingsermission"
    private let userDefaultsStorage = UserDefaultsStorage()
    
    func updateSettings(settings: [Settings]) {
        userDefaultsStorage.save(key: keyUnit, items: settings)
    }
    
    func getSettings() -> [Settings] {
        if let storageSettings = userDefaultsStorage.load(key: keyUnit) {
            storageSettings
        } else {
            Settings.make()
        }
    }
    
    func getSetting(typeSetting: TypeSettings) -> Units? {
        let settings = getSettings()
        guard let i = settings.firstIndex(where: {$0.typeSetting == typeSetting.rawValue}) else { return nil }
        return Units(rawValue: settings[i].value)
    }
    
    func getDeterminedPermissionLocation() -> Bool {
        if let storageValue = userDefaultsStorage.loadValue(key: keyPermissionLocation) {
            storageValue
        } else {
            false
        }
    }
    
    func updateDeterminedPermissionLocation(value: Bool) {
        userDefaultsStorage.save(key: keyPermissionLocation, value: value)
    }
}
