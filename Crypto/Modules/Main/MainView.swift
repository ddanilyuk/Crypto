//
//  MainView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {

    let store: Store<Main.State, Main.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(selection: viewStore.binding(\.$selectedTab)) {
                ProfileView(
                    store: store.scope(
                        state: \Main.State.profile,
                        action: Main.Action.profile
                    )
                )
                .tabItem {
                    viewStore.selectedTab == .profile
                    ? Asset.Images.TabBar.profileSelected.swiftUI
                    : Asset.Images.TabBar.profileUnselected.swiftUI
                }
                .tag(Main.State.Tab.profile)

                MarketView(
                    store: store.scope(
                        state: \Main.State.market,
                        action: Main.Action.market
                    )
                )
                .tabItem {
                    viewStore.selectedTab == .market
                    ? Asset.Images.TabBar.marketSelected.swiftUI
                    : Asset.Images.TabBar.marketUnselected.swiftUI
                }
                .tag(Main.State.Tab.market)
            }
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.backgroundColor = Asset.Colors.latinCharm.color
                UITabBar.appearance().standardAppearance = tabBarAppearance
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
            }
        }
    }

}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MainView(
                store: Store(
                    initialState: Main.State(),
                    reducer: Main.reducer,
                    environment: Main.Environment(
                        userService: .mock,
                        currencyService: .mock,
                        newsService: .mock
                    )
                )
            )
        }
    }
    
}
