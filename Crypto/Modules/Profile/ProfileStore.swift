//
//  ProfileStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct Profile {

    // MARK: - State

    struct State: Equatable {
        var user: User
        var trendingCurrencies: [Currency]
        var news: [Article]

        init() {
            user = User(name: "Denys", balance: "24600")
            trendingCurrencies = Currency.mocks
            news = Article.mocks
        }
    }

    // MARK: - Action

    enum Action: Equatable {
        case deposit
        case withdraw

        case openCurrencyDetails(Currency)

        case openArticle(Article)
        case showAllNews
    }

    // MARK: - Environment

    struct Environment { }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { _, action, _ in
        switch action {
        case .deposit:
            return .none
            
        case .withdraw:
            return .none

        case .openCurrencyDetails:
            return .none

        case .openArticle:
            return .none

        case .showAllNews:
            return .none
        }
    }

}
