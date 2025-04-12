//
//  NoteBuilder.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import UIKit

final class NoteBuilder {
    static func build() -> UIViewController {
        let view = NoteViewController()
        let router = NoteRouter(view: view)
        let presenter = NotePresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
