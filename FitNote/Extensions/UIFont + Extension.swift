//
//  UIFont + Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

extension UIFont {
    
    //MARK: - SFProText
    
    static func customSFProText(font: CustomFontSFProText, size: CGFloat) -> UIFont? {
        return UIFont(name: font.rawValue, size: size)
    }
    
    //MARK: - SFProDisplay
    
    static func customSFProDisplay(font: CustomFontSFProDisplay, size: CGFloat) -> UIFont? {
        return UIFont(name: font.rawValue, size: size)
    }
    
    //MARK: - Old. !Need delete!
    
    static func mainFont(size: CGFloat = 15) -> UIFont? {
        return customSFProText(font: .regular, size: size)
    }
    
    static func mainBoldFont(size: CGFloat = 15) -> UIFont? {
        return customSFProText(font: .semibold, size: size)
    }
    
    //MARK: - Title
    
    static var largeTitle: UIFont? {
        return customSFProDisplay(font: .semibold, size: 32)
    }
    
    static var title2: UIFont? {
        return customSFProDisplay(font: .semibold, size: 24)
    }
    
    static var title3: UIFont? {
        return customSFProDisplay(font: .semibold, size: 20)
    }
    
    //MARK: - Headline
    
    static var headline1: UIFont? {
        return customSFProText(font: .semibold, size: 18)
    }
    
    static var headline2: UIFont? {
        return customSFProText(font: .semibold, size: 16)
    }
    
    //MARK: - Body
    
    static var body: UIFont? {
        return customSFProText(font: .regular, size: 16)
    }
    
    static var bodyButton: UIFont? {
        return customSFProText(font: .medium, size: 16)
    }
    
    //MARK: - Subheadline
    
    static var subheadline: UIFont? {
        return customSFProText(font: .semibold, size: 14)
    }
    
    static var subheadlineButton: UIFont? {
        return customSFProText(font: .medium, size: 14)
    }
    
    //MARK: - Callout
    
    static var callout: UIFont? {
        return customSFProText(font: .regular, size: 14)
    }
    
    //MARK: - Footnote
    
    static var footnote1: UIFont? {
        return customSFProText(font: .regular, size: 12)
    }
    
    static var footnote2: UIFont? {
        return customSFProText(font: .medium, size: 12)
    }
    //MARK: - Caption
    
    static var caption: UIFont? {
        return customSFProText(font: .regular, size: 10)
    }
}
