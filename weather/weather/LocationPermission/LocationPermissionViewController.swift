//
//  LocationPermissionViewController.swift
//  weather
//
//  Created by Kr Qqq on 02.12.2023.
//

import UIKit

class LocationPermissionViewController: UIViewController {

    // MARK: - Output -
    var onSelectPermission: ((Bool) -> Void)?
    
    // MARK: - UI -
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WeatherIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var permissionLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        view.font = CustomFont.SemiBold16.font
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        paragraphStyle.alignment = .center
        view.attributedText = NSMutableAttributedString(string: "Разрешить приложению Weather использовать данные \nо местоположении вашего устройства ", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = CustomFont.Regular14.font
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        paragraphStyle.alignment = .center
        view.attributedText = NSMutableAttributedString(string: "Чтобы получить более точные прогнозы погоды во время движения или путешествия", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    private lazy var infoSecondLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = CustomFont.Regular14.font
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        paragraphStyle.alignment = .center
        view.attributedText = NSMutableAttributedString(string: "Вы можете изменить свой выбор в любое время из меню приложения", attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    private lazy var accessButton = CustomButton(title: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", buttonAction: ({ self.accessButtonPressed() }), color: .accentButton, font: CustomFont.Medium12.font)
    
    private lazy var notAccessButton = CustomButton(title: "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", buttonAction: ({ self.notAccessButtonPressed() }), color: nil, font: CustomFont.Regular16.font)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .accent        
    }
    
    func addSubviews() {
        view.addSubview(iconImage)
        view.addSubview(permissionLabel)
        view.addSubview(infoLabel)
        view.addSubview(infoSecondLabel)
        view.addSubview(accessButton)
        view.addSubview(notAccessButton)
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            permissionLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            permissionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            permissionLabel.widthAnchor.constraint(equalToConstant: 322),
        ])
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 111),
            iconImage.bottomAnchor.constraint(equalTo: permissionLabel.topAnchor, constant: -56),
            iconImage.heightAnchor.constraint(equalToConstant: 196),
            iconImage.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: permissionLabel.bottomAnchor, constant: 56),
            infoLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalToConstant: 314),
            infoLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            infoSecondLabel.topAnchor.constraint(equalTo: permissionLabel.bottomAnchor, constant: 106),
            infoSecondLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            infoSecondLabel.widthAnchor.constraint(equalToConstant: 314),
            infoSecondLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            accessButton.topAnchor.constraint(equalTo: infoSecondLabel.bottomAnchor, constant: 44),
            accessButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            accessButton.widthAnchor.constraint(equalToConstant: 340),
            accessButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            notAccessButton.topAnchor.constraint(equalTo: accessButton.bottomAnchor, constant: 25),
            notAccessButton.trailingAnchor.constraint(equalTo: accessButton.trailingAnchor),
            notAccessButton.widthAnchor.constraint(equalToConstant: 292),
            notAccessButton.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    func accessButtonPressed() {
        onSelectPermission?(true)
    }
    
    func notAccessButtonPressed() {
        onSelectPermission?(false)
    }
}
