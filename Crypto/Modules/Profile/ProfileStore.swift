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

        var isAlreadyAppeared: Bool = false
        var userIsRedacted: Bool = true
        var trendingCurrenciesIsRedacted: Bool = true
        var newsIsRedacted: Bool = true
        @BindableState var isLoading: Bool = false

        init() {
            user = User.mock
            trendingCurrencies = Currency.allMocks
            news = Article.mocks
        }
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case onAppear

        case deposit
        case withdraw

        case getMeResponse(Result<User, NetworkError>)
        case getTrendingResponse(Result<[Currency], NetworkError>)
        case getNewsResponse(Result<[Article], NetworkError>)

        case openCurrencyDetails(Currency)

        case openArticle(Article)
        case showAllNews

        case binding(BindingAction<State>)
    }

    // MARK: - Environment

    struct Environment {
        let userService: UserService
        let currencyService: CurrencyService
        let newsService: NewsService
    }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .onAppear:
            guard !isAlreadyAppeared else {
                return .none
            }
            isAlreadyAppeared = true
            return .concatenate(
                environment.userService.getMe()
                    .catchToEffect(Action.getMeResponse),

                environment.currencyService.getTrendingCurrencies()
                    .catchToEffect(Action.getTrendingResponse),

                environment.newsService.getNews()
                    .catchToEffect(Action.getNewsResponse)
            )

        case let .getMeResponse(.success(user)):
            state.user = user
            state.userIsRedacted = false
            return .none

        case let .getTrendingResponse(.success(currencies)):
            state.trendingCurrencies = currencies
            state.trendingCurrenciesIsRedacted = false
            return .none

        case let .getNewsResponse(.success(news)):
            state.news = news
            state.newsIsRedacted = false
            return .none

        case let .getMeResponse(.failure(error)),
             let .getTrendingResponse(.failure(error)),
             let .getNewsResponse(.failure(error)):
            print(error)
            return .none

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

        case .binding:
            return .none
        }
    }

}
