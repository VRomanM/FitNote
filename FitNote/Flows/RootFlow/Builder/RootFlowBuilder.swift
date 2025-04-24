//
//  RootFlowBuilder.swift
//  FitNote
//
//  Created by Роман Вертячих on 24.04.2025.
//

import UIKit

final class RootFlowBuilder {
    
    func build() -> UIViewController {
        let tabBarController = RootTabBarController()
        let noteNavigationController = UINavigationController(rootViewController: NoteBuilder.build())
        noteNavigationController.tabBarItem.title = "Note".localized()
        noteNavigationController.tabBarItem.image = UIImage(systemName: "note")
        
        let resultsNavigationController = UINavigationController(rootViewController: NoteBuilder.build())
        resultsNavigationController.tabBarItem.title = "Results".localized()
        resultsNavigationController.tabBarItem.image = UIImage(systemName: "newspaper")
        
        tabBarController.viewControllers = [noteNavigationController, resultsNavigationController]
        tabBarController.modalPresentationStyle = .fullScreen
        
        return tabBarController
    }
}
