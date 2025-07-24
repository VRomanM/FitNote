//
//  Superset.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

struct Superset: Identifiable {
    let id: UUID
    var exercises: [SessionExercise]
    var order: Int // если нужно несколько суперсетов в сессии
    var comment: String?
}
