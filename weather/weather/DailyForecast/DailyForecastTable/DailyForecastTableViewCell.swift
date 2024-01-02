//
//  DailyForecastTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    static let id = "DailyForecastTableViewCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .main
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular30.font
        return view
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Medium18.font
        return view
    }()
    
    private lazy var feelsLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "По ощущениям"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var precipitationLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Осадки"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var windLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Ветер"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var cloudLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Облачность"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var feelsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .thermometer
        return imageView
    }()
    
    private lazy var windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .windLeaf
        return imageView
    }()
    
    private lazy var precipitationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .rainfall
        return imageView
    }()
    
    private lazy var cloudIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .bigCloud
        return imageView
    }()
    
    private lazy var windValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        return view
    }()
    
    private lazy var precipitationValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        return view
    }()
    
    private lazy var cloudValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        return view
    }()
    
    private lazy var feelsValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(weatherLabel)
        
        contentView.addSubview(feelsIcon)
        contentView.addSubview(windIcon)
        contentView.addSubview(precipitationIcon)
        contentView.addSubview(cloudIcon)
        
        contentView.addSubview(feelsLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(precipitationLabel)
        contentView.addSubview(cloudLabel)
        
        contentView.addSubview(feelsValueLabel)
        contentView.addSubview(windValueLabel)
        contentView.addSubview(precipitationValueLabel)
        contentView.addSubview(cloudValueLabel)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            tempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -5),
            weatherIcon.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 26),
            weatherIcon.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 11)
        ])
        
        NSLayoutConstraint.activate([
            feelsIcon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            feelsIcon.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 25),
            feelsIcon.widthAnchor.constraint(equalToConstant: 24),
            feelsIcon.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            windIcon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            windIcon.topAnchor.constraint(equalTo: feelsIcon.bottomAnchor, constant: 25),
            windIcon.widthAnchor.constraint(equalToConstant: 24),
            windIcon.heightAnchor.constraint(equalToConstant: 14)
        ])
        
        NSLayoutConstraint.activate([
            precipitationIcon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            precipitationIcon.topAnchor.constraint(equalTo: windIcon.bottomAnchor, constant: 25),
            precipitationIcon.widthAnchor.constraint(equalToConstant: 24),
            precipitationIcon.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            cloudIcon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            cloudIcon.topAnchor.constraint(equalTo: precipitationIcon.bottomAnchor, constant: 25),
            cloudIcon.widthAnchor.constraint(equalToConstant: 24),
            cloudIcon.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            feelsLabel.leadingAnchor.constraint(equalTo: feelsIcon.trailingAnchor, constant: 15),
            feelsLabel.centerYAnchor.constraint(equalTo: feelsIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 15),
            windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationLabel.leadingAnchor.constraint(equalTo: precipitationIcon.trailingAnchor, constant: 15),
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cloudLabel.leadingAnchor.constraint(equalTo: cloudIcon.trailingAnchor, constant: 15),
            cloudLabel.centerYAnchor.constraint(equalTo: cloudIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feelsValueLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            feelsValueLabel.centerYAnchor.constraint(equalTo: feelsIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            windValueLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            windValueLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationValueLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            precipitationValueLabel.centerYAnchor.constraint(equalTo: precipitationIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cloudValueLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            cloudValueLabel.centerYAnchor.constraint(equalTo: cloudIcon.centerYAnchor)
        ])
    }
    
    func update(forecastDay: ForecastWeatherRealm) {
        
        dayLabel.text = forecastDay.dateTimeForecast.hourInTimeZone(forecastDay.coord?.timezone ?? 0) > 6 ? "День" : "Ночь"
        tempLabel.text = "\(Int(forecastDay.temp))º"
        
        switch forecastDay.mainWeather {
        case "Clouds":
            weatherIcon.image = .bigCloud
        case "Rain":
            weatherIcon.image = .precipitation
        case "Snow":
            weatherIcon.image = UIImage(systemName: "snowflake")?.imageWith(newSize: CGSize(width: 24, height: 24))
        default:
            weatherIcon.image = .sun
        }
        
        weatherLabel.text = forecastDay.descriptionWeather?.uppercasedFirstLetter()
        precipitationValueLabel.text = "\(forecastDay.pop)%"
        cloudValueLabel.text = "\(forecastDay.clouds)%"
        feelsValueLabel.text = "\(Int(forecastDay.feelsLike))º"
        windValueLabel.text = "\(Int(forecastDay.windSpeed)) \(Units(rawValue: forecastDay.unit) == .fahrenheit ? "mph" : "м/с")"
           
        feelsIcon.image = forecastDay.feelsLike < 0 ? .cold : .warm
    }

}
