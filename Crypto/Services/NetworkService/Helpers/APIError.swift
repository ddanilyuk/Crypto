//
//  APIError.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

struct APIError: Decodable {
    let error: Error

    struct Error: Decodable {
        let message: String
    }

}
