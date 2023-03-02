//
//  SetupViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import Foundation
import UIKit

final class SetupViewController: UIViewController {
    
    // MARK: - Publick properties
    
    private weak var coordinator: CoordinatbleSetup?
    
    
    // MARK: - Properties
    
    private var isSortABC: Bool = UserDefaults.standard.object(forKey: "isSortABC") as? Bool ?? true {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "isSortABC")
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    // MARK: - Life cycle
    
    init(coordinator: CoordinatbleSetup?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
    }
    
    deinit {
        print("SetupViewController \(#function)")
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.title = "Setup"
        self.view.addSubview(self.tableView)
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}



    // MARK: - UITableViewDataSource

extension SetupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Сортировать в алфовитном порядке"
            
            if self.isSortABC {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
            
        } else if indexPath.row == 1  {
            cell.textLabel?.text = "Завершить сессию"
            return cell
            
        } else {
            cell.textLabel?.text = "Сбросить пароль"
            return cell
        }
        
    }
    
}



// MARK: - UITableViewDataSource

extension SetupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.isSortABC.toggle()
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            NotificationCenter.default.post(name: NSNotification.Name("isSortABCToggle"), object: nil)
            
        } else if indexPath.row == 1 {
            self.coordinator?.switchToLoginCoordinator()
            
        } else {
            self.coordinator?.switchToLoginCoordinator()
            let checker = CheckerPassword()
            checker.removePassword()
        }
    }
    
}
