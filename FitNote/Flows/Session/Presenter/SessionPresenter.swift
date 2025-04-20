//
//  SessionPresenter.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

final class SessionPresenter {
    
    //MARK: - Properties
    
    var view: UIViewController?
    
    //MARK: - Private properties
    
    private let router: SessionRouter
    
    //MARK: - Constructions
    
    init(view: UIViewController? = nil, router: SessionRouter) {
        self.view = view
        self.router = router
    }
}
