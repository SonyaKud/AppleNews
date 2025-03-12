//
//  NewsModel.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String
}

