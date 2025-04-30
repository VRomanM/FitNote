//
//  ExercisesPresenter.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

final class ExercisesPresenter {
    
    //MARK: - Properties
    
    var view: UIViewController?
    
    //MARK: - Private properties
    
    private let router: ExercisesRouter
    
    //MARK: - Constructions
    
    init(view: UIViewController? = nil, router: ExercisesRouter) {
        self.view = view
        self.router = router
    }
}
