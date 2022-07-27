//
//  User.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

struct User {
    let name: String
    let balance: String
    let image: String

    var imageURL: URL? {
        URL(string: image)
    }
}

// MARK: - Equatable

extension User: Equatable {

}

// MARK: - Decodable

extension User: Decodable {

}

// MARK: - Redacted

extension User {

    static let redacted = User(
        name: String(repeating: " ", count: 10),
        balance: String(repeating: " ", count: 5),
        image: "https://redacted.com"
    )

}

// MARK: - Mock

extension User {

    static let mock = User(
        name: "Denys",
        balance: "21246",
        image: "https://thispersondoesnotexist.com/image"
    )

}
