//
//  AppView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {

    let store: Store<App.State, App.Action>

    var body: some View {
        Group {
            IfLetStore(
                store.scope(
                    state: \App.State.onboarding,
                    action: App.Action.onboarding
                ),
                then: OnboardingView.init
            )
            IfLetStore(
                store.scope(
                    state: \App.State.main,
                    action: App.Action.main
                ),
                then: MainView.init
            )
        }
    }

}
