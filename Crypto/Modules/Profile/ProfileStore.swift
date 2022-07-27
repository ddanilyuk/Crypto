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
        @BindableState var userIsLoading: Bool = true
        @BindableState var trendingCurrenciesIsLoading: Bool = true
        @BindableState var newsIsLoading: Bool = true

        init() {
            user = User.redacted
            trendingCurrencies = Currency.redacted
            news = Article.redacted
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
            guard !state.isAlreadyAppeared else {
                return .none
            }
            state.isAlreadyAppeared = true
            return .merge(
                environment.userService.getMe()
                    .catchToEffect(Action.getMeResponse),

                environment.currencyService.getTrendingCurrencies()
                    .catchToEffect(Action.getTrendingResponse),

                environment.newsService.getNews()
                    .catchToEffect(Action.getNewsResponse)
            )

        case let .getMeResponse(.success(user)):
            state.user = user
            state.userIsLoading = false
            return .none

        case let .getTrendingResponse(.success(currencies)):
            state.trendingCurrencies = currencies
            state.trendingCurrenciesIsLoading = false
            return .none

        case let .getNewsResponse(.success(news)):
            state.news = news
            state.newsIsLoading = false
            return .none

        case let .getMeResponse(.failure(error)),
             let .getTrendingResponse(.failure(error)),
             let .getNewsResponse(.failure(error)):
            print(error)
            return .none

        case .deposit:
            print("Deposit")
            return .none
            
        case .withdraw:
            print("Withdraw")
            return .none

        case let .openCurrencyDetails(currency):
            print("Open currency details \(currency.symbol)")
            return .none

        case let .openArticle(article):
            print("Open article with title:\n\(article.title)")
            return .none

        case .showAllNews:
            print("ShowAllNews")
            return .none

        case .binding:
            return .none
        }
    }

}
