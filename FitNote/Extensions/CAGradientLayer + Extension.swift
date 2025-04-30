//
//  CAGradientLayer + Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

extension CAGradientLayer {
    
    static func getGradientLayer(colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0.15, 1]
        return gradientLayer
    }
    
    static var backgroundAccentGradient: CAGradientLayer {
        return getGradientLayer(colors: [UIColor.backgroundAccent1.cgColor,
                                         UIColor.backgroundAccent2.cgColor])
    }
    
    static var backgroundAccentActiveGradient: CAGradientLayer {
        return getGradientLayer(colors: [UIColor.backgroundAccentActive1.cgColor,
                                         UIColor.backgroundAccentActive2.cgColor])
    }
    
    static var backgroundAccentOpcityGradient: CAGradientLayer {
        return getGradientLayer(colors: [UIColor.backgroundAccent1.withAlphaComponent(12).cgColor,
                                         UIColor.backgroundAccent2.withAlphaComponent(12).cgColor])
    }
    
    static var backgroundAccentOpcityActiveGradient: CAGradientLayer {
        return getGradientLayer(colors: [UIColor.backgroundAccent1.withAlphaComponent(18).cgColor,
                                         UIColor.backgroundAccent2.withAlphaComponent(18).cgColor])
    }
}
