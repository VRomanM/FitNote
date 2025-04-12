//
//  NoteRouter.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import UIKit

final class NoteRouter {
    
    //MARK: - Properties
    
    weak var view: UIViewController?
    
    //MARK: - Constructions
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
}
