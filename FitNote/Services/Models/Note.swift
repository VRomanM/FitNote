//
//  Note.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Note: Identifiable {
    let id: UUID
    var date: Date
    var sessions: [Session]
    var comment: String?
}
