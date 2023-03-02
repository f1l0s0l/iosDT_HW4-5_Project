//
//  DocumentsViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 25.02.2023.
//

import UIKit

class DocumentsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    private weak var coordinator: CoordinatbleDocuments?

    // MARK: - Properties
    
    private var path: String
    
    private var documents: [String] {
        do {
            let arrayDocuments = try FileManager.default.contentsOfDirectory(atPath: path)
            
            
            let result = UserDefaults.standard.object(forKey: "isSortABC") as? Bool ?? true
            if result {
                return arrayDocuments.sorted()
            } else {
                return arrayDocuments.sorted(by: >)
            }
            
//            guard let result = UserDefaults.standard.object(forKey: "isSortABC") as? Bool,
//                  result == false
//            else {
//                return arrayDocuments.sorted()
//            }
//
//            return arrayDocuments.sorted(by: >)
            
            // Подскажите, пожалуйста, какая форма написания лучше и понятней?
            //только то что в блоке do {...}
            
        } catch {
            print(error)
        }
        return []
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.estimatedRowHeight = 60
        tableView.rowHeight = 60
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(DocumentTableViewCell.self, forCellReuseIdentifier: "DocumentTableViewCellID")
        return tableView
    }()
    
    private lazy var imagePikerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    
    // MARK: - Life cycle
    
    init(directoryPath: String, coordinator: CoordinatbleDocuments?) {
        self.path = directoryPath
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
        self.setupNotification()
    }
    
    deinit {
        print("DocumentsViewController \(#function)")
    }
    
//    // это я добавил добавил потому, что если создать файл внутри папки, сделать переход назад
//    // то в предыдущей версии таблици, в той папке, где мы добавляли файл, он сообсвенно добавился
//    // но предыдущая таблица не обновила свое состояние, следовательно под название
//    // папки не отобразиться "+ еще один объект"
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableView.reloadData()
//    }
    
    // а вот теперь вопрос
    // добавляя этот код, у меня начианет лагать переход назад...
    // и в новую папку тоже(
    // надо бы потом попробовать на реальном устройстве проверить...
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = URL(fileURLWithPath: path).lastPathComponent
        let rightNavButtonOne = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addNewFile)
        )
        let rightNavButtonTwo = UIBarButtonItem(
            image: UIImage(systemName: "folder.badge.plus"),
            style: .plain,
            target: self,
            action: #selector(addNewFolder)
        )
        self.navigationItem.rightBarButtonItems = [rightNavButtonTwo, rightNavButtonOne]
    }
    
    @objc
    private func addNewFile() {
        AlertNotification.shared.addPhotoAlertConfiguration(viewController: self) { type in
            guard let type = type else {
                return
            }

            self.imagePikerController.sourceType = type
            self.present(self.imagePikerController, animated: true)
        }
    }
    
    @objc
    private func addNewFolder() {
        AlertNotification.shared.addNewFolderOrFileAlertConfiguration(
            inViewController: self,
            title: "Создание папки",
            message: "Введите название папки")
        { text in
            let folderPath = self.path + "/" + text
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false)
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
                AlertNotification.shared.defaultAlertNotification(text: "Не удалось создать папку", viewController: self)
            }
            
        }
        
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(isSortABCToggleNotification), name: Notification.Name("isSortABCToggle"), object: nil)
    }
    
    @objc
    private func isSortABCToggleNotification() {
        self.tableView.reloadData()
    }
    
    
    private func thisFileIsDirectory(path: String) -> Bool {
        var objcBool: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
        
        if objcBool.boolValue {
            return true
        } else {
            return false
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
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCellID", for: indexPath) as? DocumentTableViewCell else {
            let cell = UITableViewCell()
            return cell
        }
        let filePath = self.path + "/" + documents[indexPath.row]
        
        if self.thisFileIsDirectory(path: filePath) {
            let documentsInDirectory = try? FileManager.default.contentsOfDirectory(atPath: filePath)
            cell.setupConfiguration(
                title: documents[indexPath.row],
                footerText: "FOLDER - \(documentsInDirectory?.count ?? 0) object",
                image: UIImage(systemName: "folder.fill")
            )
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.setupConfiguration(
                title: documents[indexPath.row],
                footerText: "file",
                image: UIImage(contentsOfFile: filePath) ?? UIImage(systemName: "doc")
            )
        }
        
        return cell
    }
    
}



    // MARK: - UITableViewDelegate

extension DocumentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let filePath = self.path + "/" + self.documents[indexPath.row]
        
        if self.thisFileIsDirectory(path: filePath) {
            self.coordinator?.openDirectory(directoryPath: filePath)
        } else {
            self.coordinator?.openFile(filePath: filePath)
        }
    }
    
    
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
                
        AlertNotification().addNewFolderOrFileAlertConfiguration(
            inViewController: self.imagePikerController,
            title: "Создание файла",
            message: "Введите название файла"
        ) { text in
            let filePath = self.path + "/" + text + ".jpeg"

            do {
                try FileManager.default.copyItem(at: pickerImageURL, to: URL(fileURLWithPath: filePath))
                self.tableView.reloadData()
                self.dismiss(animated: true)
            } catch {
                print(error.localizedDescription)
                self.dismiss(animated: true)
                AlertNotification().defaultAlertNotification(text: "Не удалось добавить файл", viewController: self)
            }
        }
        
    }
}



extension DocumentsViewController: UINavigationControllerDelegate {
    
}

