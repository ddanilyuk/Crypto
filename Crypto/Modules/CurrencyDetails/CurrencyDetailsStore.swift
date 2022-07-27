//
//  CurrencyDetailsStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct CurrencyDetails {

    // MARK: - State

    struct State: Equatable {
        let currency: Currency

        @BindableState var showMore = false
        var pairLeftString: String = "0.0"
        var pairRightString: String = "0.0"

        var pairLeftSide: Double {
            Double(pairLeftString) ?? 0
        }

        var pairRightSide: Double {
            Double(pairRightString) ?? 0
        }
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case start

        case setPairLeftSide(String)
        case setPairRightSide(String)

        case buyButtonTapped
        case sellButtonTapped
        
        case binding(BindingAction<State>)
    }

    // MARK: - Environment

    struct Environment { }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { state, action, _ in
        switch action {
        case .start:
            return .none

        case let .setPairLeftSide(string):
            guard state.pairLeftString != string else {
                return .none
            }
            state.pairLeftString = string
            state.pairRightString = String(format: "%.02f", state.pairLeftSide * state.currency.price)
            return .none

        case let .setPairRightSide(string):
            guard state.pairRightString != string else {
                return .none
            }
            state.pairRightString = string
            state.pairLeftString = String(format: "%.02f", state.pairRightSide / state.currency.price)
            return .none

        case .buyButtonTapped:
            print("Buy \(state.pairLeftSide) \(state.currency.symbol) for \(state.pairRightSide) USD")
            return .none

        case .sellButtonTapped:
            print("Sell \(state.pairLeftSide) \(state.currency.symbol) for \(state.pairRightSide) USD")
            return .none

        case .binding:
            return .none
        }
    }
    .binding()

}
