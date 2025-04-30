//
//  String + Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
