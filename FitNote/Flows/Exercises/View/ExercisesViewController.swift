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
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Private properties
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
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
        
        // Настройка контроллера поиска
        setupSearchController()
        
        // Настройка навигейшн бар
        navigationItem.title = "Exercises".localized()
        
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search".localized()
        searchController.searchBar.tintColor = .textSecondary
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.layer.borderWidth = 1
        searchController.searchBar.layer.borderColor = UIColor.clear.cgColor
        searchController.searchBar.setValue("Cancel".localized(), forKey: "cancelButtonText")
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
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

extension ExercisesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
