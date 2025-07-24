//
//  MocData.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct MocData {
    static var allNotes: [Note] {
        [
            noteBenchPressAndRunning,
            noteCyclingAndWalking,
            noteOtherCombinations,
            noteWithSupersets
        ]
    }

    // 1. Bench Press + Running (weight+iterations, distance+time)
    static var noteBenchPressAndRunning: Note {
        let exercise1 = Exercise(
            id: UUID(),
            name: "Bench Press",
            measurementTypes: [.weight, .iterations],
            measurementParams: [
                .weight(unit: .kg, isGravitron: false, doubleInStats: false),
                .iterations
            ]
        )
        let exercise2 = Exercise(
            id: UUID(),
            name: "Running",
            measurementTypes: [.distance, .time],
            measurementParams: [
                .distance(unit: .km, activity: .running, syncWithWatch: true),
                .time(unit: .timer, midSignal: false)
            ]
        )
        let set1 = ExerciseSet(
            id: UUID(),
            values: [.weight: 80, .iterations: 10],
        )
        let set2 = ExerciseSet(
            id: UUID(),
            values: [.weight: 85, .iterations: 8],
        )
        let set3 = ExerciseSet(
            id: UUID(),
            values: [.distance: 5, .time: 1500],
        )
        let sessionExercise1 = SessionExercise(
            id: UUID(),
            exercise: exercise1,
            sets: [set1, set2]
        )
        let sessionExercise2 = SessionExercise(
            id: UUID(),
            exercise: exercise2,
            sets: [set3]
        )
        let session1 = Session(
            id: UUID(),
            name: "Morning Workout",
            date: Date(),
            avgHeartRate: 120,
            duration: 3600,
            calories: 500,
            exercises: [sessionExercise1],
            supersets: [Superset]()
        )
        let session2 = Session(
            id: UUID(),
            name: "Evening Cardio",
            date: Date().addingTimeInterval(-86400),
            avgHeartRate: 135,
            duration: 1800,
            calories: 300,
            exercises: [sessionExercise2],
            supersets: [Superset]()
        )
        return Note(
            id: UUID(),
            date: Date(),
            sessions: [session1, session2],
            comment: "Bench + бег. Утро и вечер."
        )
    }

    // 2. Cycling (distance+time+activity), Walking (distance+time), Gravitron Pull-up (weight+iterations+gravitron)
    static var noteCyclingAndWalking: Note {
        let cycling = Exercise(
            id: UUID(),
            name: "Cycling",
            measurementTypes: [.distance, .time],
            measurementParams: [
                .distance(unit: .mile, activity: .cycling, syncWithWatch: false),
                .time(unit: .stopwatch, midSignal: true)
            ]
        )
        let walking = Exercise(
            id: UUID(),
            name: "Walking",
            measurementTypes: [.distance, .time],
            measurementParams: [
                .distance(unit: .km, activity: .walking, syncWithWatch: false),
                .time(unit: .manual, midSignal: false)
            ]
        )
        let gravitron = Exercise(
            id: UUID(),
            name: "Gravitron Pull-up",
            measurementTypes: [.weight, .iterations],
            measurementParams: [
                .weight(unit: .kg, isGravitron: true, doubleInStats: true),
                .iterations
            ]
        )
        let cyclingSet = ExerciseSet(
            id: UUID(),
            values: [.distance: 12.5, .time: 3200],
        )
        let walkingSet = ExerciseSet(
            id: UUID(),
            values: [.distance: 3.2, .time: 1800]
        )
        let gravitronSet = ExerciseSet(
            id: UUID(),
            values: [.weight: 40, .iterations: 12]
        )
        let sessionExercise1 = SessionExercise(
            id: UUID(),
            exercise: cycling,
            sets: [cyclingSet]
        )
        let sessionExercise2 = SessionExercise(
            id: UUID(),
            exercise: walking,
            sets: [walkingSet]
        )
        let sessionExercise3 = SessionExercise(
            id: UUID(),
            exercise: gravitron,
            sets: [gravitronSet]
        )
        let session = Session(
            id: UUID(),
            name: "Outdoor Activities",
            date: Date().addingTimeInterval(-2 * 86400),
            avgHeartRate: 110,
            duration: 5400,
            calories: 700,
            exercises: [sessionExercise1, sessionExercise2, sessionExercise3],
            supersets: [Superset]()
        )
        return Note(
            id: UUID(),
            date: Date().addingTimeInterval(-2 * 86400),
            sessions: [session],
            comment: "Велосипед, прогулка, гравитрон."
        )
    }

    // 3. Все MeasurementType по одному: только вес, только время, только дистанция, только повторения
    static var noteOtherCombinations: Note {
        let weightOnly = Exercise(
            id: UUID(),
            name: "Dumbbell Curl",
            measurementTypes: [.weight],
            measurementParams: [
                .weight(unit: .lb, isGravitron: false, doubleInStats: false)
            ]
        )
        let timeOnly = Exercise(
            id: UUID(),
            name: "Plank",
            measurementTypes: [.time],
            measurementParams: [
                .time(unit: .stopwatch, midSignal: false)
            ]
        )
        let distanceOnly = Exercise(
            id: UUID(),
            name: "Rowing",
            measurementTypes: [.distance],
            measurementParams: [
                .distance(unit: .km, activity: .other, syncWithWatch: false)
            ]
        )
        let repsOnly = Exercise(
            id: UUID(),
            name: "Push-ups",
            measurementTypes: [.iterations],
            measurementParams: [
                .iterations
            ]
        )
        let setWeight = ExerciseSet(
            id: UUID(),
            values: [.weight: 22.5]
        )
        let setTime = ExerciseSet(
            id: UUID(),
            values: [.time: 90]
        )
        let setDistance = ExerciseSet(
            id: UUID(),
            values: [.distance: 1.2]
        )
        let setReps = ExerciseSet(
            id: UUID(),
            values: [.iterations: 30]
        )
        let session = Session(
            id: UUID(),
            name: "Single Type Session",
            date: Date().addingTimeInterval(-3 * 86400),
            avgHeartRate: 100,
            duration: 1800,
            calories: 200,
            exercises: [
                SessionExercise(id: UUID(), exercise: weightOnly, sets: [setWeight]),
                SessionExercise(id: UUID(), exercise: timeOnly, sets: [setTime]),
                SessionExercise(id: UUID(), exercise: distanceOnly, sets: [setDistance]),
                SessionExercise(id: UUID(), exercise: repsOnly, sets: [setReps])
            ],
            supersets: [Superset]()
        )
        return Note(
            id: UUID(),
            date: Date().addingTimeInterval(-3 * 86400),
            sessions: [session],
            comment: "Каждое упражнение — свой тип измерения."
        )
    }
    
    // 4. Пример с суперсетами
    static var noteWithSupersets: Note {
        // Обычные упражнения
        let squat = Exercise(
            id: UUID(),
            name: "Squat",
            measurementTypes: [.weight, .iterations],
            measurementParams: [
                .weight(unit: .kg, isGravitron: false, doubleInStats: false),
                .iterations
            ]
        )
        let squatSet = ExerciseSet(
            id: UUID(),
            values: [.weight: 100, .iterations: 8]
        )
        let squatSessionExercise = SessionExercise(
            id: UUID(),
            exercise: squat,
            sets: [squatSet]
        )
        
        // Суперсет: подтягивания + отжимания
        let pullup = Exercise(
            id: UUID(),
            name: "Pull-up",
            measurementTypes: [.iterations],
            measurementParams: [
                .iterations
            ]
        )
        let pushup = Exercise(
            id: UUID(),
            name: "Push-up",
            measurementTypes: [.iterations],
            measurementParams: [
                .iterations
            ]
        )
        let pullupSet = ExerciseSet(
            id: UUID(),
            values: [.iterations: 12]
        )
        let pushupSet = ExerciseSet(
            id: UUID(),
            values: [.iterations: 20]
        )
        let pullupSessionExercise = SessionExercise(
            id: UUID(),
            exercise: pullup,
            sets: [pullupSet]
        )
        let pushupSessionExercise = SessionExercise(
            id: UUID(),
            exercise: pushup,
            sets: [pushupSet]
        )
        
        // Суперсет как группа
        let superset1 = Superset(
            id: UUID(),
            exercises: [pullupSessionExercise, pushupSessionExercise],
            order: 1,
            comment: "Суперсет: подтягивания + отжимания без отдыха"
        )
        
        // Сессия с обычным упражнением и суперсетом
        let session = Session(
            id: UUID(),
            name: "Superset Session",
            date: Date().addingTimeInterval(-4 * 86400),
            avgHeartRate: 125,
            duration: 2700,
            calories: 400,
            exercises: [squatSessionExercise], // одиночные
            supersets: [superset1]             // суперсеты
        )
        
        return Note(
            id: UUID(),
            date: Date().addingTimeInterval(-4 * 86400),
            sessions: [session],
            comment: "Тренировка с суперсетом: подтягивания и отжимания подряд."
        )
    }
}
