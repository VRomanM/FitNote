//
//  Result.swift
//  FitNote
//
//  Created by Роман Вертячих on 26.07.2025.
//

import Foundation

enum Result: Hashable {
    case single(MeasurementType, Double)
    case paired(MeasurementType, Double, MeasurementType, Double)
}
