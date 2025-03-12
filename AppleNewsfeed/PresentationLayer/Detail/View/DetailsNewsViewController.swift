//
//  DetailsNewsViewController.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 11.03.2025.
//

import UIKit

class DetailsNewsViewController: UIViewController {
    var news: Article
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLable = getLabel(font: UIFont.systemFont(ofSize: 22, weight: .bold), color: .darkTC)
    lazy var authorLabel = getLabel(font: UIFont.systemFont(ofSize: 18, weight: .medium), color: .lightTC)
    lazy var publishedAtLabel = getLabel(font: UIFont.systemFont(ofSize: 18, weight: .medium), color: .lightTC)
    lazy var bodyContent = getLabel(font: UIFont.systemFont(ofSize: 20, weight: .medium), color: .darkTC)
    
    var viewModel = DetailsNewsViewModel()
    
    init(news: Article) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func getLabel(font: UIFont, color: UIColor) -> UILabel {
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = font
            label.numberOfLines = 0
            label.textAlignment = .justified
            label.textColor = color
            return label
        }()
    }
    
    private func configureScreen() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        
        titleLable.text = news.title
        authorLabel.text = news.author
        bodyContent.text = news.content
        setupeImageView()
        setupepublishedAt()
    }
    
    private func setupeImageView() {
        if news.urlToImage == nil {
            imageView.image = UIImage(named: "news")
        } else {
            if let urlString = news.urlToImage, let url = URL(string: urlString) {
                viewModel.getImage(url: url) { data in
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    private func setupepublishedAt() {
        viewModel.displayFormattedDate(publishedAt: news.publishedAt/*publishedAt*/) { data in
            self.publishedAtLabel.text = data
        }
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLable)
        view.addSubview(authorLabel)
        view.addSubview(publishedAtLabel)
        view.addSubview(bodyContent)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            publishedAtLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bodyContent.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 16),
            bodyContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bodyContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
