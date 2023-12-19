//
//  ExtensionUIViewController.swift
//  weather
//
//  Created by Kr Qqq on 07.12.2023.
//

import UIKit
import Foundation

extension UIViewController {

    func createTabButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        guard let imageU = UIImage(systemName: imageName) else { return UIBarButtonItem() }
        
        let button = UIButton()
        
        let newHeight = 20.0
        let newWidth = newHeight*imageU.size.width/imageU.size.height
        
        button.setImage(imageU.imageWith(newSize: CGSize(width: newWidth, height: newHeight)), for: .normal)
        //button.setImage(imageU, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
        
    }
}

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image.withRenderingMode(renderingMode)
    }
}

extension String {
    func uppercasedFirstLetter() -> String {
        prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension Double {
    func roundTwoChar() -> Double {
        return (self * 100).rounded() / 100
    }
}
