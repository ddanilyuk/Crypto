//
//  OnboardingView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {

    let store: Store<Onboarding.State, Onboarding.Action>

    var body: some View {
        WithViewStore(store) { _ in
            Text("Onboarding")
        }
    }

}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            OnboardingView(
                store: Store(
                    initialState: Onboarding.State(),
                    reducer: Onboarding.reducer,
                    environment: Onboarding.Environment(
                        userDefaultsService: .mock
                    )
                )
            )
        }
    }
    
}
