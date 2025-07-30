//
//  MocData.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct MocData {
    static var sessions: [Session] {
        [
            sessionBenchPressAndRunning,
            sessionCyclingAndWalking,
            sessionOtherCombinations,
            sessionWithSupersets
        ]
    }

    static var exerciseSet: ExerciseSet {
        let exercise1 = Exercise(
            id: UUID(),
            name: "Bench Press",
            measurements: [
                .weight(unit: .kg, isGravitron: false, doubleInStats: false),
                .iterations
            ]
        )
        let set1 = ExerciseSet(
            id: UUID(),
            exercise: exercise1,
            comment: "hard workout",
            results: [
                .paired(.weight, 80, .iterations, 10),
                .paired(.weight, 82, .iterations, 12),
                .paired(.weight, 84, .iterations, 14)
            ]
        )
        return set1
    }
    
    // 1. Bench Press + Running (weight+iterations, distance+time)
    static var sessionBenchPressAndRunning: Session {
//        let exercise1 = Exercise(
//            id: UUID(),
//            name: "Bench Press",
//            measurements: [
//                .weight(unit: .kg, isGravitron: false, doubleInStats: false),
//                .iterations
//            ]
//        )
        
        let exercise2 = Exercise(
            id: UUID(),
            name: "Running",
            measurements: [
                .distance(unit: .km, activity: .running, syncWithWatch: true),
                .time(unit: .timer, midSignal: false)
            ]
        )
//        let set1 = ExerciseSet(
//            id: UUID(),
//            exercise: exercise1,
//            comment: "hard workout",
//            results: [
//                .paired(.weight, 80, .iterations, 10),
//                .paired(.weight, 82, .iterations, 12),
//                .paired(.weight, 84, .iterations, 14)
//            ]
//        )
        let set1 = exerciseSet
        let set2 = ExerciseSet(
            id: UUID(),
            exercise: exercise2,
            comment: "fast run",
            results: [
                .paired(.distance, 5, .time, 1500),
                .paired(.distance, 5, .time, 1500)
            ]
        )

        return Session(
            id: UUID(),
            name: "Morning Workout",
            date: Date(),
            avgHeartRate: 110,
            duration: TimeInterval(100),
            calories: 300,
            comment: "Жим лёжа, бег",
            sets: [set1, set2]
        )
    }

    // 2. Cycling (distance+time+activity), Walking (distance+time), Gravitron Pull-up (weight+iterations+gravitron)
    static var sessionCyclingAndWalking: Session {
        let cycling = Exercise(
            id: UUID(),
            name: "Cycling",
//            measurementTypes: [.distance, .time],
            measurements: [
                .distance(unit: .mile, activity: .cycling, syncWithWatch: false),
                .time(unit: .stopwatch, midSignal: true)
            ]
        )
        let walking = Exercise(
            id: UUID(),
            name: "Walking",
//            measurementTypes: [.distance, .time],
            measurements: [
                .distance(unit: .km, activity: .walking, syncWithWatch: false),
                .time(unit: .manual, midSignal: false)
            ]
        )
        let gravitron = Exercise(
            id: UUID(),
            name: "Gravitron Pull-up",
//            measurementTypes: [.weight, .iterations],
            measurements: [
                .weight(unit: .kg, isGravitron: true, doubleInStats: true),
                .iterations
            ]
        )
        let set1 = ExerciseSet(
            id: UUID(),
            exercise: cycling,
            comment: "hard cycling",
            results: [
                .paired(.distance, 12.5, .time, 3200),
                .paired(.distance, 12.5, .time, 3200),
                .paired(.distance, 12.5, .time, 3200)
            ]
        )
        
        let set2 = ExerciseSet(
            id: UUID(),
            exercise: walking,
            comment: "light wlaking",
            results: [
                .paired(.distance, 3.2, .time, 1800),
                .paired(.distance, 3.2, .time, 2000),
                .paired(.distance, 3.2, .time, 2100)
            ]
        )
        
        let set3 = ExerciseSet(
            id: UUID(),
            exercise: gravitron,
            comment: "hard gravitron",
            results: [
                .paired(.weight, 40, .iterations, 12),
                .paired(.weight, 45, .iterations, 12),
                .paired(.weight, 50, .iterations, 12)
            ]
        )
        
        return Session(
            id: UUID(),
            name: "Outdoor Activities",
            date: Date(),
            avgHeartRate: 135,
            duration: TimeInterval(100),
            calories: 700,
            comment: "Велосипед, прогулка, гравитрон.",
            sets: [set1, set2, set3]
        )
    }

    // 3. Все MeasurementType по одному: только вес, только время, только дистанция, только повторения
    static var sessionOtherCombinations: Session {
        let weightOnly = Exercise(
            id: UUID(),
            name: "Dumbbell Curl",
//            measurementTypes: [.weight],
            measurements: [
                .weight(unit: .lb, isGravitron: false, doubleInStats: true)
            ]
        )
        let timeOnly = Exercise(
            id: UUID(),
            name: "Plank",
//            measurementTypes: [.time],
            measurements: [
                .time(unit: .stopwatch, midSignal: false)
            ]
        )
        let distanceOnly = Exercise(
            id: UUID(),
            name: "Rowing",
//            measurementTypes: [.distance],
            measurements: [
                .distance(unit: .km, activity: .other, syncWithWatch: false)
            ]
        )
        let repsOnly = Exercise(
            id: UUID(),
            name: "Push-ups",
//            measurementTypes: [.iterations],
            measurements: [
                .iterations
            ]
        )
        let set1 = ExerciseSet(
            id: UUID(),
            exercise: weightOnly,
            comment: "hard Dumbbell Curl",
            results: [
                .single(.weight, 12.5),
                .single(.weight, 14),
                .single(.weight, 15.5),
            ]
        )
        
        let set2 = ExerciseSet(
            id: UUID(),
            exercise: timeOnly,
            comment: "hard Plank",
            results: [
                .single(.time, 1800),
                .single(.time, 2000),
                .single(.time, 2100)
            ]
        )
        
        let set3 = ExerciseSet(
            id: UUID(),
            exercise: distanceOnly,
            comment: "hard Rowing",
            results: [
                .single(.distance, 10),
                .single(.distance, 12),
                .single(.distance, 14)
            ]
        )
        let set4 = ExerciseSet(
            id: UUID(),
            exercise: repsOnly,
            comment: "hard Push-ups",
            results: [
                .single(.iterations, 100),
                .single(.iterations, 120),
                .single(.iterations, 140)
            ]
        )
        
        return Session(
            id: UUID(),
            name: "Single Type Session",
            date: Date().addingTimeInterval(-3 * 86400),
            avgHeartRate: 110,
            duration: TimeInterval(100),
            calories: 900,
            comment: "Каждое упражнение — свой тип измерения.",
            sets: [set1, set2, set3, set4]
        )
    }
    
    // 4. Пример с суперсетами
    static var sessionWithSupersets: Session {
        // Обычные упражнения
        let squat = Exercise(
            id: UUID(),
            name: "Squat",
//            measurementTypes: [.weight, .iterations],
            measurements: [
                .weight(unit: .kg, isGravitron: false, doubleInStats: false),
                .iterations
            ]
        )
        
        let set1 = ExerciseSet(
            id: UUID(),
            exercise: squat,
            comment: "Hard Squat",
            results: [
                .paired(.weight, 100, .iterations, 8),
                .paired(.weight, 100, .iterations, 8),
                .paired(.weight, 100, .iterations, 8),
                .paired(.weight, 100, .iterations, 10)
            ]
        )
        
        let superset = Superset(id: UUID(), name: "Суперсет: подтягивания + отжимания", recoveryTime: TimeInterval(100))
        
        let pullup = Exercise(
            id: UUID(),
            name: "Pull-up",
//            measurementTypes: [.iterations],
            measurements: [
                .iterations
            ]
        )
        let pushup = Exercise(
            id: UUID(),
            name: "Push-up",
//            measurementTypes: [.iterations],
            measurements: [
                .iterations
            ]
        )
        
        let set2 = ExerciseSet(
            id: UUID(),
            exercise: pullup,
            comment: "fast Pull-ups",
            results: [
                .single(.iterations, 12)
            ],
            superset: superset
        )
        let set3 = ExerciseSet(
            id: UUID(),
            exercise: pushup,
            comment: "fast Push-ups",
            results: [
                .single(.iterations, 20)
            ],
            superset: superset
        )
        
        return Session(
            id: UUID(),
            name: "Single Type Session",
            date: Date().addingTimeInterval(-3 * 86400),
            avgHeartRate: 110,
            duration: TimeInterval(100),
            calories: 900,
            comment: "Сессия с обычным упражнением и суперсетом.",
            sets: [set1, set2, set3]
        )
    }
}
