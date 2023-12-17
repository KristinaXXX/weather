//
//  LocationService.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    static let shared = LocationService()
    private let manager = CLLocationManager()
    private var nowCoordinate: CLLocationCoordinate2D?
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return manager.authorizationStatus
    }
    
    func requestAuthorization() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
    }
    
    func nowLocation() -> Coord? {
        guard let lon = manager.location?.coordinate.longitude, let lat = manager.location?.coordinate.latitude else { return nil }
        return Coord(lon: lon, lat: lat)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first else { return }
        nowCoordinate = CLLocationCoordinate2D(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
    }
}
