//
//  EditExerciseViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

class EditExerciseViewModel: ObservableObject {
    @Published var name: String
    @Published var selectedTypes: Set<MeasurementType>
    @Published var params: String // строка для ручного ввода параметров, если нужно
    @Published var isNew: Bool
    @Published var measurementParams: [MeasurementParam]
    
    var exercise: Exercise?

    init(exercise: Exercise? = nil) {
        self.exercise = exercise
        self.name = exercise?.name ?? ""
        self.selectedTypes = Set(exercise?.measurementTypes ?? [])
        self.measurementParams = exercise?.measurementParams ?? []
        self.params = (exercise?.measurementParams.map { $0.displayName }.joined(separator: ", ") ?? "")
        self.isNew = exercise == nil
    }

    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && !selectedTypes.isEmpty
    }

    func buildExercise() -> Exercise {
        Exercise(
            id: exercise?.id ?? UUID(),
            name: name,
            measurementTypes: Array(selectedTypes),
            measurementParams: measurementParams
        )
    }
}
