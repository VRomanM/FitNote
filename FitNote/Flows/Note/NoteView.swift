//
//  NoteView.swift
//  FitNote
//
//  Created by Роман Вертячих on 23.07.2025.
//

import SwiftUI
import Charts

struct NoteView: View {
    
    private enum NoteRoute: Hashable {
        case session(session: Session?)
    }
    
    @State private var navigationPath = NavigationPath()
    @State private var showAlert: Bool = false
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    GreetingHeader(user: viewModel.user)
                    
                    if let nextSession = viewModel.nextSession {
                        NextSessionsCarousel(
                            sessions: viewModel.upcomingSessions,
                            onSelect: { session in
                                navigationPath.append(NoteRoute.session(session: session))
                            }
                        )
                    }
                    ProgressSection(sessions: viewModel.sessions)
                    QuickActionsSection(showAlert: $showAlert) {
                        navigationPath.append(NoteRoute.session(session: nil))
                    }
                    RecentSessionsSection(
                        sessions: viewModel.sessions,
                        onSelect: { session in
                            if session == viewModel.sessions.first(where: { $0.status == .planned }) {
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

struct ProfileButton: View {
    let user: User

    var body: some View {
        Button {
            // переход к профилю
        } label: {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .foregroundStyle(.backgroundAccent1)
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
//                    .foregroundColor(.backgroundAccent1)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundColor(.backgroundAccent1)
        }
    }
}

struct NextSessionsCarousel: View {
    let sessions: [Session]
    let onSelect: (Session) -> Void
    
    @State private var currentIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Ближайшие тренировки")
                .font(.headline)
                .padding(.horizontal, 8)
            
            TabView(selection: $currentIndex) {
                ForEach(Array(sessions.enumerated()), id: \.element.id) { index, session in
                    NextSessionCard(session: session) {
                        onSelect(session)
                    }
                    .tag(index)
                }
            }
            .frame(height: 160)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            // Кастомные индикаторы
            HStack(spacing: 8) {
                Spacer()
                ForEach(0..<sessions.count, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.backgroundAccent1 : Color.backgroundAccent1.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentIndex == index ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: currentIndex)
                }
                Spacer()
            }
            .padding(.top, -8)
        }
//        .padding(.horizontal, 20)
    }
}

struct NextSessionCard: View {
    let session: Session
    let onSelect: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.name)
                        .font(.title3).bold()
                        .lineLimit(2)
                    
                    Text(session.datePlaned, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(session.sets.count) сетов")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(Int(session.totalWeight)) кг")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Button("Начать") {
                onSelect()
            }
            .buttonStyle(.borderedProminent)
            .tint(.backgroundAccent1)
            .frame(maxWidth: .infinity)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 4, x: 0, y: 2)
                .padding(8)
        )
    }
}

//struct NextSessionCard: View {
//    let session: Session
//    let onStart: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Ближайшая тренировка")
//                .font(.headline)
//            Text(session.name)
//                .font(.title3).bold()
//            Text(session.date, style: .date)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            Button("Начать") {
//                onStart()
//            }
//            .buttonStyle(.borderedProminent)
//            .padding(.top, 4)
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
//        .shadow(radius: 2)
//    }
//}

struct ProgressSection: View {
    let sessions: [Session]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Сжигание калорий")
                .font(.headline)
            Chart(sessions) { session in
                LineMark(
                    x: .value("Дата", session.datePlaned),
                    y: .value("Калории", session.calories)
                )
            }
            .frame(height: 120)
            .foregroundStyle(.backgroundAccent1)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
    }
}

struct QuickActionsSection: View {
    @Binding var showAlert: Bool
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            QuickActionButton(title: "Добавить", icon: "plus.circle.fill") { action() }
            QuickActionButton(title: "Шаблоны", icon: "doc.on.doc.fill") {
                showAlert = true
            }
            QuickActionButton(title: "Статистика", icon: "chart.bar.fill") {
                showAlert = true
            }
        }
        .alert("In new releases", isPresented: $showAlert) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text("The functionality will be available in the upcoming releases")
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
                    .foregroundColor(.backgroundAccent1)
                    .frame(width: 32, height: 32)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.foreground)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        }
    }
}

struct RecentSessionsSection: View {
    let sessions: [Session]
    var onSelect: ((Session) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text("Последние тренировки")
                .font(.headline)
            ForEach(sessions.prefix(3)) { session in
                Button(action: { onSelect?(session) }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(session.name)
                                .font(.subheadline)
                                .foregroundColor(.backgroundAccent1)
                            HStack {
                                Text(session.datePlaned, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("длилась: \(session.duration?.formattedTime() ?? "--") мин")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        Text("\(session.calories) ккал")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    NoteView()
}
