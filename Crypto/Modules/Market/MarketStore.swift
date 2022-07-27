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
        var currencies: [Currency]
        var isAlreadyAppeared = false
        @BindableState var isLoading = true
        @BindableState var selectedCurrencyDetails: CurrencyDetails.State?

        init() {
            currencies = Currency.redacted
        }
    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case onAppear

        case allCurrenciesResponse(Result<[Currency], NetworkError>)

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

    static let coreReducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .onAppear:
            guard !state.isAlreadyAppeared else {
                return .none
            }
            state.isAlreadyAppeared = true
            return environment.currencyService.getAllCurrencies()
                .catchToEffect(Action.allCurrenciesResponse)

        case let .allCurrenciesResponse(.success(currencies)):
            state.isLoading = false
            state.currencies = currencies
            return .none

        case let .allCurrenciesResponse(.failure(error)):
            print(error)
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
