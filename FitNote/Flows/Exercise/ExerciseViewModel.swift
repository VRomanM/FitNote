//
//  ExerciseViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

final class ExerciseViewModel: ObservableObject {
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager.shared
    
    //MARK: - Published Properties
    
    @Published var exercise: Exercise
    @Published var selectedMeasurementsOrder: [MeasurementType] = []
    
    // Weight settings
    @Published var weightUnit: WeightUnit = .kg
    @Published var isGravitron: Bool = false
    @Published var doubleInStats: Bool = false
    
    // Time settings
    @Published var timeUnit: TimeUnit = .manual
    @Published var midSignal: Bool = false
    
    // Distance settings
    @Published var distanceUnit: DistanceUnit = .km
    @Published var activityType: ActivityType = .running
    @Published var syncWithWatch: Bool = false
    
    //MARK: - Properties
    
    var selectedMeasurements: Set<MeasurementType> {
        Set(selectedMeasurementsOrder)
    }
    
    var isValid: Bool {
        !exercise.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    let isNewExercise: Bool
    
    //MARK: - Private properties
    
    private var measurements: [Measurement] {
        var result: [Measurement] = []
        
        for measurementType in selectedMeasurements {
            switch measurementType {
            case .weight:
                result.append(.weight(unit: weightUnit, isGravitron: isGravitron, doubleInStats: doubleInStats))
            case .time:
                result.append(.time(unit: timeUnit, midSignal: midSignal))
            case .distance:
                result.append(.distance(unit: distanceUnit, activity: activityType, syncWithWatch: syncWithWatch))
            case .iterations:
                result.append(.iterations)
            }
        }
        
        return result
    }
        
    //MARK: - Constructions
    
    init(exercise: Exercise? = nil) {
        guard let exercise else {
            self.exercise = Exercise()
            self.isNewExercise = true
            return
        }
        self.isNewExercise = false
        self.exercise = exercise
        loadMeasurements(exercise.measurements)
    }
    
    //MARK: - Private function
    
    private func loadMeasurements(_ measurements: [Measurement]) {
        selectedMeasurementsOrder.removeAll()
        
        for measurement in measurements {
            selectedMeasurementsOrder.append(measurement.type)
            
            switch measurement {
            case .weight(let unit, let isGravitron, let doubleInStats):
                weightUnit = unit
                self.isGravitron = isGravitron
                self.doubleInStats = doubleInStats
            case .time(let unit, let midSignal):
                timeUnit = unit
                self.midSignal = midSignal
            case .distance(let unit, let activity, let syncWithWatch):
                distanceUnit = unit
                activityType = activity
                self.syncWithWatch = syncWithWatch
            case .iterations:
                break
            }
        }
    }
    
    //MARK: - Function
    
    func saveExercise() async {
        await MainActor.run {
            exercise.measurements = measurements
        }
        
        do {
            try await coreDataManager.saveExercise(exercise: exercise)
        } catch {
            await MainActor.run {
                print("Error saving exercise: \(error)")
            }
        }
    }
    
    func toggleMeasurement(_ type: MeasurementType) {
        if selectedMeasurements.contains(type) {
            selectedMeasurementsOrder.removeAll { $0 == type }
        } else {
            if selectedMeasurementsOrder.count == 2 {
                selectedMeasurementsOrder.removeFirst()
            }
            selectedMeasurementsOrder.append(type)
        }
    }
}
