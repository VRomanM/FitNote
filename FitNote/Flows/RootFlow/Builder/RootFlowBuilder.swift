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
        
        let resultsNavigationController = UINavigationController(rootViewController: ResultsBuilder.build())
        resultsNavigationController.tabBarItem.title = "Results".localized()
        resultsNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        
        let exercisesNavigationController = UINavigationController(rootViewController: ExercisesBuilder.build())
        exercisesNavigationController.tabBarItem.title = "Exercises".localized()
        exercisesNavigationController.tabBarItem.image = UIImage(systemName: "figure.strengthtraining.traditional")
        
        tabBarController.viewControllers = [noteNavigationController, resultsNavigationController, exercisesNavigationController]
        tabBarController.modalPresentationStyle = .fullScreen
        
        return tabBarController
    }
}
