//
//  ProfileView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {

    let store: Store<Profile.State, Profile.Action>

    @Environment(\.safeAreaInsets) var safeAreaInsets

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(showsIndicators: false) {
                VStack {
                    WithViewStore(
                        store.scope(
                            state: \Profile.State.profileHeaderView,
                            action: Profile.Action.profileHeaderView
                        ),
                        content: ProfileHeaderView.init(viewStore:)
                    )
                    .redacted(reason: viewStore.userIsRedacted ? .placeholder : [])

                    WithViewStore(
                        store.scope(
                            state: \Profile.State.currenciesView,
                            action: Profile.Action.currenciesView
                        ),
                        content: CurrenciesView.init(viewStore:)
                    )
                    .redacted(reason: viewStore.trendingCurrenciesIsRedacted ? .placeholder : [])

                    WithViewStore(
                        store.scope(
                            state: \Profile.State.newsView,
                            action: Profile.Action.newsView
                        ),
                        content: NewsView.init(viewStore:)
                    )
                    .redacted(reason: viewStore.newsIsRedacted ? .placeholder : [])
                }
            }
            .loadable(viewStore.binding(\.$isLoading))
            .padding(.top, safeAreaInsets.top)
            .background(Asset.Colors.corbeau.swiftUIColor)
            .edgesIgnoringSafeArea(.top)
            .onAppear { viewStore.send(.onAppear) }
        }
    }

}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ProfileView(
                store: Store(
                    initialState: Profile.State(),
                    reducer: Profile.reducer,
                    environment: Profile.Environment(
                        userService: .mock,
                        currencyService: .mock,
                        newsService: .mock
                    )
                )
            )
        }
    }
    
}
