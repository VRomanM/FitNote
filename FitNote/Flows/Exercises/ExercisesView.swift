//
//  ExercisesView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct ExercisesView: View {
    
    private enum ExerciseRoute: Hashable {
        case detail(exercise: Exercise?)
    }
    
    @State private var navigationPath = NavigationPath()
    @StateObject private var viewModel = ExercisesViewModel()
    
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
                                await viewModel.refreshExercises()
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
                                navigationPath.append(ExerciseRoute.detail(exercise: exercise))
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
                            
                        }
                    }
                    .navigationDestination(for: ExerciseRoute.self) { route in
                        switch route {
                        case .detail(let exercise):
                            ExerciseView(viewModel: ExerciseViewModel(exercise: exercise))
                        }
                    }
                    .refreshable {
                        await viewModel.refreshExercises()
                    }
                }
            }
            .navigationTitle("Exercises")
            FNButton(text: "Add") {
                navigationPath.append(ExerciseRoute.detail(exercise: nil))
            }
        }
    }
}


#Preview {
    ExercisesView()
}
