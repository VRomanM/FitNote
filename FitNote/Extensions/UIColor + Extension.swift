//
//  UIColor + Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    //MARK: - Background
    
    static var backgroundPrimary: UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    static var backgroundSecondary: UIColor {
        return UIColor(hexString: "#F0F1F3")
    }
    
    static var backgroundSecondaryActive: UIColor {
        return UIColor(hexString: "#E3E5E8")
    }
    
    static var backgroundBorder: UIColor {
        return UIColor(hexString: "#CCD0D6")
    }
    
    static var backgroundAccent1: UIColor {
        return UIColor(hexString: "#FF324A")
    }
    
    static var backgroundAccent2: UIColor {
        return UIColor(hexString: "#FF4941")
    }
    
    static var backgroundAccentActive1: UIColor {
        return UIColor(hexString: "#F0233B")
    }
    
    static var backgroundAccentActive2: UIColor {
        return UIColor(hexString: "#EF3931")
    }
    
    //MARK: - Text
    
    static var textPrimary: UIColor {
        return UIColor(hexString: "#001530")
    }
    
    static var textSecondary: UIColor {
        return UIColor(hexString: "#4D5C6E")
    }
    
    static var textTertiary: UIColor {
        return UIColor(hexString: "#99A1AC")
    }
    
    static var textWhite: UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    static var textWhiteOpacity: UIColor {
        return UIColor(hexString: "#FFFFFF", alpha: 0.7)
    }
    
    static var textNegative: UIColor {
        return UIColor(hexString: "#DD273D")
    }
    
    static var textPositive: UIColor {
        return UIColor(hexString: "#00B92D")
    }
    
    static var textLink: UIColor {
        return UIColor(hexString: "#428BF9")
    }
}
