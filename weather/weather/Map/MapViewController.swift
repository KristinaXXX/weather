//
//  MapViewController.swift
//  weather
//
//  Created by Kr Qqq on 19.12.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let viewModel: MapViewModel
    
    init(viewModel: MapViewModel, nowCoordinate: CLLocationCoordinate2D? = nil) {
        self.viewModel = viewModel
        self.nowCoordinate = nowCoordinate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.showsUserTrackingButton = true
        view.mapType = .standard
        view.showsUserLocation = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressMap))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    private let manager = CLLocationManager()
    private var nowCoordinate: CLLocationCoordinate2D?
    private let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        setupMap()
    }
    
    private func setupMap() {
        manager.delegate = self
        
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
        mapView.delegate = self
    }
    
    private func setupView() {
    }
    
    func addSubviews() {
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func addAnnotation(latitude: Double, longitude: Double, title: String) {
        let alert = UIAlertController(title: "Новая метка", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields![0].placeholder = "Название метки"
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { [weak self] _ in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = alert.textFields![0].text
            self?.mapView.addAnnotation(annotation)
        }))
        self.present(alert, animated: true)
    }
    
    @objc
    private func pressMap(_ gr: UILongPressGestureRecognizer) {
        let point = gr.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] (placemarks: [CLPlacemark]?, error: Error?) in
            if let placemarks = placemarks {
                for placemark in placemarks {
                    guard let cityName = placemark.locality else { return }
                    self?.viewModel.addLocation(lat: coordinate.latitude, lon: coordinate.longitude, cityName: cityName)
                }
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first else { return }
        nowCoordinate = CLLocationCoordinate2D(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //trackButton.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .tintColor
        renderer.lineWidth = 4.0
        return renderer
    }
}
