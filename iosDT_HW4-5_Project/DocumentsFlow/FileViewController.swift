//
//  FileViewController.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 01.03.2023.
//

import Foundation
import UIKit

final class FileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let filePath: String
    
    private lazy var superImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    // MARK: - Life cycle
    
    init(filePath: String) {
        self.filePath = filePath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupGestureRecognizer()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.title = URL(fileURLWithPath: filePath).lastPathComponent
        self.superImageView.image = UIImage(contentsOfFile: filePath)
        self.view.backgroundColor = .white
        self.view.addSubview(self.superImageView)
    }
    
    private func setupGestureRecognizer() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureToSuperImageView(_:)))
        pinchGesture.scale = 0.5
        self.superImageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func pinchGestureToSuperImageView(_ pinchGesture: UIPinchGestureRecognizer) {
        guard pinchGesture.state == .ended else  {
            self.superImageView.transform = CGAffineTransform(scaleX: pinchGesture.scale, y: pinchGesture.scale)
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn) {
            self.superImageView.transform = .identity
        }
        
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.superImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.superImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.superImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.superImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
