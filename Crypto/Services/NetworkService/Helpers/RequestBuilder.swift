//
//  RequestBuilder.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

struct RequestBuilder {

    let path: String
    let method: HTTPMethod
    let contentType: ContentType?
    let queryItems: [URLQueryItem]
    let body: () -> Data?

    init(
        path: String,
        method: HTTPMethod,
        contentType: ContentType?,
        queryItems: [URLQueryItem] = [],
        body: @escaping () -> Data? = { nil }
    ) {
        self.path = path
        self.method = method
        self.contentType = contentType
        self.queryItems = queryItems
        self.body = body
    }

}
