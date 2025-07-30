//
//  View+Extension.swift
//  FitNote
//
//  Created by Роман Вертячих on 30.07.2025.
//

import SwiftUI

extension View {
    func dismissKeyboard() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
}
