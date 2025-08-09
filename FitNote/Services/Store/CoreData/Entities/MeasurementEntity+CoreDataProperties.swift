//
//  MeasurementEntity+CoreDataProperties.swift
//  FitNote
//
//  Created by Роман Вертячих on 08.08.2025.
//
//

import Foundation
import CoreData


extension MeasurementEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementEntity> {
        return NSFetchRequest<MeasurementEntity>(entityName: "MeasurementEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: String
    @NSManaged public var weightUnit: String?
    @NSManaged public var isGravitron: Bool
    @NSManaged public var doubleInStats: Bool
    @NSManaged public var timeUnit: String?
    @NSManaged public var midSignal: Bool
    @NSManaged public var distanceUnit: String?
    @NSManaged public var activity: String?
    @NSManaged public var syncWithWatch: Bool

    convenience init(measurement: Measurement, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = UUID()
        self.type = measurement.type.rawValue
        self.isGravitron = false
        self.doubleInStats = false
        self.midSignal = false
        self.syncWithWatch = false
        
        switch measurement {
        case .weight(let unit, let isGravitron, let doubleInStats):
            self.weightUnit = unit.rawValue
            self.isGravitron = isGravitron
            self.doubleInStats = doubleInStats
        case .time(let unit, let midSignal):
            self.timeUnit = unit.rawValue
            self.midSignal = midSignal
        case .distance(let unit, let activity, let syncWithWatch):
            self.distanceUnit = unit.rawValue
            self.activity = activity.rawValue
            self.syncWithWatch = syncWithWatch
        case .iterations:
            break
        }
    }
    
    var measurement: Measurement {
        guard let type = MeasurementType(rawValue: self.type) else {
            return .iterations
        }
        
        switch type {
        case .weight:
            guard let weightUnit = weightUnit,
                  let unit = WeightUnit(rawValue: weightUnit) else {
                return .iterations
            }
            return .weight(unit: unit, isGravitron: isGravitron, doubleInStats: doubleInStats)
            
        case .time:
            guard let timeUnit = timeUnit,
                  let unit = TimeUnit(rawValue: timeUnit) else {
                return .iterations
            }
            return .time(unit: unit, midSignal: midSignal)
            
        case .distance:
            guard let distanceUnit = distanceUnit,
                  let unit = DistanceUnit(rawValue: distanceUnit),
                  let activity = activity,
                  let activityType = ActivityType(rawValue: activity) else {
                return .iterations
            }
            return .distance(unit: unit, activity: activityType, syncWithWatch: syncWithWatch)
            
        case .iterations:
            return .iterations
        }
    }
}

extension MeasurementEntity : Identifiable {

}
