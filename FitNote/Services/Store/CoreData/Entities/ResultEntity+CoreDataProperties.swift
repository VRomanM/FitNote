//
//  ResultEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 10.08.2025.
//
//

import Foundation
import CoreData


extension ResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultEntity> {
        return NSFetchRequest<ResultEntity>(entityName: "ResultEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var resultType: String?
    @NSManaged public var measurementType1: String?
    @NSManaged public var value1: Double
    @NSManaged public var measurementType2: String?
    @NSManaged public var value2: Double
    @NSManaged public var exerciseSetEntity: ExerciseSetEntity?

}

extension ResultEntity : Identifiable {

}
