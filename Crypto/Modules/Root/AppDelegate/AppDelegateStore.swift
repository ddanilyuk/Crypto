//
//  AppDelegateStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

extension AppDelegate {

    // MARK: - State

    struct State: Equatable { }

    // MARK: - Action

    enum Action: Equatable {
        case didFinishLaunching
    }

    // MARK: - Environment

    struct Environment { }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { _, action, _ in
        switch action {
        case .didFinishLaunching:
            return .none
        }
    }

}
