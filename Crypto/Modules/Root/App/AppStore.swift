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
                self.onboarding = Onboarding.State()
            case .main:
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
//        let networkService: NetworkService
//        let animalsService: AnimalsService
//        let kingfisherService: KingfisherService

        static var live: Self {
//            let baseURL = URL(string: "https://drive.google.com")!
            let userDefaultsService: UserDefaultsServiceable = .live()
//            let networkService: NetworkService = .live(baseURL: baseURL)
//            let animalsService: AnimalsService = .live(networkService: networkService)
//            let kingfisherService: KingfisherService = .live()

            return Self(
                userDefaultsService: userDefaultsService
//                networkService: networkService,
//                animalsService: animalsService,
//                kingfisherService: kingfisherService
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
//            kingfisherService: kingfisherService
        )
    }

    var main: Main.Environment {
        Main.Environment(
//            userDefaultsService: userDefaultsService
            //            kingfisherService: kingfisherService
        )
    }

}
