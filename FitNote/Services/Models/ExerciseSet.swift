//
//  ExerciseSet.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct ExerciseSet: Identifiable {
    let id: UUID
    var values: [MeasurementType: Double] // вес, время, дистанция, повторения
}
