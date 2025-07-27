//
//  AddSessionView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

//struct AddSessionView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var name: String = ""
//    @State private var date: Date = Date()
//    @State private var calories: Int = 0
//
//    @State private var exerciseSets: [ExerciseSet] = []
//    @State private var supersets: [Superset] = []
//
//    @State private var showAddSet = false
//    @State private var showAddSuperset = false
//
//    var onSave: (DELETE_NoteRow) -> Void
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Название")) {
//                    TextField("Например: Утренняя тренировка", text: $name)
//                }
//                Section(header: Text("Дата и время")) {
////                    DatePicker("Дата", selection: $date, displayedComponents: [.date, .hourAndMinute])
//                }
//                Section(header: Text("Калории")) {
//                    Stepper(value: $calories, in: 0...5000, step: 10) {
//                        Text("\(calories) ккал")
//                    }
//                }
//                Section(header: Text("Наборы упражнений")) {
//                    if exerciseSets.isEmpty {
//                        Text("Нет наборов").foregroundColor(.secondary)
//                    } else {
////                        ForEach(exerciseSets) { set in
//////                            VStack(alignment: .leading, spacing: 4) {
//////                                Text(set.name).font(.headline)
//////                                ForEach(set.exercises) { ex in
//////                                    Text("• \(ex.exercise.name) — \(exDisplay(ex))")
//////                                        .font(.caption)
//////                                }
//////                                Text("Отдых между: \(set.restBetweenExercises) сек")
//////                                    .font(.caption2)
//////                                    .foregroundColor(.secondary)
//////                                Text("Отдых после: \(set.restAfterSet) сек")
//////                                    .font(.caption2)
//////                                    .foregroundColor(.secondary)
//////                            }
//////                            .padding(.vertical, 4)
////                            ExerciseSetRow(set: set)
////                        }
////                        .onDelete { idx in exerciseSets.remove(atOffsets: idx) }
//                    }
//                    Button {
//                        showAddSet = true
//                    } label: {
//                        Label("Добавить набор", systemImage: "plus")
//                    }
//                }
//                Section(header: Text("Суперсеты")) {
//                    if supersets.isEmpty {
//                        Text("Нет суперсетов").foregroundColor(.secondary)
//                    } else {
////                        ForEach(supersets) { superset in
////                            VStack(alignment: .leading, spacing: 4) {
////                                Text(superset.name).font(.headline)
////                                ForEach(superset.exerciseSets) { set in
////                                    Text("• \(set.name) (\(set.exercises.count) упражнений)")
////                                        .font(.caption)
////                                }
////                                Text("Отдых между: \(superset.restBetweenSets) сек")
////                                    .font(.caption2)
////                                    .foregroundColor(.secondary)
////                                Text("Отдых после: \(superset.restAfterSuperset) сек")
////                                    .font(.caption2)
////                                    .foregroundColor(.secondary)
////                            }
////                            .padding(.vertical, 4)
////                        }
////                        .onDelete { idx in supersets.remove(atOffsets: idx) }
//                    }
//                    Button {
//                        showAddSuperset = true
//                    } label: {
//                        Label("Добавить суперсет", systemImage: "plus")
//                    }
//                }
//            }
//            .navigationTitle("Новая сессия")
//            .navigationBarItems(
//                leading: Button("Отмена") {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                trailing: Button("Сохранить") {
////                    let session = Session(
////                        id: UUID(),
////                        name: name.isEmpty ? "Тренировка" : name,
////                        date: date,
////                        avgHeartRate: nil,
////                        duration: nil,
////                        calories: calories,
////                        exercises: exerciseSets,
////                        supersets: supersets
////                    )
////                    onSave(session)
////                    presentationMode.wrappedValue.dismiss()
//                }
//                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
//            )
//            .sheet(isPresented: $showAddSet) {
////                EditExerciseSetView { newSet in
////                    exerciseSets.append(newSet)
////                    showAddSet = false
////                }
//            }
//            .sheet(isPresented: $showAddSuperset) {
//                EditSupersetView { newSuperset in
//                    supersets.append(newSuperset)
//                    showAddSuperset = false
//                }
//            }
//        }
//    }
//
//    private func exDisplay(_ ex: Session) -> String {
////        "Вес: \(ex.weight), Повторения: \(ex.reps)"
//        "Вес: , Повторения: "
//    }
//    
////    private func exDisplay(_ ex: SessionExercise) -> String {
////        // Покажи параметры упражнения в красивом виде
//////        ex.params.map { "\($0)" }.joined(separator: ", ")
////        "20, 100"
////    }
//}
//
//struct ExerciseSetRow: View {
//    let set: ExerciseSet
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
////            Text(set.name).font(.headline)
//            Text("Сет").font(.headline)
////            ForEach(set) { ex in
//                Text("• \(exDisplay())")
////                Text("• \(ex. .exercise.name) — \(exDisplay(ex))")
////                    .font(.caption)
////            }
////            Text("Отдых между: \(set.restBetweenExercises) сек")
//            Text("Отдых между: \(60) сек")
//                .font(.caption2)
//                .foregroundColor(.secondary)
////            Text("Отдых после: \(set.restAfterSet) сек")
//            Text("Отдых после: \(120) сек")
//                .font(.caption2)
//                .foregroundColor(.secondary)
//        }
//        .padding(.vertical, 4)
//    }
//
//    private func exDisplay() -> String {
//        "Вес: , Повторения: "
//    }
//}
