//
//  NewsfeedViewController.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import UIKit

class NewsfeedViewController: UIViewController {
    var viewModel = NewsViewModel()
    
    let appleNewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configureConstraints()
        setupTableView()
        configureNavigationController()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getNews()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        viewModel.cellDataSourse.bind { [weak self] news in
            guard let self, let news else { return }
            viewModel.news?.articles = news
            reloadTableView()
        }
    }
    
    private func addSubviews() {
        view.addSubview(activityIndicator)
        view.addSubview(appleNewsTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            appleNewsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            appleNewsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            appleNewsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            appleNewsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupTableView() {
        appleNewsTableView.delegate = self
        appleNewsTableView.dataSource = self
        appleNewsTableView.register(NewsfeedCell.self, forCellReuseIdentifier: NewsfeedCell.reuseID)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.appleNewsTableView.reloadData()
        }
    }
    
    private func configureNavigationController() {
        navigationItem.title = "Apple CO News"
        navigationController?.navigationBar.tintColor = .darkTC
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseID, for: indexPath) as? NewsfeedCell, let articles = viewModel.news?.articles else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setupCell(model: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel.news?.articles else { return }
        let detailVC = DetailsNewsViewController(news: news[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
