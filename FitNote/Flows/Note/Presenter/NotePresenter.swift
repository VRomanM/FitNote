//
//  NotePresenter.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import UIKit

final class NotePresenter {
    
    //MARK: - Properties
    
    var view: UIViewController?
    
    //MARK: - Private properties
    
    private let router: NoteRouter
    
    //MARK: - Constructions
    
    init(view: UIViewController? = nil, router: NoteRouter) {
        self.view = view
        self.router = router
    }
}
