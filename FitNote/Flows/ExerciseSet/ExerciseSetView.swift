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
    @State private var isSwiped = false
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderExerciseSetView()
            
            VStack(spacing: 0) {
                TitleExerciseSetView()
                List {
                    ForEach(Array(viewModel.results.enumerated()), id: \.offset) { index, result in
                        ExerciseSetRow(
                            setNumber: index + 1,
                            result: $viewModel.results[index],
                            restTime: index < viewModel.restTimes.count ? viewModel.restTimes[index] : nil,
                            exercise: viewModel.exercise
                        )
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.results.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 36)
                .padding(.top, 24)
                Spacer()
                
                BottomButtonsExerciseSetView()
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            Spacer()
            
            FooterExerciseSetView(
                results: $viewModel.results,
                emptyResult: viewModel.exercise.emptyResult
            )
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct ExerciseSetRow: View {
    let setNumber: Int
//    let result: Result
    @Binding var result: Result
    let restTime: TimeInterval?
    let exercise: Exercise
    
//    @State private var isEditing = false
    @State private var tempValue1 = ""
    @State private var tempValue2 = ""
    
    var body: some View {
//        Group {
//            if isEditing {
//        editingView
        HStack {
            Text("\(setNumber)")
                .font(.body)
                .foregroundColor(.secondary)
                .frame(width: 20, alignment: .leading)
            switch result {
            case .single(let type, _):
                singleValueEditor(for: type, unit: exercise.getMeasurementUnit(ofType: type))
            case .paired(let type1, _, let type2, _):
                pairedValueEditor(type1: type1,
                                  type2: type2,
                                  unit1: exercise.getMeasurementUnit(ofType: type1),
                                  unit2: exercise.getMeasurementUnit(ofType: type2)
                )
            }
            
            Spacer()
            
            if let restTime = restTime, restTime > 0 {
                Text(formatRestTime(restTime))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
            .onAppear {
                prepareForEditing()
            }
//            } else {
//                displayView
//                    .onTapGesture {
//                        prepareForEditing()
//                        isEditing = true
//                    }
//            }
//        }
    }
    
//    private var displayView: some View {
//        HStack {
//            Text("\(setNumber)")
//                .font(.body)
//                .foregroundColor(.secondary)
//                .frame(width: 20, alignment: .leading)
//            
//            Text(resultDescription)
//                .font(.body)
//                .foregroundColor(.primary)
//            
//            Spacer()
//            
//            if let restTime = restTime, restTime > 0 {
//                Text(formatRestTime(restTime))
//                    .font(.body)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal, 12)
//        .background(Color(.systemFill))
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//    }
//    
//    private var resultDescription: String {
//        switch result {
//        case .single(let type, let value):
//            switch type {
//            case .weight:
//                return "\(Int(value)) кг"
//            case .iterations:
//                return "\(Int(value))"
//            case .time:
//                return formatTime(value)
//            case .distance:
//                return "\(value) км"
//            }
//        case .paired(let t1, let v1, let t2, let v2):
//            let first = formatValue(type: t1, value: v1)
//            let second = formatValue(type: t2, value: v2)
//            return "\(first) × \(second)"
//        }
//    }
    
//    private var editingView: some View {
//        HStack {
//            Text("\(setNumber)")
//                .font(.body)
//                .foregroundColor(.secondary)
//                .frame(width: 20, alignment: .leading)
//            switch result {
//            case .single(let type, _):
//                singleValueEditor(for: type)
//            case .paired(let type1, _, let type2, _):
//                pairedValueEditor(type1: type1, type2: type2)
//            }
//            
//            Spacer()
//            
////            Button(action: {
////                applyChanges()
////                isEditing = false
////            }) {
////                Image(systemName: "checkmark")
////                    .foregroundColor(.green)
////            }
//            
//            if let restTime = restTime, restTime > 0 {
//                Text(formatRestTime(restTime))
//                    .font(.body)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal, 12)
//        .background(Color(.systemGray5))
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//    }
    
    private func singleValueEditor(for type: MeasurementType, unit: String) -> some View {
        HStack {
            TextField("Value", text: $tempValue1)
                .keyboardType(type == .iterations ? .numberPad : .decimalPad)
                .frame(width: 40)
//                .textFieldStyle(.roundedBorder)
                .onChange(of: tempValue1) { newValue in
                    applyChanges()
                }
            Text(unit)
//            Text(unitForType(type))
        }
        .font(.callout)
    }
    
    private func pairedValueEditor(type1: MeasurementType, type2: MeasurementType, unit1: String, unit2: String) -> some View {
        HStack {
            TextField("Value", text: $tempValue1)
                .keyboardType(type1 == .iterations ? .numberPad : .decimalPad)
//                .font(.callout)
                .frame(width: 40)
//                .labelsHidden()
//                .textFieldStyle(.roundedBorder)
                .onChange(of: tempValue1) { newValue in
                    applyChanges()
                }
            
            Text(unit1)
//            Text(unitForType(type1))
//                .font(.callout)
            
            Text("×")
                .padding(.horizontal, 4)
//                .font(.callout)
            
            TextField("Value", text: $tempValue2)
                .keyboardType(type2 == .iterations ? .numberPad : .decimalPad)
//                .font(.callout)
                .frame(width: 40)
//                .labelsHidden()
//                .textFieldStyle(.roundedBorder)
                .onChange(of: tempValue2) { newValue in
                    applyChanges()
                }
            Text(unit2)
//            Text(unitForType(type2))
//                .font(.callout)
        }
        .frame(height: 20)
        .font(.callout)
    }
    
    private func prepareForEditing() {
        switch result {
        case .single(_, let value):
            tempValue1 = String(format: "%g", value)
        case .paired(_, let value1, _, let value2):
            tempValue1 = String(format: "%g", value1)
            tempValue2 = String(format: "%g", value2)
        }
    }
    
    private func applyChanges() {
        switch result {
        case .single(let type, _):
            if let newValue = Double(tempValue1) {
                result = .single(type, newValue)
            }
        case .paired(let type1, _, let type2, _):
            if let newValue1 = Double(tempValue1), let newValue2 = Double(tempValue2) {
                result = .paired(type1, newValue1, type2, newValue2)
            }
        }
    }
    
//    private func unitForType(_ type: MeasurementType) -> String {
//        switch type {
//        case .weight: return "кг"
//        case .iterations: return "повт"
//        case .time: return "сек"
//        case .distance: return "км"
//        }
//    }
    
//    private func formatValue(type: MeasurementType, value: Double) -> String {
//        switch type {
//        case .weight:
//            return "\(Int(value)) кг"
//        case .iterations:
//            return "\(Int(value))"
//        case .time:
//            return formatTime(value)
//        case .distance:
//            return "\(value) км"
//        }
//    }
    
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

struct HeaderExerciseSetView: View {
    var body: some View {
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
        .background(Color.backgroundAccent1)
        .frame(height: 60)
    }
}

struct TitleExerciseSetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
    }
}

struct BottomButtonsExerciseSetView: View {
    
    var body: some View {
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
}

struct FooterExerciseSetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var results: [Result]
    var emptyResult: Result?
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: { /* предыдущий */ }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
            
            Button(action: {
                if let emptyResult = emptyResult {
                    if results.isEmpty {
                        results.append(emptyResult)
                    } else {
                        let lastResult = results[results.count - 1]
                        results.append(lastResult)
                    }
                }
            }) {
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
}
