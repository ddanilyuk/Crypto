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

//        @BindableState var pairLeft: String = ""
//        @BindableState var pairRight: String = ""

        var pairLeftSide: Double = 0
        var pairRightSide: Double = 0


//        var buyPrice: Double {
//            currency.price * (Double(pairLeft) ?? 0)
//        }
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case start

        case setPairLeftSide(String)
        case setPairRightSide(String)
        
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
            print(string.trimmingCharacters(in: .punctuationCharacters))
            state.pairLeftSide = Double(string.trimmingCharacters(in: .punctuationCharacters)) ?? 0
            state.pairRightSide = state.pairLeftSide * state.currency.price
            return .none

        case let .setPairRightSide(string):
            state.pairRightSide = Double(string.trimmingCharacters(in: .punctuationCharacters)) ?? 0
            state.pairLeftSide = state.pairRightSide / state.currency.price
            return .none

//        case .binding(\.$pairLeft):
//            state.pairRight = String((Double(state.pairLeft) ?? 0) * state.currency.price)
//            return .none
//
//        case .binding(\.$pairRight):
//            state.pairLeft = String(state.buyPrice)
//            return .none

        case .binding:
            return .none
        }
    }
    .binding()

}
