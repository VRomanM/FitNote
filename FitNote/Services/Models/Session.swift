//
//  Session.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Session: Identifiable, Hashable {
    enum Status: String {
        case planned
        case started
        case finished
    }
    
    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    var name: String
    var status: Status = .planned {
        didSet {
            switch status {
            case .planned:
                dateStart = nil
                dateFinish = nil
            case .started:
                dateStart = Date()
            case .finished:
                dateFinish = Date()
            }
        }
    }
    var datePlaned: Date
    var dateStart: Date? {
        didSet {
            if let dateStart = dateStart, let dateFinish = dateFinish {
                duration = dateFinish.timeIntervalSince(dateStart)
            }
        }
    }
    var dateFinish: Date? {
        didSet {
            if let dateStart = dateStart, let dateFinish = dateFinish {
                duration = dateFinish.timeIntervalSince(dateStart)
            }
        }
    }
    
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
    
    init(id: UUID, name: String, datePlaned: Date, avgHeartRate: Int?, duration: TimeInterval?, calories: Int, comment: String, sets: [ExerciseSet]) {
        self.id = id
        self.name = name
        self.datePlaned = datePlaned
        self.avgHeartRate = avgHeartRate
        self.duration = duration
        self.calories = calories
        self.comment = comment
        self.sets = sets
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.datePlaned = Date()
        self.calories = 0
        self.comment = ""
        self.sets = [ExerciseSet]()
    }
}
