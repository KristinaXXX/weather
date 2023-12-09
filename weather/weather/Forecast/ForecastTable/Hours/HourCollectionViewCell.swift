//
//  HourCollectionViewCell.swift
//  weather
//
//  Created by Kr Qqq on 08.12.2023.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    static let id = "HourCollectionViewCell"
    
    private lazy var timeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular14.font
        return view
    }()
    
    private lazy var temperatureLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
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
    
    func update() {
        timeLabel.text = "12:00"
        temperatureLabel.text = "13"
        weatherIcon.image = .sun
    }
}
