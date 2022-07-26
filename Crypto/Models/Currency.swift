//
//  Currency.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation

extension Double {

    var priceString: String {
        "$ \(self)"
    }

}

struct Currency: Decodable, Identifiable, Equatable {

    let id: String
    let symbol: String
    let name: String
    let price: Double
    let percentage: Double
    let image: String

    let max24: Double
    let min24: Double
    let volume: Double

    let rank: Int
    let launchDate: Date

    // TODO: Change
    let data: ChartData

    var about: String = "From humble beginnings in 2008 to its 2021 price peak, Bitcoin (BTC) has taken investors and the world for quite the ride. In just over a decade, the first cryptocurrency has spiked and crashed and rallied and fallen again, over and over, on the way to a price in the tens of thousands. \nBitcoin is a decentralized peer-to-peer electronic exchange. Breaking it down, this means people can send money directly to one another without a bank or third party as an intermediary. Bitcoin was created so people don't have to rely on government or financial institutions to make financial transactions. Bitcoin allows users to transact amongst themselves using the Bitcoin blockchain, which relies on a proof-of-work method for tracking and verification of transactions.\nToday, Bitcoin is the world's most popular cryptocurrency, and some advocates believe that it could one day replace physical cash. While Bitcoin is not perfect, investors are optimistic about the developments that have been made since the crypto's inception. Bitcoin growth has rallied a fervent community that is excited about cryptocurrency's rise and the opportunities it will present for investors and businesses."

    var percentageString: String {
        String(format: "%.02f", percentage)
    }

}

// MARK: - Hashable

extension Currency: Hashable {

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
        price: 2_383.65,
        percentage: -4.91,
        image: "",
        max24: 2_400,
        min24: 2_000,
        volume: 3_400,
        rank: 2,
        launchDate: Date(),
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
        price: 2_383.65,
        percentage: -4.91,
        image: "Coins/etherium2",
        max24: 2_400,
        min24: 2_000,
        volume: 3_400,
        rank: 2,
        launchDate: Date(),
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

    static var trendingMock2 = Currency(
        id: "binance_coin",
        symbol: "BNB",
        name: "Binance Coin",
        price: 245,
        percentage: 1.91,
        image: "Coins/binance",
        max24: 250,
        min24: 240,
        volume: 100,
        rank: 25,
        launchDate: Date(),
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
        price: 245,
        percentage: -4.91,
        image: "Coins/etherium2",
        max24: 2_400,
        min24: 2_000,
        volume: 3_400,
        rank: 2,
        launchDate: Date(),
        data: .init(points: [0.0, 0.0, 1.1, 2.8, -1, -7])
    )

    static var allMock2 = Currency(
        id: "binance_coin",
        symbol: "BNB",
        name: "Binance Coin",
        price: 243,
        percentage: 1.91,
        image: "Coins/binance",
        max24: 250,
        min24: 240,
        volume: 100,
        rank: 25,
        launchDate: Date(),
        data: .init(points: [0.0, -1.2, 1.1, 4.8, -5, 7])
    )

}
