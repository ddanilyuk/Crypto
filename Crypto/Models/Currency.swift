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
// MARK: - Redacted

extension Currency {

    static var redacted: [Currency] = [
        redactedMock1
    ]

    static var redactedMock1 = Currency(
        id: "",
        symbol: "",
        name: String(repeating: " ", count: 10),
        price: "$2,383.65",
        percentage: -4.91,
        image: "",
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

}

// MARK: - Trending mocks

extension Currency {

    static var trendingMocks: [Currency] = [
        trendingMock1,
        trendingMock2,
    ]

    static var trendingMock1 = Currency(
        id: "etherium2",
        symbol: "ETH2",
        name: "Etherium 2",
        price: "$2,383.65",
        percentage: -4.91,
        image: "Coins/etherium2",
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

    static var trendingMock2 = Currency(
        id: "binance_coin",
        symbol: "BNB",
        name: "Binance Coin",
        price: "$245",
        percentage: 1.91,
        image: "Coins/binance",
        data: .init(points: [0.0, -1.2, 1.1, 4.8, -5, 7])
    )

}

// MARK: - All mocks

extension Currency {

    static var allMocks: [Currency] = [
        allMock1,
        allMock2,
    ]

    static var allMock1 = Currency(
        id: "etherium2",
        symbol: "ETH2",
        name: "Etherium 22222",
        price: "$2,383.65",
        percentage: -4.91,
        image: "Coins/etherium2",
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

    static var allMock2 = Currency(
        id: "binance_coin",
        symbol: "BNB",
        name: "Binance Coin",
        price: "$245",
        percentage: 1.91,
        image: "Coins/binance",
        data: .init(points: [0.0, -1.2, 1.1, 4.8, -5, 7])
    )

}
