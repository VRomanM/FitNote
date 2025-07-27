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
    var sessions: [Session] { get }
    var nextSession: Session? { get }
    var progress: ProgressData { get }
    var recentActivities: [Activity] { get }
    func startSession()
    func reload()
}

final class NoteViewModel: NoteViewModelProtocol {
    @Published private(set) var user: User = .mock
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var nextSession: Session? = nil
    @Published private(set) var progress: ProgressData = .mock
    @Published private(set) var recentActivities: [Activity] = []
    
//    private var cancellables = Set<AnyCancellable>()
    
    init() {
        reload()
    }
    
    func reload() {
        let allSessions = MocData.sessions
        sessions = allSessions
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
        sessions.append(session)
    }
}
