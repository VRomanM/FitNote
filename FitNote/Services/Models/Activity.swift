//
//  Activity.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let result: String
    
    static func mockList() -> [Activity] {
        [
            Activity(title: "Грудь и трицепс", date: .now.addingTimeInterval(-3600), result: "Успешно"),
            Activity(title: "Спина", date: .now.addingTimeInterval(-86400), result: "Успешно"),
            Activity(title: "Кардио", date: .now.addingTimeInterval(-172800), result: "30 мин")
        ]
    }
}
