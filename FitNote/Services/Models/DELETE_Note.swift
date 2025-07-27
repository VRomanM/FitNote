//
//  Note.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Delete_Note: Identifiable {
    let id: UUID
    var date: Date
    var sessions: [DELETE_NoteRow]
    var comment: String?
}
