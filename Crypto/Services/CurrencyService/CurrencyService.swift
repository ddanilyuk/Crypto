//
//  CurrencyService.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import Foundation
import ComposableArchitecture

struct CurrencyService {

    var getTrendingCurrencies: () -> Effect<[Currency], NetworkError>
    var getAllCurrencies: () -> Effect<[Currency], NetworkError>

}

// MARK: - Live

extension CurrencyService {

    static func live(networkService: NetworkService) -> Self {
        let jsonDecoder = JSONDecoder()
        return Self(
            getTrendingCurrencies: {
                let requestBuilder = RequestBuilder(
                    path: "/currencies/trending",
                    method: .get,
                    contentType: .json,
                    queryItems: []
                )
                let request = networkService.buildRequest(requestBuilder)
                return networkService
                    .executeRequest(request)
                    .handleResponse(with: jsonDecoder)
                    .eraseToEffect()
            },
            getAllCurrencies: {
                let requestBuilder = RequestBuilder(
                    path: "/currencies/trending",
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

extension CurrencyService {

    static var mock: Self {
        Self(
            getTrendingCurrencies: {
                Effect(value: Currency.trendingMocks)
                    .delay(for: 1.5, scheduler: DispatchQueue.main)
                    .eraseToEffect()
            },
            getAllCurrencies: {
                Effect(value: Currency.allMocks)
                    .delay(for: 1.5, scheduler: DispatchQueue.main)
                    .eraseToEffect()
            }
        )
    }

}
