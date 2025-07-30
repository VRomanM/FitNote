//
//  ExercisesViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 27.07.2025.
//

import SwiftUI

@MainActor
class ExercisesViewModel: ObservableObject {
    
    //MARK: - Published Properties
    @Published var navigationPath = NavigationPath()
    
    @Published var exercises: [Exercise] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init() {
        Task {
            await loadExercises()
        }
    }
    
    func loadExercises() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Имитируем асинхронную загрузку
            try await Task.sleep(for: .seconds(0.3))
            
            let exercises: [Exercise] = MocData.sessions.flatMap(\.sets).map(\.exercise)
            self.exercises = Array(Set(exercises)).sorted { $0.name < $1.name }
//        } catch is CancellationError {
//            // Просто игнорируем отмену задачи, не показываем ошибку
        } catch {
            errorMessage = "Error loading exercises: %@".localized(with: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func refreshExercises() async {
        guard !isLoading else { return }
        await loadExercises()
    }
}
