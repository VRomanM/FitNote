//
//  ExercisesTableViewCell.swift
//  FitNote
//
//  Created by Роман Вертячих on 25.04.2025.
//

import UIKit

final class ExercisesTableViewCell: UITableViewCell {
    
    //MARK: - View
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .bodyButton
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Properties
    
    static let identifier = "cellExercises"
    
    //MARK: - Constructions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private function

    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.heightAnchor.constraint(equalToConstant: 48),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            title.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -8)
        ])
    }
    
    //MARK: - Function
    
    func configure(title: String, image: UIImage?) {
        self.title.text = title
        self.image.image = image
    }
}
