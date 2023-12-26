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
        view.text = "Солнце и Луна"
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
    }
    
    func update() {
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sunLabel.topAnchor.constraint(equalTo: topAnchor),
            sunLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
//        
//        NSLayoutConstraint.activate([
//            countDaysLabel.centerYAnchor.constraint(equalTo: everyDayLabel.centerYAnchor),
//            countDaysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//        ])
    }

}
