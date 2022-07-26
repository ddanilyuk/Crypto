//
//  MainStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct Main {

    // MARK: - State

    struct State: Equatable {
        var profile: Profile.State
        var market: Market.State

        @BindableState var selectedTab: Tab

        enum Tab: Hashable {
            case profile
            case market
        }

        init() {
            profile = Profile.State()
            market = Market.State()

            selectedTab = .profile
        }
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case profile(Profile.Action)
        case market(Market.Action)

        case binding(BindingAction<State>)
    }

    // MARK: - Environment

    struct Environment {
        let userService: UserService
        let currencyService: CurrencyService
        let newsService: NewsService
    }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment>.combine(
        Profile.reducer
            .pullback(
                state: \State.profile,
                action: /Action.profile,
                environment: { $0.profile }
            ),
        Market.reducer
            .pullback(
                state: \State.market,
                action: /Action.market,
                environment: { $0.market }
            ),
        coreReducer
    )

    static let coreReducer = Reducer<State, Action, Environment> { _, action, _ in
        switch action {
        case .profile:
            return .none

        case .market:
            return .none

        case .binding:
            return .none
        }
    }
    .binding()

}

extension Main.Environment {

    var profile: Profile.Environment {
        Profile.Environment(
            userService: userService,
            currencyService: currencyService,
            newsService: newsService
        )
    }

    var market: Market.Environment {
        Market.Environment(
            currencyService: currencyService
        )
    }

}
