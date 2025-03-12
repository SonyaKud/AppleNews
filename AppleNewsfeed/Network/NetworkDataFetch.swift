//
//  NetworkDataFetch.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchNews(response: @escaping (News?, NetworkError?) -> Void) {
        NetworkRequest.shared.getData { result in
            switch result {
            case .success(let data):
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    response(news, nil)
                } catch _ {
                    print("Failed to decode JSON")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
