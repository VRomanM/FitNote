//
//  ExerciseView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct ExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("General properties")) {
                TextField("Enter exercise name", text: $viewModel.exercise.name)
            }

            Section(header: Text("Mesurements")) {
                ForEach(MeasurementType.allCases) { type in
                    Toggle(isOn: Binding(
                        get: { viewModel.selectedMeasurements.contains(type) },
                        set: { isOn in
                            viewModel.toggleMeasurement(type)
                        }
                    )) {
                        Text(type.localizedValue)
                    }
                }
            }

            if viewModel.selectedMeasurements.contains(.weight) {
                Section(header: Text("Weight settings")) {
                    Picker("UOM", selection: $viewModel.weightUnit) {
                        ForEach(WeightUnit.allCases) { unit in
                            Text(unit.localizedValue).tag(unit)
                        }
                    }
                    Toggle("Gravitron", isOn: $viewModel.isGravitron)
                    Toggle("Double in stats", isOn: $viewModel.doubleInStats)
                }
            }

            if viewModel.selectedMeasurements.contains(.time) {
                Section(header: Text("Time settings")) {
                    Picker("Fixing", selection: $viewModel.timeUnit) {
                        ForEach(TimeUnit.allCases) { unit in
                            Text(unit.localizedValue).tag(unit)
                        }
                    }
                    if viewModel.timeUnit == .timer {
                        Toggle("Mid signal", isOn: $viewModel.midSignal)
                    }
                }
            }

            if viewModel.selectedMeasurements.contains(.distance) {
                Section(header: Text("Distance settings")) {
                    Picker("UOM", selection: $viewModel.distanceUnit) {
                        ForEach(DistanceUnit.allCases) { unit in
                            Text(unit.localizedValue).tag(unit)
                        }
                    }
                    Picker("Type of activity", selection: $viewModel.activityType) {
                        ForEach(ActivityType.allCases) { type in
                            Text(type.localizedValue).tag(type)
                        }
                    }
                    Toggle("Sync with Apple Watch", isOn: $viewModel.syncWithWatch)
                }
            }
        }
        .navigationTitle(viewModel.isNewExercise ? "New" : "Edit")
        .scrollDismissesKeyboard(.immediately)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.saveExercise()
                    dismiss()
                }
                .disabled(!viewModel.isValid)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ExerciseView(viewModel: ExerciseViewModel())
}
