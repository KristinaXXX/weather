//
//  WeatherNowView.swift
//  weather
//
//  Created by Kr Qqq on 03.12.2023.
//

import UIKit

class WeatherNowHeaderView: UITableViewHeaderFooterView {
    
    static let id = "WeatherNowHeaderView"
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: .rectangle)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - ICONS -
    private lazy var sunsetIcon: UIImageView = {
        let imageView = UIImageView(image: .sunset.withTintColor(.sun))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sunriseIcon: UIImageView = {
        let imageView = UIImageView(image: .sunrise.withTintColor(.sun))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windLeafIcon: UIImageView = {
        let imageView = UIImageView(image: .windLeaf.withTintColor(.white))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var partlyCloudySunIcon: UIImageView = {
        let imageView = UIImageView(image: .partlyCloudySun)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var precipitationIcon: UIImageView = {
        let imageView = UIImageView(image: .precipitation.withTintColor(.white))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - LABELS -
    private lazy var maxMinTempLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var mainTempLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Medium36.font
        return view
    }()
    
    private lazy var precipitationInfoLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var sunriseTimeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Medium14.font
        return view
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = CustomFont.Medium14.font
        return view
    }()
    
    private lazy var dateTimeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .sun
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var partlyCloudySunLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var windLeafLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var precipitationLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 5
    }
    
    func update(_ currentWeather: CurrentWeatherRealm? = nil) {
        guard let weather = currentWeather else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        maxMinTempLabel.text = "\(Int(weather.tempMin))º / \(Int(weather.tempMax))º"
        mainTempLabel.text = "\(Int(weather.temp))º"
        precipitationInfoLabel.text = weather.descriptionWeather?.uppercasedFirstLetter() ?? ""
        sunriseTimeLabel.text =  weather.sunrise == nil ? "-:-" : dateFormatter.string(from: weather.sunrise!)
        sunsetTimeLabel.text = weather.sunset == nil ? "-:-" : dateFormatter.string(from: weather.sunset!)
        partlyCloudySunLabel.text = "\(weather.clouds)%"
        windLeafLabel.text = "\(Int(weather.windSpeed)) м/с"
        precipitationLabel.text = "\(weather.humidity)%"
        
        dateFormatter.dateFormat = "HH:mm, dd MMMM"
        dateFormatter.locale = .current
        dateTimeLabel.text = dateFormatter.string(from: Date())
    }
    
    private func addSubviews() {
        addSubview(mainImageView)
        
        addSubview(sunsetIcon)
        addSubview(sunriseIcon)
        
        addSubview(maxMinTempLabel)
        addSubview(mainTempLabel)
        addSubview(precipitationInfoLabel)
        addSubview(sunriseTimeLabel)
        addSubview(sunsetTimeLabel)
        addSubview(dateTimeLabel)
        
        addSubview(windLeafIcon)
        addSubview(partlyCloudySunIcon)
        addSubview(precipitationIcon)
        
        addSubview(partlyCloudySunLabel)
        addSubview(windLeafLabel)
        addSubview(precipitationLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            sunriseIcon.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 25),
            sunriseIcon.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 145),
            sunriseIcon.widthAnchor.constraint(equalToConstant: 17),
            sunriseIcon.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            sunsetIcon.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -25),
            sunsetIcon.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 145),
            sunsetIcon.widthAnchor.constraint(equalToConstant: 17),
            sunsetIcon.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            partlyCloudySunIcon.leadingAnchor.constraint(equalTo: sunriseIcon.trailingAnchor, constant: 35),
            partlyCloudySunIcon.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 138),
            partlyCloudySunIcon.widthAnchor.constraint(equalToConstant: 21),
            partlyCloudySunIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            windLeafIcon.leadingAnchor.constraint(equalTo: partlyCloudySunLabel.trailingAnchor, constant: 19),
            windLeafIcon.centerYAnchor.constraint(equalTo: partlyCloudySunIcon.centerYAnchor),
            windLeafIcon.widthAnchor.constraint(equalToConstant: 25),
            windLeafIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            precipitationIcon.trailingAnchor.constraint(equalTo: sunsetIcon.leadingAnchor, constant: -74),
            precipitationIcon.centerYAnchor.constraint(equalTo: partlyCloudySunIcon.centerYAnchor),
            precipitationIcon.widthAnchor.constraint(equalToConstant: 15),
            precipitationIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            sunriseTimeLabel.centerXAnchor.constraint(equalTo: sunriseIcon.centerXAnchor),
            sunriseTimeLabel.topAnchor.constraint(equalTo: sunriseIcon.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            sunsetTimeLabel.centerXAnchor.constraint(equalTo: sunsetIcon.centerXAnchor),
            sunsetTimeLabel.topAnchor.constraint(equalTo: sunsetIcon.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            maxMinTempLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            maxMinTempLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 33)
        ])
        
        NSLayoutConstraint.activate([
            mainTempLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            mainTempLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 58)
        ])
        
        NSLayoutConstraint.activate([
            precipitationInfoLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            precipitationInfoLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 103)
        ])
        
        NSLayoutConstraint.activate([
            dateTimeLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            dateTimeLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 171)
        ])
        
        NSLayoutConstraint.activate([
            partlyCloudySunLabel.leadingAnchor.constraint(equalTo: partlyCloudySunIcon.trailingAnchor, constant: 5),
            partlyCloudySunLabel.centerYAnchor.constraint(equalTo: partlyCloudySunIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            windLeafLabel.leadingAnchor.constraint(equalTo: windLeafIcon.trailingAnchor, constant: 5),
            windLeafLabel.centerYAnchor.constraint(equalTo: windLeafIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationLabel.leadingAnchor.constraint(equalTo: precipitationIcon.trailingAnchor, constant: 5),
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationIcon.centerYAnchor)
        ])
    }
}
