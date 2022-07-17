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
}

extension User: Equatable {

}

extension User {

    static let mock = User(
        name: "Denys",
        balance: "21246"
    )

}
