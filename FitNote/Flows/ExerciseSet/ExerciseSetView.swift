//
//  ExerciseSetView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct ExerciseSetView: View {
    @ObservedObject var viewModel: ExerciseSetViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Красный хедер
            VStack(spacing: 0) {
                HStack {
                    Text("14:14")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("1/9")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("0:44:22")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .background(Color.red)
            .frame(height: 60)
            
            // Основная белая карточка
            VStack(spacing: 0) {
                // Верхняя часть с заголовком
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("Приседания широкой постановкой ног")
                            .font(.title2.bold())
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                        
                        Text("ДРУГИЕ")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: { /* меню */ }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Сеты упражнения
                VStack(spacing: 12) {
                    VStack(spacing: 12) {
                        ForEach(Array(viewModel.results.enumerated()), id: \.offset) { index, result in
                            ExerciseSetRow(
                                setNumber: index + 1,
                                result: result,
                                restTime: index < viewModel.restTimes.count ? viewModel.restTimes[index] : nil
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                
                Spacer()
                
                // Нижние иконки
                HStack {
                    // Левая группа иконок
                    HStack(spacing: 16) {
                        Button(action: { /* статистика */ }) {
                            Image(systemName: "chart.bar")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(width: 32, height: 32)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }
                        
                        Button(action: { /* заметки */ }) {
                            Image(systemName: "doc.text")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(width: 32, height: 32)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }
                    }
                    
                    Spacer()
                    
                    // Правая группа иконок
                    HStack(spacing: 16) {
                        // Превью изображения упражнения
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray4))
                            .frame(width: 60, height: 40)
                            .overlay(
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .foregroundColor(.secondary)
                            )
                        
                        Button(action: { /* информация */ }) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(width: 32, height: 32)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            Spacer()
            
            // Нижняя навигационная панель
            HStack(spacing: 20) {
                Button(action: { /* предыдущий */ }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
                
                Button(action: { /* добавить */ }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                // Центральная кнопка "Готово"
                Button(action: {
//                    viewModel.saveExercise()
                    dismiss()
                }) {
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.red)
                        .clipShape(Circle())
                }
//                .disabled(!viewModel.isValid)
                
                Spacer()
                
                Button(action: { /* история */ }) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
                
                Button(action: { /* следующий */ }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct ExerciseSetRow: View {
    let setNumber: Int
    let result: Result
    let restTime: TimeInterval?
    
    var body: some View {
        HStack {
            Text("\(setNumber)")
                .font(.body)
                .foregroundColor(.secondary)
                .frame(width: 20, alignment: .leading)
            
            Text(resultDescription)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let restTime = restTime, restTime > 0 {
                Text(formatRestTime(restTime))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var resultDescription: String {
        switch result {
        case .single(let type, let value):
            switch type {
            case .weight:
                return "\(Int(value)) кг"
            case .iterations:
                return "\(Int(value))"
            case .time:
                return formatTime(value)
            case .distance:
                return "\(value) км"
            }
        case .paired(let t1, let v1, let t2, let v2):
            let first = formatValue(type: t1, value: v1)
            let second = formatValue(type: t2, value: v2)
            return "\(first) × \(second)"
        }
    }
    
    private func formatValue(type: MeasurementType, value: Double) -> String {
        switch type {
        case .weight:
            return "\(Int(value)) кг"
        case .iterations:
            return "\(Int(value))"
        case .time:
            return formatTime(value)
        case .distance:
            return "\(value) км"
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return "\(minutes):\(String(format: "%02d", secs))"
    }
    
    private func formatRestTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        if minutes > 0 {
            return "\(minutes):\(String(format: "%02d", secs))"
        } else {
            return "\(secs) сек"
        }
    }
}

#Preview {
    ExerciseSetView(viewModel: ExerciseSetViewModel(set: MocData.exerciseSet))
}
