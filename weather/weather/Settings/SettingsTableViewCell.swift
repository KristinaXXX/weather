//
//  SettingsTableViewCell.swift
//  weather
//
//  Created by Kr Qqq on 31.12.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let id = "SettingsTableViewCell"
    private var setting: Settings?
    weak var delegate: SettingsViewControllerDelegate?
    private var valuesSetting: [Units] = []
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.Regular16.font
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var switchControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = .accent
        segmentedControl.backgroundColor = .clear

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: CustomFont.Regular16.font!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: CustomFont.Regular16.font!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return segmentedControl
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(switchControl)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            switchControl.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            switchControl.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            switchControl.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .main
    }
    
    func update(_ setting: Settings) {
        valuesSetting.removeAll()
        switchControl.removeAllSegments()
        self.setting = setting
        
        let typeSetting = TypeSettings(rawValue: setting.typeSetting)
        switch typeSetting {
        case .temperature:
            insertSegment(value: Units.celsius)
            insertSegment(value: Units.fahrenheit)
        case .windSpeed:
            insertSegment(value: Units.miles)
            insertSegment(value: Units.kilometers)
        case .formatTime:
            insertSegment(value: Units.hours12)
            insertSegment(value: Units.hours24)
        case .none:
            return
        }
        nameLabel.text = setting.title
        guard let value = Units(rawValue: setting.value), let selected = valuesSetting.firstIndex(of: value) else { return }
        switchControl.selectedSegmentIndex = selected
    }
    
    private func insertSegment(value: Units) {
        switchControl.insertSegment(withTitle: value.rawValue, at: valuesSetting.count, animated: true)
        valuesSetting.append(value)
    }
    
    @objc private func pageControlValueChanged() {
        setting?.value = valuesSetting[switchControl.selectedSegmentIndex].rawValue
        delegate?.updateSetting(setting!)
    }
}
