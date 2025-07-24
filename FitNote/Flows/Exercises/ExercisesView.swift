//
//  ExercisesView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct ExercisesView: View {
    @State private var showEditExercise = false
    @State private var editingExercise: Exercise? = nil
    
    // Собираем все уникальные упражнения из всех заметок
    private var allExercises: [Exercise] {
        let notes = MocData.allNotes
        let sessions = notes.flatMap { $0.sessions }
        let sessionExercises = sessions.flatMap { $0.exercises }
        let exercises = sessionExercises.map { $0.exercise }
        // Уникальные по id
        return Array(Set(exercises)).sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Кнопка добавить
                Button(action: {
                    editingExercise = nil
                    showEditExercise = true
                }) {
                    Label("Добавить упражнение", systemImage: "plus")
                }
                // Список упражнений с возможностью редактирования
                ForEach(allExercises) { exercise in
                    Button(action: {
                        editingExercise = exercise
                        showEditExercise = true
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.name)
                                .font(.headline)
                            HStack(spacing: 8) {
                                ForEach(exercise.measurementTypes, id: \.self) { type in
                                    Text(type.displayName)
                                        .font(.caption2)
                                        .padding(4)
                                        .background(Capsule().fill(Color.accentColor.opacity(0.15)))
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            // Sheet:
            .sheet(isPresented: $showEditExercise) {
                EditExerciseView(
                    viewModel: EditExerciseViewModel(exercise: editingExercise)
                ) { newOrEditedExercise in
                    // Добавить или обновить в массиве/хранилище
                }
            }
        }
    }
}

// Для уникальности в Set
extension Exercise: Hashable {
    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Для отображения measurementTypes
extension MeasurementType {
    var displayName: String {
        switch self {
        case .weight: return "Вес"
        case .iterations: return "Повторения"
        case .distance: return "Дистанция"
        case .time: return "Время"
        }
    }
}
