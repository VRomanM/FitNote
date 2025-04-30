//
//  ResultsBuilder.swift
//  FitNote
//
//  Created by Роман Вертячих on 12.04.2025.
//

import UIKit

final class ResultsBuilder {
    static func build() -> UIViewController {
        let view = ResultsViewController()
        let router = ResultsRouter(view: view)
        let presenter = ResultsPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
