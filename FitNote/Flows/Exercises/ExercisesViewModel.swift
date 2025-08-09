//
//  ExercisesViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 27.07.2025.
//

import Combine

final class ExercisesViewModel: ObservableObject {
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager.shared
    
    //MARK: - Published Properties

    @Published var exercises: [Exercise] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    //MARK: - Constructions
    
    init() {
        Task {
            await loadExercises()
        }
    }
    
    //MARK: - Private function

    private func retrieveContactsFromCoreData() async {
        await MainActor.run {
            isLoading = true
        }
        
        let exercisesFromCoreData: [Exercise] = await {
            guard let exercisesEntities = try? await coreDataManager.retrieveExercises() else { return [] }
            let mappedExercises: [Exercise] = exercisesEntities.compactMap { exercise in
                return Exercise(id: exercise.id, name: exercise.name, measurements: exercise.measurements)
            }
            return mappedExercises
        }()
        
        await MainActor.run {
            self.exercises = exercisesFromCoreData
            self.isLoading = false
        }
    }
    
    func loadExercises() async {
        guard !isLoading else { return }
        await retrieveContactsFromCoreData()
    }
    
    func deleteExercise(exercise: Exercise) async {
        guard !isLoading else { return }
        
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            try await coreDataManager.deleteExercise(exercise)
            await loadExercises()
        } catch {
            print("Error deleting exercise: \(error.localizedDescription)")
        }
    }
}
