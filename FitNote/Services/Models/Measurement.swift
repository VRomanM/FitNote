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

enum MeasurementParam: Codable {
    case weight(unit: WeightUnit, isGravitron: Bool, doubleInStats: Bool)
    case time(unit: TimeUnit, midSignal: Bool)
    case distance(unit: DistanceUnit, activity: ActivityType, syncWithWatch: Bool)
    case iterations
    
    var displayName: String {
        switch self {
        case .weight(let unit, let isGravitron, let doubleInStats):
            return "Вес (\(unit.rawValue)\(isGravitron ? ", гравитрон" : "")\(doubleInStats ? ", x2" : ""))"
        case .time(let unit, let midSignal):
            return "Время (\(unit.rawValue)\(midSignal ? ", mid" : ""))"
        case .distance(let unit, let activity, let syncWithWatch):
            return "Дистанция (\(unit.rawValue), \(activity.rawValue)\(syncWithWatch ? ", watch" : ""))"
        case .iterations:
            return "Повторения"
        }
    }
}

enum WeightUnit: String, Codable {
    case kg, lb
}

enum TimeUnit: String, Codable {
    case manual, timer, stopwatch
}

enum DistanceUnit: String, Codable {
    case km, mile
}

enum ActivityType: String, Codable {
    case running, walking, cycling, other
}
