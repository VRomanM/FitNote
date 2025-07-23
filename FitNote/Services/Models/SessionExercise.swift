//
//  SessionExercise.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct SessionExercise: Identifiable {
    let id: UUID
    let exercise: Exercise
    var sets: [ExerciseSet]
}
