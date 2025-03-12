//
//  NewsfeedCell.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import UIKit

class NewsfeedCell: UITableViewCell {
    static let reuseID = "NewsfeedCell"
    var imageUrl: String?
    let viewModel = NewsViewModel()
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cellBG
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let imageNewsView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 19
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel = getLabel(font: UIFont.systemFont(ofSize: 17, weight: .semibold))
    lazy var descriptionLabel = getLabel(font: UIFont.systemFont(ofSize: 15, weight: .medium))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getLabel(font: UIFont) -> UILabel {
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = font
            label.numberOfLines = 0
            label.textAlignment = .justified
            label.textColor = .darkTC
            return label
        }()
    }
    
    private func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(imageNewsView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(descriptionLabel)
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 7
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            imageNewsView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
            imageNewsView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: imageNewsView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageNewsView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupCell(model: Article) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        if model.urlToImage == nil {
            imageNewsView.image = UIImage(named: "news")
        } else {
            if let urlString = model.urlToImage, let url = URL(string: urlString) {
                viewModel.getImage(url: url) { data in
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.imageNewsView.image = image
                    }
                }
            }
        }
    }
}
