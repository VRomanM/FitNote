//
//  DELETE_NoteRow.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct DELETE_NoteRow: Identifiable {
    let id: UUID
    let name: String
    var date: Date
    var totalWeight: Double { return 0.0 }
    var avgHeartRate: Int?
    var duration: TimeInterval?
    let calories: Int
    var sessions: [Session]
    var comment: String?
}
