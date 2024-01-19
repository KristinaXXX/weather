//
//  HourCollectionViewCell.swift
//  weather
//
//  Created by Kr Qqq on 08.12.2023.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    static let id = "HourCollectionViewCell"
    weak var hoursTableViewCellDelegate: HoursTableViewCellDelegate?
    
    private lazy var timeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var temperatureLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    private func addSubviews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(temperatureLabel)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        let tapView = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        contentView.addGestureRecognizer(tapView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37),
            weatherIcon.widthAnchor.constraint(equalToConstant: 16),
            weatherIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 57)
        ])
    }
    
    func update(forecastHour: ForecastWeatherRealm, formatTime: Units) {
        
        let timezone = forecastHour.coord?.timezone ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.dateFormat = formatTime == .hours24 ? "HH:mm" : "h:mm"
        
        timeLabel.text = dateFormatter.string(from: forecastHour.dateTimeForecast)
        temperatureLabel.text = "\(Int(forecastHour.temp))º"
        
        switch forecastHour.mainWeather {
        case "Clouds":
            weatherIcon.image = .bigCloud
        case "Rain":
            weatherIcon.image = .precipitation
        case "Snow":
            weatherIcon.image = UIImage(systemName: "snowflake")?.imageWith(newSize: CGSize(width: 24, height: 24))
        default:
            weatherIcon.image = .sun
        }
        
        let selectHour = Double(forecastHour.dateTimeForecast.hourInTimeZone(timezone))
        let nowHour = Double(Date().hourInTimeZone(timezone))
        let range = selectHour - 1.5 ..< selectHour + 1.5
        if range.contains(nowHour) && forecastHour.dateTimeForecast.dayInTimeZone(timezone) == Date().dayInTimeZone(timezone) {
            contentView.backgroundColor = .accent
            timeLabel.textColor = .white
            temperatureLabel.textColor = .white
        } else {
            contentView.backgroundColor = .white
            timeLabel.textColor = .black
            temperatureLabel.textColor = .systemGray2
        }
    }
    
    @objc
    private func didTapView() {
        hoursTableViewCellDelegate?.showDetails()
    }
}

extension HourCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hoursTableViewCellDelegate?.showDetails()
    }
}
