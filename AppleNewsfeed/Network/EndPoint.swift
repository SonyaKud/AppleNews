//
//  EndPoint.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import Foundation

struct EndPoint {
    let path: String
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/" + path
        
        let queryItems = [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: "9ea26bbc0b9e4f14865c2cc784db1de1")
        ]
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension EndPoint {
    static var popularityNewsAboutAppleCo: Self {
        EndPoint(path: "v2/everything")
    }
}
