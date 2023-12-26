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
        view.textColor = .systemGray2
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
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            tempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -5),
            weatherIcon.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 26),
            weatherIcon.heightAnchor.constraint(equalToConstant: 32)
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
    }

}
