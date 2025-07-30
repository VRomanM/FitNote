//
//  NoteView.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import SwiftUI

struct NoteView: View {
    
    private enum NoteRoute: Hashable {
        case session(session: Session?)
    }
    
    @State private var navigationPath = NavigationPath()
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    GreetingHeader(user: viewModel.user)
                    
                    if let nextSession = viewModel.nextSession {
                        NextSessionCard(session: nextSession) {
                            navigationPath.append(NoteRoute.session(session: nextSession))
                        }
                    }
                    ProgressSection(progress: viewModel.progress)
                    QuickActionsSection() {
                        navigationPath.append(NoteRoute.session(session: nil))
                    }
                    RecentActivitySection(
                        activities: viewModel.recentActivities,
                        onSelect: { activity in
                            if let session = viewModel.sessions.first(where: { $0.name == activity.title && Calendar.current.isDate($0.date, inSameDayAs: activity.date) }) {
                                navigationPath.append(NoteRoute.session(session: session))
                            }
                        }
                    )
                }
                .padding()
            }
            .navigationDestination(for: NoteRoute.self) { route in
                switch route {
                case .session(let session):
                    SessionView(viewModel: SessionViewModel(session: session))
                }
            }
            .navigationTitle("Дневник")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProfileButton(user: viewModel.user)
                }
            }
        }
    }
}

struct GreetingHeader: View {
    let user: User

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Привет, \(user.name)!")
                    .font(.title2).bold()
                Text("Время стать лучше 💪")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(.accentColor)
        }
    }
}

struct NextSessionCard: View {
    let session: Session
    let onStart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ближайшая тренировка")
                .font(.headline)
            Text(session.name)
                .font(.title3).bold()
            Text(session.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button("Начать") {
                onStart()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 4)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 2)
    }
}

import Charts

struct ProgressSection: View {
    let progress: ProgressData

    var body: some View {
        VStack(alignment: .leading) {
            Text("Прогресс")
                .font(.headline)
            Chart(progress.entries) { entry in
                LineMark(
                    x: .value("Дата", entry.date),
                    y: .value("Вес", entry.value)
                )
            }
            .frame(height: 120)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
    }
}

struct QuickActionsSection: View {
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            QuickActionButton(title: "Добавить", icon: "plus.circle.fill") { action() }
            QuickActionButton(title: "Шаблоны", icon: "doc.on.doc.fill")
            QuickActionButton(title: "Статистика", icon: "chart.bar.fill")
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.tertiarySystemBackground)))
        }
        .buttonStyle(.plain)
    }
}

struct RecentActivitySection: View {
    let activities: [Activity]
    var onSelect: ((Activity) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text("Последние тренировки")
                .font(.headline)
            ForEach(activities.prefix(3)) { activity in
                Button(action: { onSelect?(activity) }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.subheadline)
                            Text(activity.date, style: .time)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(activity.result)
                            .font(.caption)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.vertical, 4)
                }
//                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
    }
}

struct ProfileButton: View {
    let user: User

    var body: some View {
        Button {
            // переход к профилю
        } label: {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
        }
    }
}

#Preview {
    NoteView()
}
