//
//  DetailsNewsViewModel.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 11.03.2025.
//

import Foundation

class DetailsNewsViewModel {
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
    
    func displayFormattedDate(publishedAt: String, completionHandler: @escaping (String) -> Void) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: publishedAt) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy"
            //outputFormatter.locale = Locale(identifier: "ru_RU")
            let formattedDate = outputFormatter.string(from: date)
            completionHandler(formattedDate)
        }
    }
}
