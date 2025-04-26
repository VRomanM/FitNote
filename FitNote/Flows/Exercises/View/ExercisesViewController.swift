//
//  ExercisesViewController.swift
//  FitNote
//
//  Created by Роман Вертячих on 20.04.2025.
//

import UIKit

class ExercisesViewController: UIViewController {

    //MARK: - View
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    
    //MARK: - Properties
    
    var presenter: ExercisesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Private function

    private func setupViews() {
        // Настройка вью
        view.backgroundColor = .backgroundPrimary
        
        // Настройка навигэйшн бар
        setupNavigationBar()
        
        // Настройка таблицы
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExercisesTableViewCell.self, forCellReuseIdentifier: ExercisesTableViewCell.identifier)
        view.addSubview(tableView)
        
        // Настройка констрейнтов
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        //navigationItem.title = "Exercises".localized()
        guard let navigationController = navigationController else { return }
        navigationItem.titleView = ExercisesTitleView(title: "Exercises".localized())
    }
}

extension ExercisesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ExercisesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExercisesTableViewCell.identifier, for: indexPath) as? ExercisesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: "Развдение рук с гантелями в наклоне стоя и еще что-то там где-то там куда -то там наклонившись, прищемив себе что - то", image: UIImage(systemName: "note")!)
        return cell
    }
}
