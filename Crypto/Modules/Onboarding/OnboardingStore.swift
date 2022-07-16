//
//  OnboardingStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct Onboarding {

    // MARK: - State

    struct State: Equatable { }

    // MARK: - Action

    enum Action: Equatable {
        case start
    }

    // MARK: - Environment

    struct Environment {
        let userDefaultsService: UserDefaultsServiceable
    }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { _, action, _ in
        switch action {
        case .start:
            return .none
        }
    }

}
