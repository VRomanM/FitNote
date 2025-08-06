//
//  Superset.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

struct Superset: Identifiable, Hashable {
    let id: UUID
    var name: String
    var recoveryTime: TimeInterval?
}
