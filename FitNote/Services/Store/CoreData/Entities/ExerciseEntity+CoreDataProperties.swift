//
//  ExerciseEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 09.08.2025.
//
//

import Foundation
import CoreData


extension ExerciseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseEntity> {
        return NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var measurementEntity: NSSet
    @NSManaged public var exerciseSetEntity: NSSet
    
    var measurements: [Measurement] {
        get {
            let measurementEntities = measurementEntity.allObjects as! [MeasurementEntity]
            return measurementEntities.map { $0.measurement }
        }
        set {
            guard let context = self.managedObjectContext else {
                fatalError("ExerciseEntity must have a managedObjectContext")
            }
            
            let entities = newValue.map { measurement in
                MeasurementEntity(measurement: measurement, context: context)
            }
            measurementEntity = NSSet(array: entities)
        }
    }
    
//    convenience init(id: UUID, name: String, measurements: [Measurement]) {
//        self.init()
//        self.id = id
//        self.name = name
//        self.measurementEntity = {
//            let entities = measurements.map { measurement in
//                MeasurementEntity(measurement: measurement)
//            }
//            return NSSet(array: entities)
//        }()
//    }

}

// MARK: Generated accessors for measurementEntity
extension ExerciseEntity {

    @objc(addMeasurementEntityObject:)
    @NSManaged public func addToMeasurementEntity(_ value: MeasurementEntity)

    @objc(removeMeasurementEntityObject:)
    @NSManaged public func removeFromMeasurementEntity(_ value: MeasurementEntity)

    @objc(addMeasurementEntity:)
    @NSManaged public func addToMeasurementEntity(_ values: NSSet)

    @objc(removeMeasurementEntity:)
    @NSManaged public func removeFromMeasurementEntity(_ values: NSSet)

}

extension ExerciseEntity : Identifiable {

}
