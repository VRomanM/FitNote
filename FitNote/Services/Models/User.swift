//
//  User.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String
    static let mock = User(id: UUID(), name: "Роман")
}
