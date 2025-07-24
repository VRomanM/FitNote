//
//  AppMainTabView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct AppMainTabView: View {
    var body: some View {
        TabView {
            NoteView()
                .tabItem { Label("Дневник", systemImage: "house.fill") }
            ExercisesView()
                .tabItem { Label("Упражнения", systemImage: "dumbbell.fill") }
            ResultsView()
                .tabItem { Label("Результаты", systemImage: "chart.bar.fill") }
            SettingsView()
                .tabItem { Label("Настройки", systemImage: "gearshape.fill") }
        }
    }
}

#Preview {
    AppMainTabView()
}
