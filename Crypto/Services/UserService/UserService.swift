//
//  UserService.swift
//  Crypto
//
//  Created by Denys Danyliuk on 26.07.2022.
//

import Foundation
import ComposableArchitecture

struct UserService {

    var getMe: () -> Effect<User, NetworkError>

}

// MARK: - Live

extension UserService {

    static func live(networkService: NetworkService) -> Self {
        let jsonDecoder = JSONDecoder()
        return Self(
            getMe: {
                let requestBuilder = RequestBuilder(
                    path: "/user/me",
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

extension UserService {

    static var mock: Self {
        Self(
            getMe: {
                Effect(value: .mock)
                    .delay(for: 1, scheduler: DispatchQueue.main)
                    .eraseToEffect()
            }
        )
    }

}
