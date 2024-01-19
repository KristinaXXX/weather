//
//  Errors.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation

enum NetworkError: Error {
    case error(String)
    case parseError
    case emptyData
}

enum RealmError: Error {
    case configurationError
    case loadError
}
