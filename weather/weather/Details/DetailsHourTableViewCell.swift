//
//  DetailsHourTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 22.12.2023.
//

import UIKit

class DetailsHourTableViewCell: UITableViewCell {

    static let id = "DetailsHourTableViewCell"
    
    private lazy var moonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .crescentMoon
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
        imageView.image = .precipitation
        return imageView
    }()
    
    private lazy var cloudIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .bigCloud
        return imageView
    }()
    
    private lazy var precipitationLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Атмосферные осадки"
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
    
    private lazy var windValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var precipitationValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var cloudValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
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
    
    private lazy var moonLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textColor = .black
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Medium18.font
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Medium18.font
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        
        contentView.addSubview(moonIcon)
        contentView.addSubview(windIcon)
        contentView.addSubview(precipitationIcon)
        contentView.addSubview(cloudIcon)
        
        contentView.addSubview(moonLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(precipitationLabel)
        contentView.addSubview(cloudLabel)
        
        contentView.addSubview(windValueLabel)
        contentView.addSubview(precipitationValueLabel)
        contentView.addSubview(cloudValueLabel)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .main
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            timeLabel.widthAnchor.constraint(equalToConstant: 47)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            moonIcon.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 11),
            moonIcon.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            moonIcon.widthAnchor.constraint(equalToConstant: 12),
            moonIcon.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            windIcon.centerXAnchor.constraint(equalTo: moonIcon.centerXAnchor),
            windIcon.topAnchor.constraint(equalTo: moonIcon.bottomAnchor, constant: 16),
            windIcon.widthAnchor.constraint(equalToConstant: 15),
            windIcon.heightAnchor.constraint(equalToConstant: 10.05)
        ])
        
        NSLayoutConstraint.activate([
            precipitationIcon.centerXAnchor.constraint(equalTo: windIcon.centerXAnchor),
            precipitationIcon.topAnchor.constraint(equalTo: windIcon.bottomAnchor, constant: 16),
            precipitationIcon.widthAnchor.constraint(equalToConstant: 11),
            precipitationIcon.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        NSLayoutConstraint.activate([
            cloudIcon.centerXAnchor.constraint(equalTo: precipitationIcon.centerXAnchor),
            cloudIcon.topAnchor.constraint(equalTo: precipitationIcon.bottomAnchor, constant: 16),
            cloudIcon.widthAnchor.constraint(equalToConstant: 14),
            cloudIcon.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            moonLabel.leadingAnchor.constraint(equalTo: moonIcon.trailingAnchor, constant: 5),
            moonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            moonLabel.centerYAnchor.constraint(equalTo: moonIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 5),
            windLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationLabel.leadingAnchor.constraint(equalTo: precipitationIcon.trailingAnchor, constant: 5),
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cloudLabel.leadingAnchor.constraint(equalTo: cloudIcon.trailingAnchor, constant: 5),
            cloudLabel.centerYAnchor.constraint(equalTo: cloudIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            windValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            windValueLabel.centerYAnchor.constraint(equalTo: windIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            precipitationValueLabel.centerYAnchor.constraint(equalTo: precipitationIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cloudValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cloudValueLabel.centerYAnchor.constraint(equalTo: cloudIcon.centerYAnchor)
        ])

    }
    
    func update(forecastDay: ForecastWeatherRealm) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM"
        
        dateLabel.text = dateFormatter.string(from: forecastDay.dateTimeForecast)
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: forecastDay.dateTimeForecast)
        precipitationValueLabel.text = "\(forecastDay.pop)%"
        cloudValueLabel.text = "\(forecastDay.clouds)%"
        moonLabel.text = "\(forecastDay.descriptionWeather?.uppercasedFirstLetter() ?? ""). По ощущению \(Int(forecastDay.feelsLike))º"
        tempLabel.text = "\(Int(forecastDay.temp))º"
        windValueLabel.text = "\(Int(forecastDay.windSpeed)) м/с"
    }
}
