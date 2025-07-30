//
//  Measurement.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

enum MeasurementType: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    var localizedValue: String { rawValue.localized() }
    
    case weight = "Weight"
    case time = "Time"
    case distance = "Distance"
    case iterations = "Iterations"
}

enum Measurement: Hashable {
    case weight(unit: WeightUnit, isGravitron: Bool, doubleInStats: Bool)
    case time(unit: TimeUnit, midSignal: Bool)
    case distance(unit: DistanceUnit, activity: ActivityType, syncWithWatch: Bool)
    case iterations
    
    var type: MeasurementType {
        switch self {
        case .weight: return .weight
        case .time: return .time
        case .distance: return .distance
        case .iterations: return .iterations
        }
    }
}

enum WeightUnit: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    var localizedValue: String { rawValue.localized() }
    case kg, lb
}

enum TimeUnit: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    var localizedValue: String { rawValue.localized() }
    case manual, timer, stopwatch
}

enum DistanceUnit: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    var localizedValue: String { rawValue.localized() }
    case km, mile
}

enum ActivityType: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    var localizedValue: String { rawValue.localized() }
    case running, walking, cycling, other
}
