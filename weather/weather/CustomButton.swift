//
//  CustomButton.swift
//  weather
//
//  Created by Kr Qqq on 03.12.2023.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

    typealias Action = () -> Void
        
    private let buttonAction: Action
    
    init(title: String, buttonAction: @escaping Action, color: UIColor?, font: UIFont?) {
        
        self.buttonAction = buttonAction
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        titleLabel?.font = font
        backgroundColor = color
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        buttonAction()
    }
}

enum CustomFont {
    case Regular12
    case Regular14
    case Regular16
    case Regular18
    case SemiBold16
    case Medium12
    case Medium14
    case Medium18
    case Medium36
    
    var font: UIFont? {
        switch self {
        case .Regular14:
            UIFont(name: "Rubik-Regular", size: 14)
        case .Regular16:
            UIFont(name: "Rubik-Regular", size: 16)
        case .SemiBold16:
            UIFont(name: "Rubik-SemiBold", size: 16)
        case .Medium12:
            UIFont(name: "Rubik-Medium", size: 12)
        case .Medium36:
            UIFont(name: "Rubik-Medium", size: 36)
        case .Medium14:
            UIFont(name: "Rubik-Medium", size: 14)
        case .Medium18:
            UIFont(name: "Rubik-Medium", size: 18)
        case .Regular12:
            UIFont(name: "Rubik-Medium", size: 12)
        case .Regular18:
            UIFont(name: "Rubik-Medium", size: 18)
        }
    }
}
