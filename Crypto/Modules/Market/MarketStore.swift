//
//  MarketStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct Market {

    // MARK: - State

    struct State: Equatable {
        var currencies: [Currency] = Currency.allMocks
        @BindableState var selectedCurrencyDetails: CurrencyDetails.State?
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case start

        case openDetails(Currency)
        case selectedCurrencyDetails(CurrencyDetails.Action)
        case binding(BindingAction<State>)
    }

    // MARK: - Environment

    struct Environment {
        let currencyService: CurrencyService
    }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment>.combine(
        CurrencyDetails.reducer
            .optional()
            .pullback(
                state: \State.selectedCurrencyDetails,
                action: /Action.selectedCurrencyDetails,
                environment: { _ in CurrencyDetails.Environment() }
            ),
        coreReducer
    )

    static let coreReducer = Reducer<State, Action, Environment> { state, action, _ in
        switch action {
        case .start:
            return .none

        case let .openDetails(currency):
            state.selectedCurrencyDetails = CurrencyDetails.State(currency: currency)
            return .none
            
        case .selectedCurrencyDetails:
            return .none

        case .binding:
            return .none
        }
    }
    .binding()

}
