//
//  Exercise.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Exercise: Identifiable {
    let id: UUID
    var name: String
    var measurements: [Measurement] // max 2
    //    var measurementTypes: [MeasurementType] // max 2
}
