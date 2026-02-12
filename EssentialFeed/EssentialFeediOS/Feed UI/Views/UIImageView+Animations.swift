//
//  UIImageView+Animations.swift
//  EssentialFeediOS
//
//  Created by Нурбол Мухаметжан on 12.02.2026.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
