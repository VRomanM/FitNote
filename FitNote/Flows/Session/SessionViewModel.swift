//
//  SessionViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 30.07.2025.
//

import SwiftUI

@MainActor
class SessionViewModel: ObservableObject {
    @Published var name: String
    @Published var date: Date
    @Published var avgHeartRate: Int?
    @Published var duration: TimeInterval?
    @Published var calories: Int
    @Published var comment: String
    @Published var sets: [ExerciseSetViewModel]
    
    var totalWeight: Double {
        sets.reduce(0) { $0 + $1.totalWeight }
    }
    
    // Для добавления/редактирования
    @Published var isPresentingExercisePicker = false
    @Published var isPresentingSupersetEditor = false
    @Published var isPresentingExerciseSetEditor = false
    @Published var selectedSetIndex: Int?
    
    // Инициализация для новой или существующей сессии
    init(session: Session? = nil) {
        if let session = session {
            self.name = session.name
            self.date = session.date
            self.avgHeartRate = session.avgHeartRate
            self.duration = session.duration
            self.calories = session.calories
            self.comment = session.comment
            self.sets = session.sets.map { ExerciseSetViewModel(set: $0) }
        } else {
            self.name = ""
            self.date = Date()
            self.avgHeartRate = nil
            self.duration = nil
            self.calories = 0
            self.comment = ""
            self.sets = []
        }
    }
    
    func addSet(_ set: ExerciseSet) {
        sets.append(ExerciseSetViewModel(set: set))
    }
    
    func updateSet(_ setVM: ExerciseSetViewModel, at index: Int) {
        sets[index] = setVM
    }
    
    func removeSet(at offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }
    
    func groupSetsToSuperset(indices: [Int], superset: Superset) {
        for idx in indices {
            sets[idx].superset = superset
        }
    }
    
    func saveSession() -> Session {
        Session(
            id: UUID(),
            name: name,
            date: date,
            avgHeartRate: avgHeartRate,
            duration: duration,
            calories: calories,
            comment: comment,
            sets: sets.map { $0.toExerciseSet() }
        )
    }
}
