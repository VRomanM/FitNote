//
//  ExercisesView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

@MainActor
struct ExercisesView: View {
    @Environment(\.dismiss) var dismiss
    
    private enum ExerciseRoute: Hashable {
        case detail(exercise: Exercise?)
    }
    
    @State private var navigationPath = NavigationPath()
    @StateObject private var viewModel = ExercisesViewModel()
    let forSelection: Bool
    var onSelection: ((Exercise) -> Void)?
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading exercises...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text("Error")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        Button("Repeat") {
                            Task {
                                await viewModel.loadExercises()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        // Список упражнений с возможностью редактирования
                        ForEach(viewModel.exercises) { exercise in
                            Button(action: {
                                handleExerciseSelection(exercise)
//                                onSelection(exercise)
//                                navigationPath.append(ExerciseRoute.detail(exercise: exercise))
                            }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(exercise.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    HStack(spacing: 8) {
                                        ForEach(exercise.measurements, id: \.self) { measurement in
                                            Text(measurement.type.localizedValue)
                                                .font(.caption2)
                                                .padding(4)
                                                .background(Capsule().fill(Color.accentColor.opacity(0.15)))
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.deleteExercise(exercise: exercise)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .navigationDestination(for: ExerciseRoute.self) { route in
                        switch route {
                        case .detail(let exercise):
                            ExerciseView(viewModel: ExerciseViewModel(exercise: exercise),
                                         onDismiss: {
                                Task {
                                    await viewModel.loadExercises()
                                }
                            })
                        }
                    }
                    .refreshable {
                        await viewModel.loadExercises()
                    }
                }
            }
            .navigationTitle("Exercises")
            FNButton(text: "Add") {
                navigationPath.append(ExerciseRoute.detail(exercise: nil))
            }
        }
    }
    
    private func handleExerciseSelection(_ exercise: Exercise) {
        if forSelection {
            onSelection?(exercise)
            dismiss()
        } else {
            navigationPath.append(ExerciseRoute.detail(exercise: exercise))
        }
    }
    
    init(forSelection: Bool = false, onSelection: ((Exercise) -> Void)? = nil) {
        self.forSelection = forSelection
        self.onSelection = onSelection
    }
}


#Preview {
    ExercisesView()
}
