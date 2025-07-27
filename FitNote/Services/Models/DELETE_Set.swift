//
//  ExerciseSet.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct DeLete_ExerciseSet: Identifiable {
    let id: UUID
    let exercise: Exercise
    var comment: String?
//    var measurements: [MeasurementType: Measurement] { exercise.measurements }
//    var measurementsValues: [MeasurementType: Double] // вес, время, дистанция, повторения
//    var measurementsValues: [(MeasurementType, Double)]
    var results: [Result]
    var superset: Superset?
    
    var totalWeight: Double {
        results.compactMap { result in
            switch result {
            case .single(let measurement, let value):
                if case .weight = measurement { return value }
                return nil
            case .paired(let measurement1, let value1, let measurement2, let value2):
                if case .weight = measurement1 { return value1 }
                if case .weight = measurement2 { return value2 }
                return nil
            }
        }.reduce(0, +)
    }
}
