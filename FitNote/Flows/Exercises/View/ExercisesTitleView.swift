//
//  ExercisesTitleView.swift
//  FitNote
//
//  Created by Роман Вертячих on 26.04.2025.
//

import UIKit

final class ExercisesTitleView: UIView {
    
    //MARK: - View
    
    private var titleLabel = UILabel()
    
    //MARK: - Constructions
    
    init(title: String) {
        super.init(frame: CGRect())
        titleLabel.text = title
        titleLabel.font = .subheadline
        titleLabel.textColor = .textSecondary
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private function

    private func  setupViews() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
