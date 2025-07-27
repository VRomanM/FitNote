//
//  Measurement.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

enum MeasurementType: String, CaseIterable, Codable {
    case weight = "weight"
    case time = "time"
    case distance = "distance"
    case iterations = "iterations"
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
    
    var displayName: String {
        switch self {
        case .weight(let unit, let isGravitron, let doubleInStats):
            return "\(unit.rawValue)\(isGravitron ? " gravitron" : "")\(doubleInStats ? " doubleInStats" : "")"
        case .time(let unit, let midSignal):
            return "\(unit)\(midSignal ? ", mid signal" : "")"
        case .distance(let unit, let activity, let syncWithWatch):
            return "\(unit.rawValue), \(activity.rawValue)\(syncWithWatch ? " sync with AppleWatch" : "")"
        case .iterations: return "iterations"
        }
    }
}

enum WeightUnit: String, CaseIterable {
    case kg, lb
}

enum TimeUnit: String, CaseIterable {
    case manual, timer, stopwatch
}

enum DistanceUnit: String, CaseIterable {
    case km, mile
}

enum ActivityType: String, CaseIterable {
    case running, walking, cycling, other
}
