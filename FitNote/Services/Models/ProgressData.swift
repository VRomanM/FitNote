//
//  ProgressData.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

struct ProgressData {
    struct Entry: Identifiable {
        let id = UUID()
        let date: Date
        let value: Double
    }
    let entries: [Entry]
    static let mock = ProgressData(entries: [
        .init(date: .now.addingTimeInterval(TimeInterval(-86400*3)), value: 80),
        .init(date: .now.addingTimeInterval(TimeInterval(-86400*2)), value: 80.5),
        .init(date: .now.addingTimeInterval(-86400), value: 81),
        .init(date: .now, value: 80.8)
    ])
}
