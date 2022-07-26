//
//  NewsService.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import Foundation
import ComposableArchitecture

struct NewsService {

    var getNews: () -> Effect<[Article], NetworkError>

}

// MARK: - Live

extension NewsService {

    static func live(networkService: NetworkService) -> Self {
        let jsonDecoder = JSONDecoder()
        return Self(
            getNews: {
                let requestBuilder = RequestBuilder(
                    path: "/news/all",
                    method: .get,
                    contentType: .json,
                    queryItems: []
                )
                let request = networkService.buildRequest(requestBuilder)
                return networkService
                    .executeRequest(request)
                    .handleResponse(with: jsonDecoder)
                    .eraseToEffect()
            }
        )
    }

}

// MARK: - Mock

extension NewsService {

    static var mock: Self {
        Self(
            getNews: {
                Effect(value: Article.mocks)
                    .delay(for: 2, scheduler: DispatchQueue.main)
                    .eraseToEffect()
            }
        )
    }

}
