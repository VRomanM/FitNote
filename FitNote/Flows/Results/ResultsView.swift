//
//  ResultsView.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.07.2025.
//

import SwiftUI

struct ResultsView: View {
    private var notes: [Note] {
        MocData.allNotes.sorted { $0.date > $1.date }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NoteSectionView(note: note)
                }
            }
            .navigationTitle("Результаты")
        }
    }
}

struct NoteSectionView: View {
    let note: Note

    var body: some View {
        Section(header: Text(note.date, style: .date)) {
            ForEach(note.sessions) { session in
                SessionRowView(session: session)
            }
            if let comment = note.comment, !comment.isEmpty {
                Text("💬 \(comment)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
            }
        }
    }
}

struct SessionRowView: View {
    let session: Session

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(session.name)
                .font(.headline)
            HStack(spacing: 12) {
                Label("\((session.duration ?? 60)/60, specifier: "%.0f") мин", systemImage: "timer")
                Label("\(session.calories) ккал", systemImage: "flame")
                Label("\(session.avgHeartRate ?? 0) уд/мин", systemImage: "heart")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            if !session.exercises.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(session.exercises) { se in
                            Text(se.exercise.name)
                                .font(.caption2)
                                .padding(6)
                                .background(Capsule().fill(Color.accentColor.opacity(0.2)))
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
