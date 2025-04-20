//
//  SessionBuilder.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

final class SessionBuilder {
    static func build() -> UIViewController {
        let view = SessionViewController()
        let router = SessionRouter(view: view)
        let presenter = SessionPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
