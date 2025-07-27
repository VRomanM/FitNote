//
//  SettingsView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showSessionDetail: Session?
    @State private var showResetAlert = false
    @State private var showAbout = false

    var body: some View {
        let userIdPrefix = viewModel.user?.id.uuidString.prefix(6).map(String.init)
        
        NavigationView {
            List {
                Section(header: Text("Профиль")) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("Пользователь")
                                .font(.headline)
                            Text("ID: \(userIdPrefix)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section(header: Text("Заметки")) {
                    ForEach(viewModel.sessions, id: \.id) { session in
                        SessionRow(session: session) {
                            showSessionDetail = session
                        }
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showResetAlert = true
                    } label: {
                        Label("Сбросить данные", systemImage: "arrow.counterclockwise")
                    }
                    Button {
                        showAbout = true
                    } label: {
                        Label("О приложении", systemImage: "info.circle")
                    }
                }
            }
            .navigationTitle("Настройки")
            .listStyle(InsetGroupedListStyle())
            .alert(item: $showSessionDetail) { session in
                Alert(
                    title: Text("Заметка"),
                    message: Text(session.comment ?? "Без комментария"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert("Сбросить все данные?", isPresented: $showResetAlert) {
                Button("Сбросить", role: .destructive) {
                    viewModel.resetData()
                }
                Button("Отмена", role: .cancel) {}
            }
            .sheet(isPresented: $showAbout) {
                VStack(spacing: 16) {
                    Text("FitNote")
                        .font(.title)
                    Text("Версия 1.0\nАвтор: Роман Вертячих")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

private struct SessionRow: View {
    let session: Session
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading) {
                Text(session.comment ?? "Без комментария")
                    .font(.body)
                Text(session.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    SettingsView()
}
