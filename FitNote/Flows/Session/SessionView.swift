//
//  SessionView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct SessionView: View {
    @StateObject var viewModel: SessionViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header с красным фоном
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    TextField("Enter session name", text: $viewModel.session.name)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { /* меню */ }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                DatePicker(selection: $viewModel.session.datePlaned) {}
                    .tint(.white)
                    .labelsHidden()
                    .padding()
            }
            .background(
                LinearGradient(
                    colors: [.red, .red.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            // Метрики сессии
            HStack(spacing: 0) {
                MetricBlock(title: "TIME", value: "\(viewModel.session.duration?.formattedAsMinutes() ?? "") min")//"44 мин")
                Divider().frame(height: 40)
                MetricBlock(title: "TONNAGE", value: "\(viewModel.session.totalWeight) kg")//"1 440 кг")
                Divider().frame(height: 40)
                MetricBlock(title: "AVG.❤️", value: "\(viewModel.session.avgHeartRate ?? 0)")
                Divider().frame(height: 40)
                MetricBlock(title: "CALLORIES", value: "\(viewModel.session.calories)")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            // Список упражнений
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(Array(viewModel.sets.enumerated()), id: \.element.id) { index, setVM in
                        Button(action: {
                            viewModel.selectedSetIndex = index
                            viewModel.isPresentingExerciseSetEditor = true
                        }) {
                            ExerciseRow(
                                number: index + 1,
                                exercise: setVM.exercise.name,
                                results: setVM.results
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .sheet(isPresented: $viewModel.isPresentingExercisePicker) {
                ExercisesView(forSelection: true, onSelection: { exercise in 
                    viewModel.addSet(for: exercise)
                })
            }
            .sheet(isPresented: $viewModel.isPresentingExerciseSetEditor) {
                if let index = viewModel.selectedSetIndex {
                    ExerciseSetView(viewModel: viewModel.sets[index])
                        .onDisappear {
                            // Обновляем сет в основном ViewModel после редактирования
                            if let index = viewModel.selectedSetIndex {
                                viewModel.updateSet(viewModel.sets[index], at: index)
                            }
                        }
                }
            }
            
            Spacer()
            
            // Нижняя панель действий
            HStack(spacing: 16) {
                Button(action: { viewModel.isPresentingExercisePicker = true }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button(action: { /* повторить тренировку */ }) {
                    Text("Повторить")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { /* поделиться */ }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                    
                    Button(action: { /* редактировать */ }) {
                        Image(systemName: "pencil")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $viewModel.isPresentingExercisePicker) {
            // ExercisePickerView
        }
    }
}

struct MetricBlock: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ExerciseRow: View {
    let number: Int
    let exercise: String
    let results: [Result]
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(number).")
                .font(.body)
                .foregroundColor(.secondary)
                .frame(width: 24, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Text(resultsDescription)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var resultsDescription: String {
        results.map { result in
            switch result {
            case .single(let type, let value):
                switch type {
                case .weight:
                    return "\(Int(value)) кг"
                case .iterations:
                    return "\(Int(value))"
                case .time:
                    return "\(Int(value / 60)):\(String(format: "%02d", Int(value) % 60))"
                case .distance:
                    return "\(value) км"
                }
            case .paired(let t1, let v1, let t2, let v2):
                let first = t1 == .weight ? "\(Int(v1)) кг" : "\(Int(v1))"
                let second = t2 == .iterations ? "\(Int(v2))" : "\(Int(v2))"
                return "\(first) x \(second)"
            }
        }.joined(separator: ", ")
    }
}

#Preview {
    SessionView(viewModel: SessionViewModel(session: MocData.sessionOtherCombinations))
}
