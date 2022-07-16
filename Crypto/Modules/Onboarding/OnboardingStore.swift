//
//  OnboardingStore.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import ComposableArchitecture

struct Onboarding {

    // MARK: - State

    struct State: Equatable {

        struct Step: Equatable, Identifiable, Hashable {
            let image: ImageAsset
            let title: String
            let description: String

            var id: String {
                title
            }

            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
        }

        let steps: [Step]
        @BindableState var selectedStep: Step

        init() {
            let onboardingSteps = [
                Step(
                    image: Asset.Images.Onboarding.step1,
                    title: "Easiness",
                    description: "Supplying the convenient transactions chains"
                ),
                Step(
                    image: Asset.Images.Onboarding.step2,
                    title: "Security",
                    description: "Providing crypto audience with high-tech security solutions"
                ),
                Step(
                    image: Asset.Images.Onboarding.step3,
                    title: "Transormation",
                    description: "Diversifying crypto investment experience worldwide"
                )
            ]
            steps = onboardingSteps
            selectedStep = onboardingSteps[0]
        }

    }

    // MARK: - Action

    enum Action: Equatable, BindableAction {
        case nextStep
        case delegate(Delegate)
        case binding(BindingAction<State>)

        enum Delegate {
            case onboardingPassed
        }
    }

    // MARK: - Environment

    struct Environment {
        let userDefaultsService: UserDefaultsServiceable
    }

    // MARK: - Reducer

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .nextStep:
            guard let currentIndex = state.steps.firstIndex(of: state.selectedStep) else {
                return .none
            }
            if let nextStep = state.steps[safe: currentIndex + 1] {
                state.selectedStep = nextStep
                return .none
            } else {
                environment.userDefaultsService.set(true, for: .onboardingPassed)
                return Effect(value: .delegate(.onboardingPassed))
            }

        case .delegate:
            return .none

        case .binding:
            return .none
        }
    }
    .binding()

}
