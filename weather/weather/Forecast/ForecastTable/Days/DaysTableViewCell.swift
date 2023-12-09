//
//  DaysTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 08.12.2023.
//

import UIKit

class DaysTableViewCell: UITableViewCell {

    static let id = "DaysTableViewCell"

    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView(image: .next.withTintColor(.black))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nextIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapNextIcon))
        imageView.addGestureRecognizer(gr)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var dateTimeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray2
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var precipitationLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .accent
        view.font = CustomFont.Regular12.font
        return view
    }()
    
    private lazy var precipitationInfoLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.numberOfLines = 1
        view.font = CustomFont.Regular16.font
        return view
    }()
    
    private lazy var maxMinTempLabel: UILabel = {
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
        contentView.addSubview(weatherIcon)
        contentView.addSubview(dateTimeLabel)
        contentView.addSubview(precipitationLabel)
        contentView.addSubview(precipitationInfoLabel)
        contentView.addSubview(maxMinTempLabel)
        contentView.addSubview(nextIcon)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .main
        contentView.layer.cornerRadius = 5
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.leadingAnchor.constraint(equalTo: dateTimeLabel.leadingAnchor),
            weatherIcon.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 4.68),
            weatherIcon.widthAnchor.constraint(equalToConstant: 15),
            weatherIcon.heightAnchor.constraint(equalToConstant: 17.08)
        ])
        
        NSLayoutConstraint.activate([
            precipitationLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 5),
            precipitationLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            precipitationInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            precipitationInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66)
        ])
        
        NSLayoutConstraint.activate([
            maxMinTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            maxMinTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
        ])
        
        NSLayoutConstraint.activate([
            nextIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nextIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nextIcon.widthAnchor.constraint(equalToConstant: 6),
            nextIcon.heightAnchor.constraint(equalToConstant: 9.5)
        ])
    }
    
    func update() {
        dateTimeLabel.text = "18/04"
        precipitationLabel.text = "57%"
        precipitationInfoLabel.text = "Местами дождь"
        maxMinTempLabel.text = "4º-11º"
        weatherIcon.image = .sun
    }
    
    @objc
    private func tapNextIcon() {
        print("tapNextIcon")
    }
}
