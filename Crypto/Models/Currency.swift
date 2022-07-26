//
//  Currency.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

struct Currency: Decodable, Identifiable, Equatable {

    let id: String
    let symbol: String
    let name: String
    let price: String // TODO: Double
    let percentage: Double
    let image: String

    let data: ChartData

    var percentageString: String {
        String(format: "%.02f", percentage)
    }

}

extension Currency {

    static var mocks: [Currency] = [
        mock1,
        mock2,
    ]

    static var mock1 = Currency(
        id: "etherium2",
        symbol: "ETH2",
        name: "Etherium 2",
        price: "$2,383.65",
        percentage: -4.91,
        image: "Coins/etherium2",
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

    static var mock2 = Currency(
        id: "binance_coin",
        symbol: "BNB",
        name: "Binance Coin",
        price: "$245",
        percentage: 1.91,
        image: "Coins/binance",
        data: .init(points: [0.0, -1.2, 1.1, 4.8, -5, 7])
    )

}
