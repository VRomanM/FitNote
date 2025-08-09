//
//  CoreDataManager.swift
//  FitNote
//
//  Created by Роман Вертячих on 08.08.2025.
//

import CoreData

final class CoreDataManager {
    
    //MARK: - Private properties
    
    private struct Constants {
        static let dbName           = "Models"
    }
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.dbName)
        
        // Включаем автоматическую миграцию
        let description = container.persistentStoreDescriptions.first
        description?.shouldMigrateStoreAutomatically = true
        description?.shouldInferMappingModelAutomatically = true
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
                //MARK: -> Только для разработки!
                /*
                // Если сломалось хранилище CoreData в Previews. Пытаемся пересоздать его, fatalError комментируем, и вместо него просто выводим ошибку
                print("⚠️ Core Data error: \(error), \(error.userInfo)")

                // Попытка пересоздать хранилище (только для разработки!)
                if let storeURL = description?.url {
                    try? FileManager.default.removeItem(at: storeURL)
                    container.loadPersistentStores { _, _ in }
                }
                 */
                //MARK: <- Только для разработки!
            }
        }
        return container
    }()
    
    //MARK: - Properties
    
    static let shared = CoreDataManager()
    
    //MARK: - Constructions
    
    private init() {}
    
    //MARK: - Private function
    
    ///MARK: - Closure functions
    private func retrieveDataEntity<T>(fetchRequest: NSFetchRequest<T>, completion: @escaping (_ success: Bool, _ results: [T]?) -> Void) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            completion(true, results)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false, nil)
        }
    }
    
    private func deleteDataEntity(fetchRequest: NSFetchRequest<NSFetchRequestResult>, completion: @escaping (_ results: NSPersistentStoreResult?, _ error: NSError?) -> Void) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let managedContext = persistentContainer.viewContext
        do {
            let results = try managedContext.execute(deleteRequest)
            completion(results, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
    
    ///MARK: - Async functions
    
    private func retrieveDataEntity<T>(fetchRequest: NSFetchRequest<T>) async throws -> [T] {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            return try await managedContext.perform {
                try managedContext.fetch(fetchRequest)
            }
        } catch {
            throw error
        }
    }
    
    private func deleteDataEntity(fetchRequest: NSFetchRequest<NSFetchRequestResult>) async throws {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let managedContext = persistentContainer.viewContext
        
        do {
            try await managedContext.perform {
                try managedContext.execute(deleteRequest)
                try managedContext.save()
            }
        } catch let error as NSError {
            throw error
        }
    }
}

extension CoreDataManager {
    
    //MARK: - Exercise Function
    
    func retrieveExercises() async throws -> [ExerciseEntity] {
        let fetchRequest = NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
        
        return try await retrieveDataEntity(fetchRequest: fetchRequest)
    }
    
    private func retrieveExercise(by id: UUID) async throws -> ExerciseEntity? {
        let fetchRequest: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        let exercises = try await retrieveDataEntity(fetchRequest: fetchRequest)
        return exercises.first
    }
    
    func saveExercise(exercise: Exercise) async throws {
        let managedContext = persistentContainer.viewContext
        let existingEntity = try await retrieveExercise(by: exercise.id)
        
        try await managedContext.perform {
            let entity: ExerciseEntity
            
            if let exerciseEntity = existingEntity {
                entity = exerciseEntity
            } else {
                entity = ExerciseEntity(context: managedContext)
                entity.id = exercise.id
            }
            
            entity.name = exercise.name
            entity.measurements = exercise.measurements
            
            try managedContext.save()
        }
    }
    
    func deleteExercise(_ exercise: Exercise) async throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExerciseEntity")
        request.predicate = NSPredicate(format: "id == %@", exercise.id as CVarArg)
        
        try await deleteDataEntity(fetchRequest: request)
    }
}
