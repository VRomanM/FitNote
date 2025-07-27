//
//  EditSupersetView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

//struct EditSupersetView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var name: String = ""
//    @State private var sets: [ExerciseSet] = []
//    @State private var restBetween: Int = 60
//    @State private var restAfter: Int = 180
//
//    var onSave: (Superset) -> Void
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Название суперсета")) {
//                    TextField("Например: Круговой", text: $name)
//                }
//                Section(header: Text("Наборы в суперсете")) {
//                    ForEach(sets) { set in
////                        Text("Сет #\(idx+1): \(set.values.map { "\($0.key.rawValue): \($0.value)" }.joined(separator: ", "))")
//                    }
//                    .onDelete { idx in sets.remove(atOffsets: idx) }
//                    Button {
//                        // Открыть sheet для добавления ExerciseSet
//                    } label: {
//                        Label("Добавить набор", systemImage: "plus")
//                    }
//                }
//                Section(header: Text("Отдых между наборами")) {
//                    Stepper(value: $restBetween, in: 0...600, step: 5) {
//                        Text("\(restBetween) сек")
//                    }
//                }
//                Section(header: Text("Отдых после суперсета")) {
//                    Stepper(value: $restAfter, in: 0...1200, step: 10) {
//                        Text("\(restAfter) сек")
//                    }
//                }
//            }
//            .navigationTitle("Суперсет")
//            .navigationBarItems(
//                leading: Button("Отмена") {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                trailing: Button("Сохранить") {
////                    let superset = Superset(
////                        id: UUID(),
////                        exercises: sets.flatMap { $0.exercises }, // если ExerciseSet содержит exercises: [SessionExercise]
////                        order: 1,
////                        comment: name.isEmpty ? nil : name
////                    )
////                    onSave(superset)
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || sets.isEmpty)
//            )
//        }
//    }
//}
