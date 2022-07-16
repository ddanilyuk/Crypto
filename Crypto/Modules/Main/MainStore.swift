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

    struct Environment { }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { _, action, _ in
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
