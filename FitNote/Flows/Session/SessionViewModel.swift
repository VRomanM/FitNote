//
//  SessionViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 30.07.2025.
//

import SwiftUI

@MainActor
class SessionViewModel: ObservableObject {
    @Published var session: Session
    
    
//    @Published var name: String
//    @Published var datePlaned: Date
//    @Published var avgHeartRate: Int?
//    @Published var duration: TimeInterval?
//    @Published var calories: Int
//    @Published var comment: String
    @Published var sets: [ExerciseSetViewModel]
    
    var totalWeight: Double {
        sets.reduce(0) { $0 + $1.totalWeight }
    }
    
    @Published var isPresentingExercisePicker = false
    @Published var isPresentingSupersetEditor = false
    @Published var isPresentingExerciseSetEditor = false
    @Published var selectedSetIndex: Int?
    
    init(session: Session? = nil) {
        if let session = session {
            self.session = session
            self.sets = session.sets.map { ExerciseSetViewModel(set: $0) }
        } else {
            self.session = Session()
            self.sets = [ExerciseSetViewModel]()
        }
        
//        if let session = session {
//            self.name = session.name
//            self.datePlaned = session.datePlaned
//            self.avgHeartRate = session.avgHeartRate
//            self.duration = session.duration
//            self.calories = session.calories
//            self.comment = session.comment
//            self.sets = session.sets.map { ExerciseSetViewModel(set: $0) }
//        } else {
//            self.name = ""
//            self.datePlaned = Date()
//            self.avgHeartRate = nil
//            self.duration = nil
//            self.calories = 0
//            self.comment = ""
//            self.sets = []
//        }
    }
    
    func addSet(_ set: ExerciseSet) {
        sets.append(ExerciseSetViewModel(set: set))
    }
    
    func addSet(for exercise: Exercise) {
        var results = [Result]()
        
        if exercise.measurements.count == 1 {
            results.append(.single(exercise.measurements[0].type, 0))
        } else if exercise.measurements.count == 2 {
            results.append(.paired(exercise.measurements[0].type, 0, exercise.measurements[1].type, 0))
        } else {
            print("Exercise \(exercise.name) has more than 2 measurements")
        }
        
        
        sets.append(ExerciseSetViewModel(
            set: ExerciseSet(
                id: UUID(),
                exercise: exercise,
                results: results)))
//                results: [
//                    .paired(.weight, 80, .iterations, 20)
//                         ])))
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
    
//    func saveSession() -> Session {
//        Session(
//            id: UUID(),
//            name: name,
//            datePlaned: datePlaned,
//            avgHeartRate: avgHeartRate,
//            duration: duration,
//            calories: calories,
//            comment: comment,
//            sets: sets.map { $0.toExerciseSet() }
//        )
//    }
}
