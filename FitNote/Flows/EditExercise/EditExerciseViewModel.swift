//
//  EditExerciseViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

class EditExerciseViewModel: ObservableObject {
    @Published var name: String
//    @Published var selectedTypes: ExerciseSet<Measurement>
    @Published var params: String // строка для ручного ввода параметров, если нужно
    @Published var isNew: Bool
    @Published var measurement: [Measurement]
    
    var exercise: Exercise?

    init(exercise: Exercise? = nil) {
        self.exercise = exercise
        self.name = exercise?.name ?? ""
//        self.selectedTypes = ExerciseSet(exercise?.measurements ?? [])
        self.measurement = exercise?.measurements ?? []
        self.params = (exercise?.measurements.map { $0.displayName }.joined(separator: ", ") ?? "")
        self.isNew = exercise == nil
    }

//    var isValid: Bool {
//        !name.trimmingCharacters(in: .whitespaces).isEmpty && !selectedTypes.isEmpty
//    }

//    func buildExercise() -> Exercise {
//        Exercise(
//            id: exercise?.id ?? UUID(),
//            name: name,
//            measurementTypes: Array(selectedTypes),
//            measurementParams: measurementParams
//        )
//    }
}
