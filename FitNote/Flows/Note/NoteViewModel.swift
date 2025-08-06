//
//  NoteViewModel.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import Combine
import Foundation
// Импортируй Note, Session, MocData
// import ... (если нужно, например: import FitNote.Services.Models)

protocol NoteViewModelProtocol: ObservableObject {
    var user: User { get }
    var sessions: [Session] { get }
    var nextSession: Session? { get }

    func startSession()
    func reload()
}

final class NoteViewModel: NoteViewModelProtocol {
    @Published private(set) var user: User = .mock
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var nextSession: Session? = nil
    @Published private(set) var upcomingSessions: [Session] = []
    
    init() {
        reload()
    }
    
    func reload() {
        let allSessions = MocData.sessions
        sessions = allSessions
        let sortedSessions = allSessions.sorted { $0.datePlaned > $1.datePlaned }
        
        upcomingSessions = allSessions
            //.filter { $0.date >= Date.now }
            .sorted { $0.datePlaned < $1.datePlaned }
            .prefix(5)
            .map { $0 }
        
        nextSession = upcomingSessions.first
        
        // Моки для прогресса и активностей (можно сделать из сессий)
        self.user = .mock
    }
    
    func startSession() {
        // Навигация или запуск трекера тренировки
    }
    
    func addSession(_ session: Session) {
        sessions.append(session)
    }
}
