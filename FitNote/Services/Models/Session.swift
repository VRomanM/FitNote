//
//  Session.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Session: Identifiable, Hashable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    var name: String
    var date: Date
    
    var totalWeight: Double {
        sets.reduce(into: 0) { sum, set in
            sum + set.totalWeight
        }
    }
    var avgHeartRate: Int?
    var duration: TimeInterval?
    let calories: Int
    var comment: String
    var sets: [ExerciseSet]
}
