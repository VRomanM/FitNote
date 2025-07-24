//
//  EditExerciseView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct EditExerciseView: View {
    @ObservedObject var viewModel: EditExerciseViewModel
    var onSave: (Exercise) -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название")) {
                    TextField("Введите название", text: $viewModel.name)
                        .autocapitalization(.sentences)
                }
                Section(header: Text("Тип измерения")) {
                    ForEach(MeasurementType.allCases, id: \.self) { type in
                        Toggle(typeDisplayName(type), isOn: binding(for: type))
                            .disabled(!viewModel.selectedTypes.contains(type) && viewModel.selectedTypes.count >= 2)
                    }
                }
                Section(header: Text("Параметры")) {
                    // Просто отображаем, если нет UI для редактирования
                    Text(viewModel.measurementParams.map { $0.displayName }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle(viewModel.isNew ? "Новое упражнение" : "Редактировать")
            .navigationBarItems(
                leading: Button("Отмена") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Сохранить") {
                    onSave(viewModel.buildExercise())
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!viewModel.isValid)
            )
        }
    }
    
    private func binding(for type: MeasurementType) -> Binding<Bool> {
        Binding<Bool>(
            get: { viewModel.selectedTypes.contains(type) },
            set: { isOn in
                if isOn {
                    if viewModel.selectedTypes.count < 2 {
                        viewModel.selectedTypes.insert(type)
                    }
                } else {
                    viewModel.selectedTypes.remove(type)
                }
            }
        )
    }
    
    private func typeDisplayName(_ type: MeasurementType) -> String {
        switch type {
        case .weight: return "Вес"
        case .time: return "Время"
        case .distance: return "Дистанция"
        case .iterations: return "Повторения"
        }
    }
}
