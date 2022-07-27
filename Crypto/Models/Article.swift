//
//  Article.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

struct Article: Decodable, Identifiable, Equatable {

    let id: String
    let title: String
    let published: String
    let preview: String
    let image: String

}

// MARK: - Redacted

extension Article {

    static let redacted: [Article] = [
        redacted1
    ]

    static let redacted1 = Article(
        id: "0",
        title: String(repeating: " ", count: 12),
        published: String(repeating: " ", count: 9),
        preview: String(repeating: " ", count: 28),
        image: "News/altcoin"
    )

}

// MARK: - Mocks

extension Article {

    static let mocks: [Article] = [
        mock1,
        mock2
    ]

    static let mock1 = Article(
        id: "0",
        title: "Altcoin news",
        published: "6 min ago",
        preview: "Six XRP Token Holders to Speak in Ripple-SEC Case as Circle Gets Subpoena",
        image: "News/altcoin"
    )

    static let mock2 = Article(
        id: "1",
        title: "Bitcoin news",
        published: "6 min ago",
        preview: "Bitcoin Eyes Key Upside Break, Outperforms Ethereum, DOGE Rallies",
        image: "News/bitcoin"
    )

}
