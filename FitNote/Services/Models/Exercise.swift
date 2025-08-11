//
//  Exercise.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import Foundation

struct Exercise: Identifiable, Hashable {
    let id: UUID
    var name: String
    var measurements: [Measurement] // max 2
    var emptyResult: Result? {
        var emptyResult: Result?
        if measurements.count == 1 {
            emptyResult = Result.single(measurements[0].type, 0)
        } else if measurements.count == 2 {
            emptyResult = Result.paired(measurements[0].type, 0, measurements[1].type, 0)
        }
        return emptyResult
    }
    
    //MARK: - Constructions
    
    init(id: UUID, name: String, measurements: [Measurement]) {
        self.id = id
        self.name = name
        self.measurements = measurements
    }
    
    init () {
        self.id = UUID()
        self.name = ""
        self.measurements = [Measurement]()
    }
    
    //MARK: - Function
    
    func getMeasurementUnit(ofType type: MeasurementType) -> String{
        var result: String = ""
        guard let measurement = measurements.first(where: { $0.type == type }) else { return result }
        
        switch measurement {
        case .weight(let unit, _,  _):
            result = unit.rawValue
        case .time( _, _):
            result = ""
        case .distance(let unit, _, _):
            result = unit.rawValue
        case .iterations:
            result = "iter"
        }
        return result
    }
}
