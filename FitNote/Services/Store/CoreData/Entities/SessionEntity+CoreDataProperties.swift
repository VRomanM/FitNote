//
//  SessionEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 10.08.2025.
//
//

import Foundation
import CoreData


extension SessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessionEntity> {
        return NSFetchRequest<SessionEntity>(entityName: "SessionEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var datePlanned: Date?
    @NSManaged public var dateStart: Date?
    @NSManaged public var dateFinish: Date?
    @NSManaged public var duration: Double
    @NSManaged public var avgHeartRate: Int32
    @NSManaged public var calories: Int32
    @NSManaged public var comment: String?
    @NSManaged public var exerciseSetEntity: NSSet?

}

// MARK: Generated accessors for exerciseSetEntity
extension SessionEntity {

    @objc(addExerciseSetEntityObject:)
    @NSManaged public func addToExerciseSetEntity(_ value: ExerciseSetEntity)

    @objc(removeExerciseSetEntityObject:)
    @NSManaged public func removeFromExerciseSetEntity(_ value: ExerciseSetEntity)

    @objc(addExerciseSetEntity:)
    @NSManaged public func addToExerciseSetEntity(_ values: NSSet)

    @objc(removeExerciseSetEntity:)
    @NSManaged public func removeFromExerciseSetEntity(_ values: NSSet)

}

extension SessionEntity : Identifiable {

}
