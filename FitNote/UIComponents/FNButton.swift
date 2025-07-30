//
//  FNButton.swift
//  FitNote
//
//  Created by Роман Вертячих on 28.07.2025.
//

import SwiftUI

struct FNButton: View {
    let text: String
    var background: Color = Color.accentColor
    var action: () -> Void


    var body: some View {
        Button(action: action ) {
            Label(text.localized(), systemImage: "plus")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(background)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .padding()
        .background(Material.ultraThin)
        .shadow(radius: 10)
    }
}

#Preview {
    FNButton(text: "Test", action: {})
}
