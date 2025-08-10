//
//  TimeInterval+Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 31.07.2025.
//

import Foundation

extension TimeInterval {
    func formattedTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "\(Int(self))"
    }
    
    func formattedAsMinutes() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "\(Int(self))"
    }
}
