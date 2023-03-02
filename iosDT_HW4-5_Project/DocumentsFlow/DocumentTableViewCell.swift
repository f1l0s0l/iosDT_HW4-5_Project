//
//  DocumentTableViewCell.swift
//  iosDT_HW4-5_Project
//
//  Created by Илья Сидорик on 27.02.2023.
//

import Foundation
import UIKit

final class DocumentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    
    
    //MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupConfiguration(title: String, footerText: String, image: UIImage?) {
        self.leftImageView.image = image
        self.titleLabel.text = title
        self.footerLabel.text = footerText
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.contentView.addSubview(leftImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(footerLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            leftImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 2),
            leftImageView.heightAnchor.constraint(equalToConstant: 50),
            leftImageView.widthAnchor.constraint(equalToConstant: 50),
            leftImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),

            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: self.leftImageView.rightAnchor, constant: 5), //!!!!
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),

            footerLabel.leftAnchor.constraint(equalTo: self.leftImageView.rightAnchor, constant: 5), //!!!!
            footerLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            footerLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
    
}
