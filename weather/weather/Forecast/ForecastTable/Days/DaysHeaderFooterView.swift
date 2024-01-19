//
//  DaysHeaderFooterView.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import UIKit

class DaysHeaderFooterView: UITableViewHeaderFooterView {

    static let id = "DaysHeaderFooterView"
    
    private lazy var everyDayLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Medium18.font
        view.text = "Ежедневный прогноз"
        return view
    }()
    
    private lazy var countDaysLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular16.font
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(string: "25 дней", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        addSubview(everyDayLabel)
        addSubview(countDaysLabel)
        countDaysLabel.isHidden = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            everyDayLabel.topAnchor.constraint(equalTo: topAnchor),
            everyDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            countDaysLabel.centerYAnchor.constraint(equalTo: everyDayLabel.centerYAnchor),
            countDaysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
