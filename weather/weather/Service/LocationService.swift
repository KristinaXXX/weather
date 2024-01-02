//
//  LocationService.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    private let manager = CLLocationManager()
    private var nowCoordinate: CLLocationCoordinate2D?
    private let coordinator: WeatherCoordinatorProtocol?
    
    init(coordinator: WeatherCoordinatorProtocol) {
        self.coordinator = coordinator
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
    
    func nowLocation() -> CoordRealm? {
        guard let lon = manager.location?.coordinate.longitude, let lat = manager.location?.coordinate.latitude else { return nil }
        return DownloadSaveService.takeCoord(lat: lat, lon: lon)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first else { return }
        let newCoordinate = CLLocationCoordinate2D(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        guard nowCoordinate != newCoordinate else { return }
        nowCoordinate = newCoordinate
        coordinator?.updatePages()
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        print("lhs.latitude: \(lhs.latitude) == rhs.latitude: \(rhs.latitude) lhs.longitude: \(lhs.longitude) == rhs.longitude: \(rhs.longitude)")
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
