//
//  EditExerciseSetView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

//struct EditExerciseSetView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var name: String = ""
//    @State private var exercises: [Session] = []
//    @State private var restBetween: Int = 60
//    @State private var restAfter: Int = 120
//
////    var onSave: (ExerciseSet) -> Void
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Название набора")) {
//                    TextField("Например: Силовой сет", text: $name)
//                }
//                Section(header: Text("Упражнения")) {
//                    ForEach(exercises) { ex in
//                        VStack(alignment: .leading) {
//                            Text(ex.exercise.name)
//                            Text(paramsString(for: ex))
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    .onDelete { idx in exercises.remove(atOffsets: idx) }
//                    Button {
//                        // Открыть sheet для добавления упражнения
//                    } label: {
//                        Label("Добавить упражнение", systemImage: "plus")
//                    }
//                }
//                Section(header: Text("Отдых между упражнениями")) {
//                    Stepper(value: $restBetween, in: 0...600, step: 5) {
//                        Text("\(restBetween) сек")
//                    }
//                }
//                Section(header: Text("Отдых после набора")) {
//                    Stepper(value: $restAfter, in: 0...1200, step: 10) {
//                        Text("\(restAfter) сек")
//                    }
//                }
//            }
//            .navigationTitle("Набор упражнений")
//            .navigationBarItems(
//                leading: Button("Отмена") {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                trailing: Button("Сохранить") {
////                    let set = ExerciseSet(
////                        id: UUID(),
////                        name: name.isEmpty ? "Набор" : name,
////                        exercises: exercises,
////                        restBetweenExercises: restBetween,
////                        restAfterSet: restAfter
////                    )
////                    onSave(set)
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || exercises.isEmpty)
//            )
//        }
//    }
//
//    private func paramsString(for ex: Session) -> String {
//        //ex.params.map { "\($0)" }.joined(separator: ", ")
//        "80, 100"
//    }
//}
