//
//  UserDefaultsStorage.swift
//  weather
//
//  Created by Kr Qqq on 30.12.2023.
//

import Foundation

final class UserDefaultsStorage {
    
    func save<T: Encodable>(key: String, value: T) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load<T: Decodable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let value = try? decoder.decode(T.self, from: data) else {
            print("assertionFailure(Decode error)")
            return nil
        }
        return value
    }
    
//    func save(key: String, items: [Settings]) {
//        let encoder = JSONEncoder()
//        guard let data = try? encoder.encode(items) else { return }
//        UserDefaults.standard.set(data, forKey: key)
//    }
    
//    func load(key: String) -> [Settings]? {
//        guard let data = UserDefaults.standard.data(forKey: key) else {
//            return nil
//        }
//        let decoder = JSONDecoder()
//        guard let items = try? decoder.decode([Settings].self, from: data) else {
//            print("assertionFailure(Decode error)")
//            return nil
//        }
//        return items
//    }
    
//    func save(key: String, value: Bool) {
//        let encoder = JSONEncoder()
//        guard let data = try? encoder.encode(value) else { return }
//        UserDefaults.standard.set(data, forKey: key)
//    }
    
//    func loadValue(key: String) -> Bool? {
//        guard let data = UserDefaults.standard.data(forKey: key) else {
//            return nil
//        }
//        let decoder = JSONDecoder()
//        guard let value = try? decoder.decode(Bool.self, from: data) else {
//            print("assertionFailure(Decode error)")
//            return nil
//        }
//        return value
//    }
}
