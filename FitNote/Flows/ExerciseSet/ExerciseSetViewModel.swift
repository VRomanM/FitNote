//
//  ExerciseSetViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 30.07.2025.
//

import SwiftUI

final class ExerciseSetViewModel: ObservableObject, Identifiable {
    let id: UUID
    @Published var exercise: Exercise
    @Published var comment: String?
    @Published var results: [Result]
    @Published var restTimes: [TimeInterval] // между результатами
    @Published var superset: Superset?
    @Published var restAfterSet: TimeInterval? // между сетами

    var totalWeight: Double {
        results.compactMap {
            switch $0 {
            case .single(let type, let value):
                return type == .weight ? value : nil
            case .paired(let t1, let v1, let t2, let v2):
                if t1 == .weight { return v1 }
                if t2 == .weight { return v2 }
                return nil
            }
        }.reduce(0, +)
    }
    
    init(set: ExerciseSet) {
        self.id = set.id
        self.exercise = set.exercise
        self.comment = set.comment
        self.results = set.results
        self.superset = set.superset
        self.restTimes = Array(repeating: 0, count: set.results.count - 1)
        self.restAfterSet = nil
    }
    
    func toExerciseSet() -> ExerciseSet {
        ExerciseSet(
            id: id,
            exercise: exercise,
            comment: comment,
            results: results,
            superset: superset
        )
    }
}
