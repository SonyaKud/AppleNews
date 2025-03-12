//
//  NetworkRequest.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {}
    
    func getData(completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.request(.popularityNewsAboutAppleCo) { data, _, error in
            DispatchQueue.main.async {
                if error != nil {
                    completionHandler(.failure(.urlError))
                } else {
                    guard let data = data else { return }
                    completionHandler(.success(data))
                }
            }
        }
    }
}
