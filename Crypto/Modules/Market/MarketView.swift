//
//  MarketView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct MarketView: View {

    let store: Store<Market.State, Market.Action>

    var body: some View {
        WithViewStore(store) { _ in
            Text("Market")
        }
    }

}

// MARK: - Preview

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarketView(
                store: Store(
                    initialState: Market.State(),
                    reducer: Market.reducer,
                    environment: Market.Environment()
                )
            )
        }
    }
}
