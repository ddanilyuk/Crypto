//
//  AppStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct App {

    // MARK: - State

    struct State: Equatable {
        var appDelegate: AppDelegate.State = AppDelegate.State()
        var onboarding: Onboarding.State?
        var main: Main.State?

        mutating func set(_ currentState: CurrentState) {
            switch currentState {
            case .onboarding:
                self.main = nil
                self.onboarding = Onboarding.State()
            case .main:
                self.onboarding = nil
                self.main = Main.State()
            }
        }

        enum CurrentState {
            case onboarding
            case main
        }
    }

    // MARK: - Action

    enum Action: Equatable {
        case appDelegate(AppDelegate.Action)
        case onboarding(Onboarding.Action)
        case main(Main.Action)
    }

    // MARK: - Environment

    struct Environment {
        let userDefaultsService: UserDefaultsServiceable
        let networkService: NetworkService

        let userService: UserService
        let currencyService: CurrencyService
        let newsService: NewsService

        static var live: Self {
            let baseURL = URL(string: "https://plantin.com/api")!
            let userDefaultsService: UserDefaultsServiceable = .live()
            let networkService: NetworkService = .live(baseURL: baseURL)
            let userService: UserService = .mock // .live(networkService: networkService)
            let currencyService: CurrencyService = .mock // .live(networkService: networkService)
            let newsService: NewsService = .mock // .live(networkService: networkService)

            return Self(
                userDefaultsService: userDefaultsService,
                networkService: networkService,
                userService: userService,
                currencyService: currencyService,
                newsService: newsService
            )
        }
    }

    // MARK: - Reducer

    static var reducerCore = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .appDelegate(.didFinishLaunching):
            switch environment.userDefaultsService.get(for: .onboardingPassed) {
            case true:
                state.set(.main)
            case false:
                state.set(.onboarding)
            }
            return .none

        case .onboarding(.delegate(.onboardingPassed)):
            state.set(.main)
            return .none

        case .appDelegate:
            return .none

        case .onboarding:
            return .none

        case .main:
            return .none

        }
    }

    static var reducer = Reducer<State, Action, Environment>.combine(
        AppDelegate.reducer
            .pullback(
                state: \State.appDelegate,
                action: /Action.appDelegate,
                environment: { $0.appDelegate }
            ),
        Onboarding.reducer
            .optional()
            .pullback(
                state: \State.onboarding,
                action: /Action.onboarding,
                environment: { $0.onboarding }
            ),
        Main.reducer
            .optional()
            .pullback(
                state: \State.main,
                action: /Action.main,
                environment: { $0.main }
            ),
        reducerCore
    )

}

// MARK: App.Environment + Extensions

extension App.Environment {

    var appDelegate: AppDelegate.Environment {
        AppDelegate.Environment()
    }

    var onboarding: Onboarding.Environment {
        Onboarding.Environment(
            userDefaultsService: userDefaultsService
        )
    }

    var main: Main.Environment {
        Main.Environment(
            userService: userService,
            currencyService: currencyService,
            newsService: newsService
        )
    }

}
