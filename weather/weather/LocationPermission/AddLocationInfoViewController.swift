//
//  AddLocationInfoViewController.swift
//  weather
//
//  Created by Kr Qqq on 19.12.2023.
//

import UIKit

class AddLocationInfoViewController: UIViewController {

    private lazy var infoLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = CustomFont.Regular14.font
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        paragraphStyle.alignment = .center
        view.attributedText = NSMutableAttributedString(string: "Чтобы добавить локацию вручную \nнажмите на правую кнопку \nв верхней части экрана", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(infoLabel)
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            //infoLabel.widthAnchor.constraint(equalToConstant: 322),
        ])
    }

}
