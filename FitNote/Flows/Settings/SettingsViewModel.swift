//
//  SettingsViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var user: User?
    @Published var notes: [Note] = []

    init() {
        // Здесь можно добавить загрузку пользователя, если появится
        self.notes = MocData.allNotes
    }

    func resetData() {
        // Здесь будет логика сброса (пока просто перезагрузка моков)
        self.notes = MocData.allNotes
    }
}
