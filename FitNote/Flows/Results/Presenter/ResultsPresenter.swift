//
//  ResultsPresenter.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import UIKit

final class ResultsPresenter {
    
    //MARK: - Properties
    
    var view: UIViewController?
    
    //MARK: - Private properties
    
    private let router: ResultsRouter
    
    //MARK: - Constructions
    
    init(view: UIViewController? = nil, router: ResultsRouter) {
        self.view = view
        self.router = router
    }
}
