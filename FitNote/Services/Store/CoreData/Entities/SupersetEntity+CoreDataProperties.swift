//
//  SupersetEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 10.08.2025.
//
//

import Foundation
import CoreData


extension SupersetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SupersetEntity> {
        return NSFetchRequest<SupersetEntity>(entityName: "SupersetEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var recoveryTime: Double
    @NSManaged public var exerciseSetEntity: ExerciseSetEntity?

}

extension SupersetEntity : Identifiable {

}
