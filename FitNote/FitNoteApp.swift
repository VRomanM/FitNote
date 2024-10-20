//
//  FitNoteApp.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.10.2024.
//

import SwiftUI

@main
struct FitNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
