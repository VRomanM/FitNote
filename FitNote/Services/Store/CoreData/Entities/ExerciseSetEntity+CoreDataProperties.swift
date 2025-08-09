//
//  ExerciseSetEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 10.08.2025.
//
//

import Foundation
import CoreData


extension ExerciseSetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSetEntity> {
        return NSFetchRequest<ExerciseSetEntity>(entityName: "ExerciseSetEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var comment: String?
    @NSManaged public var exercise: ExerciseEntity?
    @NSManaged public var sessionEntity: SessionEntity?
    @NSManaged public var supersetEntity: SupersetEntity?
    @NSManaged public var resultEntity: ResultEntity?

}

extension ExerciseSetEntity : Identifiable {

}
