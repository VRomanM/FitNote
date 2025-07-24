//
//  NoteViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Foundation
import Combine

// Импортируй Note, Session, MocData
// import ... (если нужно, например: import FitNote.Services.Models)

protocol NoteViewModelProtocol: ObservableObject {
    var user: User { get }
    var nextSession: Session? { get }
    var progress: ProgressData { get }
    var recentActivities: [Activity] { get }
    func startSession()
    func reload()
}

final class NoteViewModel: NoteViewModelProtocol {
    @Published private(set) var user: User = .mock
    @Published private(set) var nextSession: Session? = nil
    @Published private(set) var progress: ProgressData = .mock
    @Published private(set) var recentActivities: [Activity] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        reload()
    }
    
    func reload() {
        // Используй MocData для заметок и сессий
        let notes = MocData.allNotes
        // Берём ближайшую сессию из самой свежей заметки
        let allSessions = notes.flatMap { $0.sessions }
        let sortedSessions = allSessions.sorted { $0.date > $1.date }
        self.nextSession = sortedSessions.first
        
        // Моки для прогресса и активностей (можно сделать из сессий)
        self.progress = .mock
        self.recentActivities = sortedSessions.prefix(3).map {
            Activity(title: $0.name, date: $0.date, result: "\($0.calories) ккал")
        }
        self.user = .mock
    }
    
    func startSession() {
        // Навигация или запуск трекера тренировки
    }
    
    func addSession(_ session: Session) {
        // Здесь добавь сессию в нужную заметку или хранилище
        // Например, в первую заметку:
        if var firstNote = MocData.allNotes.first {
            firstNote.sessions.insert(session, at: 0)
            // Если используешь @Published var notes, обнови его
            // reload() если нужно обновить UI
            reload()
        }
    }
}
