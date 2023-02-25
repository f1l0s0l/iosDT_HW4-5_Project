//
//  DocumentsViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import UIKit

class DocumentsViewController: UIViewController {

    // MARK: - Properties
    
    private var path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private var documents: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
        }
        return []
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var imagePikerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
    }
    
    deinit {
        print(#function)
    }

    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = "Documents"
//        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        let rightNavButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addNewFileInDocumentDerictories)
        )
        self.navigationItem.rightBarButtonItem = rightNavButton
    }
    
    @objc
    private func addNewFileInDocumentDerictories() {
        AlertNotification.shared.addPhotoAlertConfiguration(viewController: self) { type in
            guard let type = type else {
                return
            }

            self.imagePikerController.sourceType = type
            self.present(self.imagePikerController, animated: true)
        }
    }
    
    
    // MARK: - Constraint

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}



    // MARK: - UITableViewDataSource

extension DocumentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.documents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemGray5
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = documents[indexPath.row]
        return cell
    }
    
}



    // MARK: - UITableViewDataSource

extension DocumentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let pathToItem = path + "/" + documents[indexPath.row]
        do {
            try FileManager.default.removeItem(atPath: pathToItem)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        } catch {
            print(error)
        }
        
    }
    
}



    // MARK: - UIImagePickerControllerDelegate

extension DocumentsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickerImageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
            return
        }
        
        let filePath = self.path + "/" + pickerImageURL.lastPathComponent
        
        do {
            try FileManager.default.copyItem(at: pickerImageURL, to: URL(fileURLWithPath: filePath))
        } catch {
            print(error)
        }
        
        self.dismiss(animated: true)
        self.tableView.reloadData()
    }
    
}



extension DocumentsViewController: UINavigationControllerDelegate {
    
}

