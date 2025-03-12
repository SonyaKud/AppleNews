//
//  NewsViewModel.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import Foundation

class NewsViewModel: NSObject {
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSourse: Observable<[Article]> = Observable(nil)
    var news: News?

    func getNews() {
        isLoading.value = true
        
        NetworkDataFetch.shared.fetchNews { [weak self] news, error in
            guard let self else { return }
            self.isLoading.value = false
            if let news {
                self.news = news
                mapCellData()
            } else if let error {
                print(error)
            }
        }
    }
    
    func mapCellData() {
        cellDataSourse.value = news?.articles
    }
    
    func getImage(url: URL, completionHandler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print (error)
                return
            }
            guard let data = data else { return }
            completionHandler(data)
        }
        task.resume()
    }
}
