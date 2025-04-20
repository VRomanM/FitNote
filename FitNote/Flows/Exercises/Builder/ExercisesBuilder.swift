//
//  ExercisesBuilder.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

final class ExercisesBuilder {
    static func build() -> UIViewController {
        let view = ExercisesViewController()
        let router = ExercisesRouter(view: view)
        let presenter = ExercisesPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
