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
}
