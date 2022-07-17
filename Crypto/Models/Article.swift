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
