//
//  DailyForecastFooterView.swift
//  weather
//
//  Created by Kr Qqq on 26.12.2023.
//

import UIKit

class DailyForecastFooterView: UITableViewHeaderFooterView {

    static let id = "DailyForecastFooterView"
    
    private lazy var sunLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular18.font
        view.text = "Долгота дня"
        return view
    }()
    
    private lazy var sunIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .sun
        return imageView
    }()
    
    private lazy var sunValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var sunriseLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.text = "Восход"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var sunsetLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.text = "Закат"
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var sunriseValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var sunsetValueLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular16.font
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(sunLabel)
        addSubview(sunIcon)
        addSubview(sunValueLabel)
        
        addSubview(sunriseLabel)
        addSubview(sunsetLabel)
        
        addSubview(sunriseValueLabel)
        addSubview(sunsetValueLabel)
    }
    
    func update(_ sunDetails: SunDetails) {
        sunValueLabel.text = sunDetails.sunLife
        sunriseValueLabel.text = sunDetails.sunrise
        sunsetValueLabel.text = sunDetails.sunset
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sunLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sunLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            sunIcon.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            sunIcon.leadingAnchor.constraint(equalTo: sunLabel.trailingAnchor, constant: 20),
            sunIcon.widthAnchor.constraint(equalToConstant: 20),
            sunIcon.heightAnchor.constraint(equalToConstant: 23)
        ])
        
        NSLayoutConstraint.activate([
            sunValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sunValueLabel.centerYAnchor.constraint(equalTo: sunIcon.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            sunriseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sunriseLabel.topAnchor.constraint(equalTo: sunIcon.bottomAnchor, constant: 18)
        ])
        
        NSLayoutConstraint.activate([
            sunriseValueLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            sunriseValueLabel.centerYAnchor.constraint(equalTo: sunriseLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sunsetLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            sunsetLabel.centerYAnchor.constraint(equalTo: sunriseLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sunsetValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sunsetValueLabel.centerYAnchor.constraint(equalTo: sunsetLabel.centerYAnchor)
        ])
    }
}
