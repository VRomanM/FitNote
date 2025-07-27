//
//  SettingsViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var user: User?
    @Published var sessions: [Session] = []

    init() {
        // Здесь можно добавить загрузку пользователя, если появится
        self.sessions = MocData.sessions
    }

    func resetData() {
        // Здесь будет логика сброса (пока просто перезагрузка моков)
        self.sessions = MocData.sessions
    }
}
